#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# boot configuration

set -e

__root="$(blkid -o value -s UUID /dev/${1}2)"

efibootmgr --create --loader "\vmlinuz-virt" --label "Alpine Linux" --unicode "initrd=\initramfs-virt quiet root=UUID=${__root} rootfstype=ext4 rw"
