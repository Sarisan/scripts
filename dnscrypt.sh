#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# dnscrypt-proxy setup script

sed -i \
    -e "s/^listen_addresses =.*$/listen_addresses = [':53']/" \
    -e 's/^ipv6_servers =.*$/ipv6_servers = true/' \
    /etc/dnscrypt-proxy/dnscrypt-proxy.toml

__line_num=$(grep -n "\[sources.dnscry-pt-resolvers\]" /etc/dnscrypt-proxy/dnscrypt-proxy.toml | cut -d ':' -f 1)

for _line_num in $(seq ${__line_num} $((__line_num + 5)))
do
    sed -i "${_line_num}s/^# //" /etc/dnscrypt-proxy/dnscrypt-proxy.toml
done

cat << EOF > /etc/resolv.conf
nameserver 127.0.0.1
nameserver ::1
EOF

rc-service dnscrypt-proxy start
