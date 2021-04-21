mod crypt;

use std::{str, u8};
use std::io::{Read, stdin, BufReader, BufRead};
use std::fs::File;
use std::{fs::OpenOptions, mem::size_of};
use memmap::{MmapMut, MmapOptions};

fn hex_to_bytes(hex: String, out: &mut [u8]) {
    let new_hex = hex.replace(" ", "");
    let hex = new_hex.trim();

    let bytes = hex.as_bytes()
        .chunks_exact(2)
        .map(|c| u8::from_str_radix(
                str::from_utf8(c).expect("UTF-8 error!"),
                16)
                .expect("Byte parsing error!"));
    
    for (dst, src) in out.iter_mut().zip(bytes) {
        *dst = src;
    }
}

struct HexRowPrinter {
    seek: usize
}
impl HexRowPrinter {
    fn new() -> Self { Self { seek: 0 } }

    fn append(&mut self, mut bytes: &[u8]) {
        while bytes.len() != 0 {
            print!("{:02x}", bytes[0]);
            if self.seek % 40 == 39 {
                print!("\n");
            } else if self.seek % 4 == 3 {
                print!(" ");
            }
            bytes = &bytes[1..];
            self.seek += 1;
        }
    }
}

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

    hex_to_bytes(key_str, &mut key);
    hex_to_bytes(ctr_str, &mut ctr);

    let stdin = stdin();
    let stdin = stdin.lock();
    let mut stdin = BufReader::new(stdin);
    let mut output = vec![0; stdin.capacity()];
    let mut printer = HexRowPrinter::new();
    
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
