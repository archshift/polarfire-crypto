mod crypt;
pub use crypt::{crypt, init};

use std::slice;

#[no_mangle]
pub unsafe extern fn c_crypt(key: &[u32; 8], ctr: &[u32; 4], dat_in: *const u8, dat_out: *mut u8, len: usize) {
    crypt(*key, *ctr, slice::from_raw_parts(dat_in, len), slice::from_raw_parts_mut(dat_out, len))
}

#[no_mangle]
pub unsafe extern fn c_crypt_init() {
    init();
}