use std::iter;
use std::fs::OpenOptions;

use bitutils::bf;
use memmap::{MmapMut, MmapOptions};

use crate::crypt::{Key, Ctr, Block};

#[derive(Copy, Clone, Debug)]
enum AesReg {
    Ctrl = 0,
    IFifo = 1,
    OFifo = 2,
    Ctr = 4,
    Key = 8
}

fn io_ptr() -> *mut u32 {
    let p = unsafe { MMAP_IO.as_mut().unwrap().as_mut_ptr() };
    p as *mut u32
}

fn wr_reg(reg: AesReg, woffs: usize, dat: u32) {
    assert!(woffs < 0x10000 / 4);
    unsafe {
        let ptr = io_ptr().add(reg as usize).add(woffs);
        *ptr = dat;
    }
}
fn rd_reg(reg: AesReg, woffs: usize) -> u32 {
    assert!(woffs < 0x10000 / 4);
    unsafe {
        let ptr = io_ptr().add(reg as usize).add(woffs);
        *ptr
    }
}

bf!(AesCtrl[u32] {
    reset : 31:31,
    ofifo_empty : 2:2,
    ififo_full : 1:1,
    busy : 0:0
});

unsafe fn write_key(key: Key) {
    for i in 0..8 {
        wr_reg(AesReg::Key, i, key[i]);
    }
}
unsafe fn write_ctr(ctr: [u32; 4]) {
    for i in 0..4 {
        wr_reg(AesReg::Ctr, i, ctr[i]);
    }
}
fn take_word(data: &mut impl Iterator<Item=u8>) -> Option<u32> {
    let array = [data.next()?, data.next()?, data.next()?, data.next()?];
    Some(u32::from_le_bytes(array))
}
unsafe fn write_block(data: &mut impl Iterator<Item=u8>) -> Option<()> {
    let mut block = data.take(16);
    for _ in 0..4 {
        wr_reg(AesReg::IFifo, 0, take_word(&mut block)?);
    }
    Some(())
}
unsafe fn read_block() -> Block {
    [
        rd_reg(AesReg::OFifo, 0),
        rd_reg(AesReg::OFifo, 0),
        rd_reg(AesReg::OFifo, 0),
        rd_reg(AesReg::OFifo, 0)
    ]
}
unsafe fn read_write_block(data: &mut impl Iterator<Item=u8>) -> Option<Block> {
    let ctr = AesCtrl::new(rd_reg(AesReg::Ctrl, 0));
    match (ctr.ofifo_empty(), ctr.ififo_full()) {
        (0, 0) => {
            write_block(data);
            Some(read_block())
        }
        (0, 1) => {
            Some(read_block())
        }
        (1, 0) => {
            if write_block(data).is_none() && ctr.busy() == 0 {
                None
            } else {
                Some(read_block())
            }
        }
        (1, 1) => {
            Some(read_block())
        }
        _ => unreachable!()
    }
}

pub fn crypt(key: Key, ctr: Ctr, data: &[u8], data_out: &mut [u8]) {
    unsafe {
        write_key(key);
        write_ctr(ctr);
    }
    let data_blocks = (data.len() + 15) / 16;
    let data_padding = data_blocks * 16 - data.len();
    let mut padded_data = data.iter().copied()
        .chain(iter::repeat(0u8).take(data_padding));

    while let Some(block) = unsafe { read_write_block(&mut padded_data) } {
        for word in block.iter() {
            data_out[..4].copy_from_slice(&word.to_le_bytes());
        }
    }
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
}