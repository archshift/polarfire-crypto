#[cfg(not(feature = "sw"))]
mod hw;
#[cfg(feature = "sw")]
mod sw;

#[cfg(not(feature = "sw"))]
use crate::crypt::hw as crypt_impl;
#[cfg(feature = "sw")]
use crate::crypt::sw as crypt_impl;

pub type Key = [u32; 8];
pub type Ctr = [u32; 4];
pub type Block = [u32; 4];

pub fn init() {
    crypt_impl::init();
}

pub fn crypt(key: Key, ctr: Ctr, data: &[u8], data_out: &mut [u8]) {
    crypt_impl::crypt(key, ctr, data, data_out);
}