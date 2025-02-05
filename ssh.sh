#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# SSH configuration

set -e

cat << EOF > /etc/ssh/sshd_config.d/root.conf
PermitRootLogin yes
PasswordAuthentication no
PubkeyAuthentication yes
AllowTcpForwarding yes
EOF

sed -i 's/AllowTcpForwarding no/#AllowTcpForwarding no/' /etc/ssh/sshd_config
