use std::{fs::OpenOptions, mem::size_of};

use bitutils::bf;
use memmap::{MmapMut, MmapOptions};

use crate::crypt::{Key, Ctr, Block};

type Word = u64;
const WORD_SIZE: usize = size_of::<Word>();
const KEY_WORDS: usize = size_of::<Key>() / WORD_SIZE;
const BLOCK_WORDS: usize = size_of::<Block>() / WORD_SIZE;

#[derive(Copy, Clone, Debug)]
enum AesReg {
    Ctrl = 0,
    Fifo = 1,
    Ctr = 2,
    Key = 4
}

fn io_ptr() -> *mut Word {
    let p = unsafe { MMAP_IO.as_mut().unwrap().as_mut_ptr() };
    p as *mut Word
}

fn wr_reg(reg: AesReg, woffs: usize, dat: Word) {
    assert!(woffs < 0x10000 / WORD_SIZE);
    unsafe {
        let ptr = io_ptr().add(reg as usize).add(woffs);
        ptr.write_volatile(dat);
    }
}
fn rd_reg(reg: AesReg, woffs: usize) -> Word {
    assert!(woffs < 0x10000 / WORD_SIZE);
    unsafe {
        let ptr = io_ptr().add(reg as usize).add(woffs);
        ptr.read_volatile()
    }
}

bf!(AesCtrl[Word] {
    reset : 31:31,
    auto_increment : 30:30,
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
            Some(read_block())
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

fn map() -> MmapMut {
    let memfile = OpenOptions::new()
        .read(true)
        .write(true)
        .open("/dev/mem")
        .expect("Failed to open /dev/mem!");

    unsafe {
        MmapOptions::new()
            .offset(0x60010000)
            .len(0x10000)
            .map_mut(&memfile)
            .expect("Failed to map AES MMIO!")
    }
}

static mut MMAP_IO: Option<MmapMut> = None;
pub fn init() {
    unsafe {
        MMAP_IO = Some(map());
    }
    let mut init_ctrl = AesCtrl::new(0);
    init_ctrl.set_reset(1);
    wr_reg(AesReg::Ctrl, 0, init_ctrl.val);

    init_ctrl.set_reset(0);
    init_ctrl.set_auto_increment(1);
    wr_reg(AesReg::Ctrl, 0, init_ctrl.val);
}
