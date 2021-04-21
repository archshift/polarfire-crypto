#![cfg_attr(not(feature = "use_std"), no_std)]

mod crypt;
pub use crypt::{crypt, crypt_ppage, init};

use core::slice;

#[no_mangle]
pub unsafe extern fn c_crypt(key: &[u8; 32], ctr: &[u8; 16], dat_in: *const u8, dat_out: *mut u8, len: usize) {
    crypt(*key, *ctr, slice::from_raw_parts(dat_in, len), slice::from_raw_parts_mut(dat_out, len))
}

#[no_mangle]
pub unsafe extern fn c_crypt_ppage(key: &[u8; 32], ctr: &[u8; 16], data: &[u64; 512], data_out: &mut [u64; 512],
    pa: extern fn(usize) -> usize) -> i32 {
    match crypt_ppage(*key, *ctr, data, data_out, pa) {
        Ok(()) => 0,
        Err(()) => -1,
    }
}

#[no_mangle]
pub unsafe extern fn c_crypt_init() {
    init();
}



#[cfg(feature = "use_std")]
pub(crate) use std::println;

#[cfg(not(feature = "use_std"))]
use core::{
    fmt::{
        Error as FmtError, Write
    },
    panic::PanicInfo,
};

#[cfg(not(feature = "use_std"))]
#[macro_export]
macro_rules! println {
    ($($tok:tt)*) => {{
        use core::fmt::Write;
        writeln!(crate::DbgWriter, $($tok)*).unwrap()
    }};
}

#[cfg(not(feature = "use_std"))]
pub(crate) struct DbgWriter;
#[cfg(not(feature = "use_std"))]
impl Write for DbgWriter {
    fn write_str(&mut self, s: &str) -> Result<(), FmtError> {
        for c in s.bytes() {
            extern {
                fn putchar(c: u8);
            }
            unsafe {
                putchar(c);
            }
        }
        Ok(())
    }
}

#[cfg_attr(not(feature = "use_std"), panic_handler)]
#[cfg(not(feature = "use_std"))]
fn panic(info: &PanicInfo) -> ! {
    println!("{}", info);
    extern {
        fn abort() -> !;
    }
    unsafe {
        abort();
    }
}
