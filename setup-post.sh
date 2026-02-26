#!/bin/sh
#
# Copyright (C) 2025-2026 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# Alpine Linux post setup script, supposed to be ran in working system

set -e

__dir="${0%/*}"

${__dir}/boot.sh ${1}
${__dir}/cifs.sh ${2} ${3}
