use std::mem::transmute;
use aes_ctr::{
    Aes256Ctr,
    cipher::stream::{
        NewStreamCipher, SyncStreamCipher
    }
};

use crate::crypt::{Key, Ctr};

pub fn init() {}

pub fn crypt(key: Key, ctr: Ctr, data: &[u8], data_out: &mut [u8]) {
    let mut cipher = Aes256Ctr::new(&key.into(), &ctr.into());
    data_out.copy_from_slice(data);
    cipher.apply_keystream(data_out);
}