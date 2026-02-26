#!/bin/sh
#
# Copyright (C) 2025-2026 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# SSH configuration

set -e

cat << EOF > /etc/ssh/sshd_config.d/root.conf
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication no
AllowTcpForwarding yes
EOF

sed -i 's/^AllowTcpForwarding no$/#AllowTcpForwarding no/' /etc/ssh/sshd_config
