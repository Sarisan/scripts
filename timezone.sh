#!/bin/sh
#
# Copyright (C) 2025-2026 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# timezone configuration

set -e

ln -fs /usr/share/zoneinfo/${1} /etc/localtime
