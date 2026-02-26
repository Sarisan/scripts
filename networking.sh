#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# networking configuration

set -e

if [ -n "${1}" ]
then
    __hostname="${1}"
    shift
else
    __hostname="localhost"
fi

echo ${__hostname} > /etc/hostname

cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 172.16.0.1
    netmask 255.240.0.0
iface eth1 inet6 auto
EOF

cat << EOF > /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 2001:4860:4860::8888
nameserver 2001:4860:4860::8844
EOF

cat << EOF > /etc/hosts
127.0.0.1 localhost ${__hostname}
::1 localhost ipv6-localhost ipv6-loopback ${__hostname}
fe00::0 ipv6-localnet
ff00::0 ipv6-mcastprefix
ff02::1 ipv6-allnodes
ff02::2 ipv6-allrouters
ff02::3 ipv6-allhosts
EOF
