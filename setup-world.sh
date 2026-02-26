#!/bin/sh
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# APK world setup script

set -e

__world="
    alpine-sdk
    curl
    dosfstools
    e2fsprogs
    efibootmgr
    fastfetch
    git
    jq
    lang
    linux-virt
    nano
    nano-syntax
    openssh
    recode
    telegram-bot-api
    tzdata
    util-linux
    zsh
    zsh-completions
"

cat << EOF > /etc/apk/repositories
https://dl-cdn.alpinelinux.org/alpine/v3.23/main
https://dl-cdn.alpinelinux.org/alpine/v3.23/community
https://dl-cdn.alpinelinux.org/alpine/edge/testing
EOF

apk update
apk add ${__world}
