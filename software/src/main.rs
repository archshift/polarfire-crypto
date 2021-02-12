use std::{iter, u32};
use std::fs::OpenOptions;

use bitutils::bf;
use memmap::{MmapMut, MmapOptions};

#[derive(Copy, Clone, Debug)]
enum AesReg {
    Ctrl = 0,
    IFifo = 1,
    OFifo = 2,
    Ctr = 4,
    Key = 8
}

const fn aes_reg_mut(offs: AesReg) -> *mut u32 {
    const AES_BASE: usize = 0x60010000;
    (AES_BASE as usize + (offs as usize) * 4) as *mut u32
}
const fn aes_reg(offs: AesReg) -> *const u32 {
    aes_reg_mut(offs)
}

const AES_CTRL: *mut u32 = aes_reg_mut(AesReg::Ctrl);
const AES_IFIFO: *mut u32 = aes_reg_mut(AesReg::IFifo);
const AES_OFIFO: *const u32 = aes_reg(AesReg::OFifo);
const AES_CTR: *mut u32 = aes_reg_mut(AesReg::Ctr);
const AES_KEY: *mut u32 = aes_reg_mut(AesReg::Key);

bf!(AesCtrl[u32] {
    reset : 31:31,
    ofifo_empty : 2:2,
    ififo_full : 1:1,
    busy : 0:0
});

type Key = [u32; 8];
type Ctr = [u32; 4];
type Block = [u32; 4];

unsafe fn write_key(key: Key) {
    for i in 0..8 {
        AES_KEY.add(i).write_volatile(key[i]);
    }
}
unsafe fn write_ctr(ctr: [u32; 4]) {
    for i in 0..4 {
        AES_CTR.add(i).write_volatile(ctr[i]);
    }
}
fn take_word(data: &mut impl Iterator<Item=u8>) -> Option<u32> {
    let array = [data.next()?, data.next()?, data.next()?, data.next()?];
    Some(u32::from_le_bytes(array))
}
unsafe fn write_block(data: &mut impl Iterator<Item=u8>) -> Option<()> {
    let mut block = data.take(16);
    for i in 0..4 {
        AES_IFIFO.write_volatile(take_word(&mut block)?);
    }
    Some(())
}
unsafe fn read_block() -> Block {
    [
        AES_OFIFO.read_volatile(),
        AES_OFIFO.read_volatile(),
        AES_OFIFO.read_volatile(),
        AES_OFIFO.read_volatile()
    ]
}
unsafe fn read_write_block(data: &mut impl Iterator<Item=u8>) -> Option<Block> {
    let ctr = AesCtrl::new(AES_CTRL.read_volatile());
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

fn crypt(key: Key, ctr: Ctr, data: &[u8]) {
    unsafe {
        write_key(key);
        write_ctr(ctr);
    }
    let data_blocks = (data.len() + 15) / 16;
    let data_padding = data_blocks * 16 - data.len();
    let mut padded_data = data.iter().copied()
        .chain(iter::repeat(0u8).take(data_padding));

    while let Some(block) = unsafe { read_write_block(&mut padded_data) } {}
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

fn main() {
}
