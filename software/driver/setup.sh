#!/bin/bash

set -euo pipefail

ARCH=riscv
CROSS_COMPILE=riscv64-unknown-linux-gnu-

git clone --depth 1 --branch v5.6.16 https://github.com/gregkh/linux
pushd linux
cp ../setup-config .config
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE prepare
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE modules
popd

make KDIR=./linux ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE
