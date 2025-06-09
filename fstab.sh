#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# fstab configuration

set -e

__boot="$(blkid -o value -s UUID /dev/${1}1)"
__root="$(blkid -o value -s UUID /dev/${1}2)"

cat << EOF > /etc/fstab
UUID=${__root} / ext4 defaults 0 1
UUID=${__boot} /boot vfat defaults 0 2
EOF
