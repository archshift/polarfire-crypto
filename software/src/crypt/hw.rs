use core::mem::size_of;
use core::ptr::{self, NonNull};
use core::sync::atomic::{fence, Ordering};

use byte_slice_cast::*;
use bitutils::bf;

use crate::println;
use crate::crypt::{Key, Ctr, Block};

type Word = u64;
const WORD_SIZE: usize = size_of::<Word>();
const KEY_WORDS: usize = size_of::<Key>() / WORD_SIZE;
const BLOCK_WORDS: usize = size_of::<Block>() / WORD_SIZE;
const PAGE_WORDS: usize = 4096 / WORD_SIZE;

#[derive(Copy, Clone, Debug)]
enum AesReg {
    Ctrl = 0,
    Ctr = 2,
    Key = 4,
    Fifo = 0x200,
}

fn io_ptr() -> NonNull<Word> {
    unsafe { MMAP_IO.unwrap() }
}

fn wr_reg(reg: AesReg, woffs: usize, dat: Word) {
    assert!(woffs < 0x10000 / WORD_SIZE);
    unsafe {
        let ptr = io_ptr().as_ptr().add(reg as usize).add(woffs);
        ptr.write_volatile(dat);
    }
}
fn rd_reg(reg: AesReg, woffs: usize) -> Word {
    assert!(woffs < 0x10000 / WORD_SIZE);
    unsafe {
        let ptr = io_ptr().as_ptr().add(reg as usize).add(woffs);
        ptr.read_volatile()
    }
}

bf!(AesCtrl[Word] {
    reset : 63:63,
    auto_increment : 62:62,
    ififo_full : 2:2,
    ofifo_empty : 1:1,
    busy : 0:0
});

fn take_word(data: &[u8]) -> Word {
    let mut array = [0; WORD_SIZE];
    let len = WORD_SIZE.min(data.len());
    array[..len].copy_from_slice(&data[..len]);
    u64::from_le_bytes(array)
}
fn write_key(key: Key) {
    for i in 0..KEY_WORDS {
        let word = take_word(&key[i*WORD_SIZE..]);
        wr_reg(AesReg::Key, i, word);
    }
}
fn write_ctr(ctr: Ctr) {
    for i in 0..BLOCK_WORDS {
        let word = take_word(&ctr[i*WORD_SIZE..]);
        wr_reg(AesReg::Ctr, i, word);
    }
}
fn write_block(data: &[u8]) -> usize {
    let len = 16.min(data.len());
    for i in 0..BLOCK_WORDS {
        if let Some(sl) = data.get(i*WORD_SIZE..) {
            wr_reg(AesReg::Fifo, 0, take_word(sl));
        } else {
            wr_reg(AesReg::Fifo, 0, 0);
        }
    }
    len
}
fn read_block() -> Block {
    let mut out = Block::default();
    for i in 0..BLOCK_WORDS {
        let word = rd_reg(AesReg::Fifo, 0);
        out[i*WORD_SIZE .. (i+1)*WORD_SIZE]
            .copy_from_slice(&word.to_le_bytes());
    }
    out
}
fn read_write_block(data: &mut &[u8]) -> Option<Block> {
    let ctr = AesCtrl::new(rd_reg(AesReg::Ctrl, 0));
    match (ctr.ofifo_empty(), ctr.ififo_full()) {
        (0, 0) => {
            let written = write_block(data);
            *data = &data[written..];
            Some(read_block())
        }
        (0, 1) => {
            Some(read_block())
        }
        (1, 0) => {
            let written = write_block(data);
            *data = &data[written..];
            None
        }
        (1, 1) => {
            None
        }
        _ => unreachable!()
    }
}

fn drain_fifo() {
    while {
        let ctr = AesCtrl::new(rd_reg(AesReg::Ctrl, 0));
        ctr.ofifo_empty() == 0 || ctr.busy() == 1
    } {
        read_block();
    }
}

pub fn crypt(key: Key, ctr: Ctr, mut data: &[u8], mut data_out: &mut [u8]) {
    write_key(key);
    write_ctr(ctr);

    drain_fifo();
    'outer: loop {
        if let Some(block) = read_write_block(&mut data) {
            if data_out.len() == 0 { break 'outer }

            let bytes_left = block.len().min(data_out.len());
            data_out[..bytes_left].copy_from_slice(&block[..bytes_left]);
            data_out = &mut data_out[bytes_left..];
        }
    }
    drain_fifo();
}

