#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/dma-mapping.h>
#include <asm/page.h>

#define CRYPTDMA_CMD_ALLOC 0
#define CRYPTDMA_CMD_FREE 1

struct miscdevice cryptdma_device;

static int cryptdma_cmd_alloc(void * __user *ptr_out, size_t pages, uintptr_t __user *physaddr) {
    dma_addr_t physaddr_inner;
    void *out = dma_alloc_coherent(cryptdma_device.this_device, pages * PAGE_SIZE, &physaddr_inner, GFP_USER);

    *physaddr = physaddr_inner;
    return out != NULL;
}
static int cryptdma_cmd_free(void *ptr, size_t pages, uintptr_t physaddr) {
    dma_free_coherent(cryptdma_device.this_device, pages * PAGE_SIZE, ptr, physaddr);
    return 0;
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

static ssize_t cryptdma_ioctl(struct file *file, unsigned cmd, unsigned long args)
{
    size_t *aargs = (size_t *)args;
    switch (cmd) {
        case CRYPTDMA_CMD_ALLOC:
            return cryptdma_cmd_alloc((void **)aargs[0], aargs[1], (size_t *)aargs[2]);
        case CRYPTDMA_CMD_FREE:
            return cryptdma_cmd_free((void *)aargs[0], aargs[1], aargs[2]);
    }
    return -1;
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
