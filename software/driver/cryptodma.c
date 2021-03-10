#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/dma-mapping.h>
#include <linux/slab.h>
#include <linux/uaccess.h>
#include <asm/page.h>

#define CRYPTDMA_CMD_MAP 0
#define CRYPTDMA_CMD_UNMAP 1

struct miscdevice cryptdma_device;

typedef struct dma_mapping {
    uintptr_t physaddr;
    struct page *page;
    struct dma_mapping *next;
} dma_mapping_t;
dma_mapping_t *mappings = NULL;

static int cryptdma_cmd_map(void __user *page, uintptr_t __user *physaddr) {
    int err = 0;
    dma_mapping_t *new_mapping = (dma_mapping_t *)kmalloc(sizeof *new_mapping, GFP_KERNEL);
    err = !new_mapping;
    if (err) goto alloc_err;

    struct vm_area_struct *vmas;
    uintptr_t page_addr = (uintptr_t)page & ~(PAGE_SIZE - 1);
    err = pin_user_pages(page_addr, 1, FOLL_LONGTERM | FOLL_PIN, &new_mapping->page, &vmas);
    if (err) goto pin_err;

    err = dma_map_single(cryptdma_device.this_device, (void *)page_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
    if (err) goto map_err;
    
    new_mapping->next = mappings;
    mappings = new_mapping;
    return 0;

map_err:
    unpin_user_pages(&new_mapping->page, 1);
pin_err:
alloc_err:
    return err;
}

static int cryptdma_cmd_unmap(uintptr_t physaddr) {
    int err = 0;
    dma_mapping_t *found = NULL;
    for (dma_mapping_t **m = &mappings; *m != NULL; m = &(*m)->next) {
        if ((*m)->physaddr == physaddr) {
            found = *m;
            *m = (*m)->next;
        }
    }
    err = !found;
    if (err) goto bad_addr;

    unpin_user_pages(&found->page, 1);
    kfree(found);
    return 0;

bad_addr:
    return err;
}


static int cryptdma_open(struct inode *inode, struct file *file)
{
    return 0;
}

static int cryptdma_close(struct inode *inodep, struct file *filp)
{
    return 0;
}

static ssize_t cryptdma_write(struct file *file, const char __user *buf,
        size_t len, loff_t *ppos)
{
    return 0; 
}

static ssize_t cryptdma_read(struct file *file, char __user *buf,
        size_t len, loff_t *ppos)
{
    return 0;
}

static ssize_t cryptdma_ioctl(struct file *file, unsigned cmd, unsigned long args_ptr)
{
    int err = 0;
    switch (cmd) {
        case CRYPTDMA_CMD_MAP: {
            struct { void __user *ptr; uintptr_t *paddr_out; } args;
            err = copy_from_user(&args, (void *)args_ptr, sizeof args);
            if (err) goto copy_err;
            err = cryptdma_cmd_map(args.ptr, args.paddr_out);
            return 0;
        }
        case CRYPTDMA_CMD_UNMAP: {
            struct { uintptr_t paddr; } args;
            err = copy_from_user(&args, (void *)args_ptr, sizeof args);
            if (err) goto copy_err;
            err = cryptdma_cmd_unmap(args.paddr);
            return 0;
        }
    }
    err = -1; // command not found
copy_err:
    return err;
}


static const struct file_operations cryptdma_fops = {
    .owner           = THIS_MODULE,
    .open            = cryptdma_open,
    .release         = cryptdma_close,
    .write           = cryptdma_write,
    .read            = cryptdma_read,
    .unlocked_ioctl  = cryptdma_ioctl,
};

struct miscdevice cryptdma_device = {
    .minor = MISC_DYNAMIC_MINOR,
    .name = "cryptdma",
    .fops = &cryptdma_fops,
};

static int __init cryptdma_init(void)
{
    int error;

    error = misc_register(&cryptdma_device);
    if (error) {
        pr_err("Unable to register CryptDMA Driver\n");
        return error;
    }

    pr_info("Registered CryptDMA Driver\n");
    return 0;
}

static void __exit cryptdma_exit(void)
{
    misc_deregister(&cryptdma_device);
    pr_info("Deregister CryptDMA Driver\n");
}

module_init(cryptdma_init)
module_exit(cryptdma_exit)

MODULE_DESCRIPTION("DMA Driver for PolarFire crypto soft-IP");
MODULE_AUTHOR("Gui Andrade <gh@archshift.com>");
MODULE_LICENSE("BSD3");