pub fn crypt_ppage(key: Key, ctr: Ctr, data: &[u64; PAGE_WORDS], data_out: &mut [u64; PAGE_WORDS],
        pa: extern fn(usize) -> usize) -> Result<(), ()> {
    write_key(key);
    write_ctr(ctr);

    drain_fifo();
    fence(Ordering::SeqCst);
    
    let psrc = pa(data.as_ptr() as usize);
    let pdst = pa(data_out.as_ptr() as usize);
    let data_out = data_out.as_mut_byte_slice();
    assert!((psrc | pdst) & 0xFFF == 0);

    
    let x_size = 128;
    for xfoffs in (0..0x1000).step_by(x_size) {
        let _dma_to = dma_start(0x60011000, psrc + xfoffs, x_size)?;

        for blkoffs in (0..x_size).step_by(size_of::<Block>()) {
            while
               AesCtrl::new(rd_reg(AesReg::Ctrl, 0))
                    .ofifo_empty() == 1
            {}

            let block = read_block();
            data_out[xfoffs + blkoffs .. xfoffs + blkoffs + block.len()]
                .copy_from_slice(&block);
        }
    }

    drain_fifo();
    Ok(())
}

extern {
    fn aes_map_mmio() -> Option<NonNull<Word>>;
    fn dma_map_mmio() -> Option<NonNull<Word>>;
}

static mut MMAP_IO: Option<NonNull<Word>> = None;
static mut DMA_IO: Option<NonNull<Word>> = None;
pub fn init() {
    unsafe {
        MMAP_IO = aes_map_mmio();
        DMA_IO = dma_map_mmio();
    }
    let mut init_ctrl = AesCtrl::new(0);
    init_ctrl.set_reset(1);
    wr_reg(AesReg::Ctrl, 0, init_ctrl.val);

    init_ctrl.set_reset(0);
    init_ctrl.set_auto_increment(1);
    wr_reg(AesReg::Ctrl, 0, init_ctrl.val);
}



bf!(DmaCtrl[u32] {
    claim: 0:0,
    run: 1:1,
    done: 30:30,
    error: 31:31
});
bf!(DmaCfg[u32] {
    repeat: 2:2,
    order: 3:3,
    wsize: 24:27,
    rsize: 28:31
});

#[repr(C)]
struct DmaClaim {
    channel: *mut u8
}
impl DmaClaim {
    fn new(channel: *mut u8) -> Option<Self> {
        unsafe {
            let r_ctrl = channel.add(0x0) as *mut u32;
            let mut ctrl = DmaCtrl::new(r_ctrl.read_volatile());
            if ctrl.claim() == 1 {
                None
            } else {
                // Small chance of racing?
                ctrl.set_claim(1);
                r_ctrl.write_volatile(ctrl.val);
                Some(Self { channel })
            }
        }
    }

    fn done(&self) -> bool {
        unsafe {
            let r_ctrl = self.channel.add(0x0) as *mut u32;
            let ctrl = DmaCtrl::new(r_ctrl.read_volatile());
            assert!(ctrl.error() == 0);
            ctrl.done() == 1
        }
    }
}
impl Drop for DmaClaim {
    fn drop(&mut self) {
        unsafe {
            let r_ctrl = self.channel.add(0x0) as *mut u32;
            let mut ctrl = DmaCtrl::new(0);
            ctrl.set_claim(0);
            r_ctrl.write_volatile(ctrl.val);
        }
    }
}

fn dma_start(dst: usize, src: usize, bytes: usize) -> Result<DmaClaim, ()> {
    let mut channels = [ptr::null_mut(); 4];
    for i in 0..4 {
        channels[i] = unsafe { (DMA_IO.unwrap().as_ptr() as *mut u8).add(i * 0x1000) };
    }

    let found_claim = channels.iter().copied().filter_map(DmaClaim::new).next();

    if let Some(claim) = found_claim {
        unsafe {
            let channel = claim.channel;

            let r_ctrl = channel.add(0x0) as *mut u32;
            let r_next_config = channel.add(0x4) as *mut u32;
            let r_next_bytes = channel.add(0x8) as *mut u64;
            let r_next_dst = channel.add(0x10) as *mut u64;
            let r_next_src = channel.add(0x18) as *mut u64;

            // We have the claim
            let mut next_config = DmaCfg::new(0);
            next_config.set_wsize(3);
            next_config.set_rsize(3);
            r_next_config.write_volatile(next_config.val);

            r_next_bytes.write_volatile(bytes as u64);
            r_next_dst.write_volatile(dst as u64);
            r_next_src.write_volatile(src as u64);

            // Start running the DMA
            let mut ctrl = DmaCtrl::new(r_ctrl.read_volatile());
            ctrl.set_run(1);
            r_ctrl.write_volatile(ctrl.val);
        }
        Ok(claim)
    } else {
        Err(())
    }
}
