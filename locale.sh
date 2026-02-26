#!/bin/sh
#
# Copyright (C) 2025-2026 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# locale configuration

set -e

cat << EOF > /etc/profile.d/10locale.sh
export LANG=en_US.UTF-8
EOF
