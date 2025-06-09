#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# Alpine Linux bootstrap script

set -e

parted --script /dev/${1} \
    mklabel gpt \
    mkpart '"EFI system partition"' fat32 1MiB 101MiB \
    set 1 esp on \
    mkpart '"Linux filesystem partition"' ext4 101MiB 100%

mkfs.fat -F 32 -n "EFI" /dev/${1}1
mkfs.ext4 -L "Alpine Linux" /dev/${1}2
mount -m /dev/${1}2 /mnt/bootstrap
mount -m /dev/${1}1 /mnt/bootstrap/boot

apk -p /mnt/bootstrap -U -X http://dl-cdn.alpinelinux.org/alpine/v3.22/main --allow-untrusted --arch x86_64 --initdb add alpine-base

for __dev in dev proc run sys tmp
do
    mount --rbind --make-rslave /${__dev} /mnt/bootstrap/${__dev}
done
