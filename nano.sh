#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# nano configuration

set -e

sed -i 's|^# include /usr/share/nano/\*.nanorc$|include /usr/share/nano/\*.nanorc|' /etc/nanorc
