#!/bin/sh
#
# Copyright (C) 2025-2026 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# OpenRC zram-init configuration

set -e

if [ -n "${1}" ]
then
    __num_devices=${1}

    if ! test ${__num_devices} -gt 0 > /dev/null 2>&1
    then
        echo "Invalid devices number"
        exit 1
    fi

    shift
fi

if [ -n "${1}" ]
then
    __size=${1}

    if ! test ${__size} -gt 0 > /dev/null 2>&1
    then
        echo "Invalid block size"
        exit 1
    fi

    shift
fi

cat << EOF > /etc/modprobe.d/zram.conf
options zram num_devices=${__num_devices}
EOF

cat << EOF > /etc/conf.d/zram-init
load_on_start=yes
unload_on_stop=yes
num_devices=${__num_devices}
EOF

for __device in $(seq 0 $((__num_devices - 1)))
do
    printf "\ntype%u=%s\nsize%u=%u\nmaxs%u=%u\nalgo%u=%s\nlabl%u=%s\n" \
        ${__device} "swap" \
        ${__device} ${__size} \
        ${__device} 1 \
        ${__device} "zstd" \
        ${__device} "zram" >> /etc/conf.d/zram-init
done
