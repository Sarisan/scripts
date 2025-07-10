#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# dnscrypt-proxy setup script

sed -i \
    -e "s/^# server_names =.*$/server_names = ['google', 'google-ipv6']/" \
    -e "s/^listen_addresses =.*$/listen_addresses = ['127.0.0.1:53', '[::1]:53']/" \
    -e 's/^ipv6_servers =.*$/ipv6_servers = true/' \
    -e 's/^cache =.*$/cache = false/' \
    /etc/dnscrypt-proxy/dnscrypt-proxy.toml

cat << EOF > /etc/resolv.conf
nameserver 127.0.0.1
nameserver ::1
EOF

rc-service dnscrypt-proxy start
