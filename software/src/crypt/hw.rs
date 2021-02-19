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
        ptr.write_volatile(dat);
    }
}
fn rd_reg(reg: AesReg, woffs: usize) -> u32 {
    assert!(woffs < 0x10000 / 4);
    unsafe {
        let ptr = io_ptr().add(reg as usize).add(woffs);
        ptr.read_volatile()
    }
}

bf!(AesCtrl[u32] {
    reset : 31:31,
    ififo_full : 2:2,
    ofifo_empty : 1:1,
    busy : 0:0
});

fn write_key(key: Key) {
    for i in 0..8 {
        wr_reg(AesReg::Key, i, key[i]);
    }
}
fn write_ctr(ctr: [u32; 4]) {
    for i in 0..4 {
        wr_reg(AesReg::Ctr, i, ctr[i]);
    }
}
fn take_word(data: &[u8]) -> u32 {
    let mut array = [0; 4];
    let len = 4.min(data.len());
    array[..len].copy_from_slice(&data[..len]);
    u32::from_le_bytes(array)
}
fn write_block(data: &[u8]) -> usize {
    let len = 16.min(data.len());
    for i in 0..4 {
        if let Some(sl) = data.get(i*4 ..) {
            wr_reg(AesReg::IFifo, 0, take_word(sl));
        } else {
            wr_reg(AesReg::IFifo, 0, 0);
        }
    }
    len
}
fn read_block() -> Block {
    [
        rd_reg(AesReg::OFifo, 0),
        rd_reg(AesReg::OFifo, 0),
        rd_reg(AesReg::OFifo, 0),
        rd_reg(AesReg::OFifo, 0)
    ]
}
fn read_write_block(data: &mut &[u8]) -> Option<Block> {
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
            write_block(data);
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
            for word in block.iter() {
                if data_out.len() == 0 { break 'outer }

                let bytes_left = 4.min(data_out.len());
                data_out[..bytes_left].copy_from_slice(&word.to_le_bytes()[..bytes_left]);
                data_out = &mut data_out[bytes_left..];
            }
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
}