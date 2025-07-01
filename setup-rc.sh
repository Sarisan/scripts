#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# Alpine Linux OpenRC setup script, supposed to be ran in chroot

rc-update add acpid default
rc-update add bootmisc boot
rc-update add crond default
rc-update add devfs sysinit
rc-update add dmesg sysinit
rc-update add hostname boot
rc-update add hwclock boot
rc-update add hwdrivers sysinit
rc-update add killprocs shutdown
rc-update add mdev sysinit
rc-update add modules boot
rc-update add mount-ro shutdown
rc-update add networking boot
rc-update add savecache shutdown
rc-update add seedrng boot
rc-update add swap boot

rc-update add nftables boot
rc-update add dnscrypt-proxy
rc-update add netmount
rc-update add sshd
rc-update add zram-init
