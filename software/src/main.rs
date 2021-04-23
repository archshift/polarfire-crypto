mod crypt;
mod utils;
pub(crate) use std::{print, println};

use std::u8;
use std::io::{Read, stdin, BufReader, BufRead};
use std::fs::File;
use std::fs::OpenOptions;
use memmap::{MmapMut, MmapOptions};

fn main() {
    let mut key_str = String::new();
    let mut ctr_str = String::new();

    File::open("key.hex")
        .expect("Failed to open key!")
        .read_to_string(&mut key_str)
        .expect("Failed to read key!");
    File::open("ctr.hex")
        .expect("Failed to open ctr!")
        .read_to_string(&mut ctr_str)
        .expect("Failed to read ctr!");

    unsafe {
        MMAP_IO = Some(map());
    }

    let mut key = [0u8; 32];
    let mut ctr = [0u8; 16];

    utils::hex::hex_to_bytes(&key_str, &mut key);
    utils::hex::hex_to_bytes(&ctr_str, &mut ctr);

    let stdin = stdin();
    let stdin = stdin.lock();
    let mut stdin = BufReader::new(stdin);
    let mut output = vec![0; stdin.capacity()];
    let mut printer = utils::hex::HexRowPrinter::new();
    
    while let Ok(input) = stdin.fill_buf() {
        let in_len = input.len();
        if in_len == 0 { break }
        let output_sl = &mut output[..in_len];

        crypt::init();
        crypt::crypt(key, ctr, input, output_sl);

        // Print output in word columns; 10 words per row. 
        printer.append(output_sl);
        
        stdin.consume(in_len);
    }

    println!();
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
#[no_mangle]
pub extern fn aes_map_mmio() -> *mut u8 {
    unsafe { MMAP_IO.as_mut().unwrap().as_mut_ptr() }
}
#[no_mangle]
pub extern fn dma_map_mmio() -> usize {
    0
}
