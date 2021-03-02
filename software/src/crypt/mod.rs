#[cfg(not(feature = "sw"))]
mod hw;
#[cfg(feature = "sw")]
mod sw;

#[cfg(not(feature = "sw"))]
use crate::crypt::hw as crypt_impl;
#[cfg(feature = "sw")]
use crate::crypt::sw as crypt_impl;

pub type Key = [u8; 32];
pub type Ctr = [u8; 16];
pub type Block = [u8; 16];

pub fn init() {
    crypt_impl::init();
}

pub fn crypt(key: Key, ctr: Ctr, data: &[u8], data_out: &mut [u8]) {
    crypt_impl::crypt(key, ctr, data, data_out);
}