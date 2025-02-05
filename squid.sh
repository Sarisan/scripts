#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# Squid configuration

set -e

cat << EOF > /etc/squid/squid.conf
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
coredump_dir /var/cache/squid
delay_pools 1
delay_access 1 allow localnet
delay_access 1 deny all
delay_class 1 1
delay_parameters 1 125000000/125000000
http_access allow localnet
http_access deny all
http_port 3128
shutdown_lifetime 0 seconds
EOF
