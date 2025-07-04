#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# Alpine Linux setup script, supposed to be ran in chroot

set -e

__dir="${0%/*}"

${__dir}/networking.sh ${1}
${__dir}/setup-world.sh
${__dir}/dnscrypt.sh
${__dir}/fstab.sh ${2}
${__dir}/nft-accept-filter.sh
${__dir}/rc-zram-init.sh ${3} ${4}
${__dir}/locale.sh
${__dir}/timezone.sh ${5}
${__dir}/nano.sh
${__dir}/ssh.sh
${__dir}/setup-rc.sh
