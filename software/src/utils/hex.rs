use core::str;
use itertools::Itertools;
use crate::print;

pub fn hex_to_bytes(hex: &str, out: &mut [u8]) {
    let hex_bchar = hex.bytes();
    let hex = hex_bchar
        .filter(|c| *c != b' ' && *c != b'\n' && *c != b'\t' && *c != b'\r');

    let bytes = hex
        .tuples::<(_, _)>()
        .map(|(n1, n2)| [n1, n2])
        .map(|c| u8::from_str_radix(
                str::from_utf8(&c).expect("UTF-8 error!"),
                16)
                .expect("Byte parsing error!"));
    
    for (dst, src) in out.iter_mut().zip(bytes) {
        *dst = src;
    }
}

pub struct HexRowPrinter {
    seek: usize
}
impl HexRowPrinter {
    pub fn new() -> Self { Self { seek: 0 } }

    pub fn append(&mut self, mut bytes: &[u8]) {
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