#!/usr/bin/env dash
#
# Copyright (C) 2025-2026 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# Sekoohaka Kernel build script

set -e

for __arch in arm64 x86_64
do
    if [ ${__arch} = arm64 ]
    then
        _arch=aarch64
    else
        _arch=x86_64
    fi

    rm -fr ../out-${__arch}
    make -j 16 O=../out-${__arch} ARCH=${__arch} CROSS_COMPILE=${_arch}-linux-gnu- wsl2_defconfig
    make -j 16 O=../out-${__arch} ARCH=${__arch} CROSS_COMPILE=${_arch}-linux-gnu-
done
