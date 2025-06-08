#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# cifs configuration

set -e

cat << EOF >> /etc/fstab
//172.16.0.1/Users/sekoo /media/cifs/Windows cifs _netdev,defaults,vers=3.1.1,credentials=/root/.cifs
EOF

cat << EOF > /root/.cifs
username=${1}
password=${2}
EOF
