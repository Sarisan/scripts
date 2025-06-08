#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# locale configuration

set -e

cat << EOF > /etc/profile.d/20locale.sh
export LANG=en_US.UTF-8
EOF
