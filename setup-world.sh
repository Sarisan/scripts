#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# APK world setup script

set -e

__world="
    alpine-sdk
    cifs-utils
    curl
    dash
    dmesg
    dosfstools
    e2fsprogs
    efibootmgr
    fastfetch
    ffmpeg
    git
    htop
    jq
    lang
    less
    libudev-zero
    linux-virt
    nano
    nano-syntax
    ncurses
    nftables
    openssh
    pipx
    recode
    squid
    telegram-bot-api
    tzdata
    util-linux
    xq
    zram-init
    zsh
    zsh-completions
"

cat << EOF > /etc/apk/repositories
http://mirror.yandex.ru/mirrors/alpine/v3.22/main
http://mirror.yandex.ru/mirrors/alpine/v3.22/community
http://mirror.yandex.ru/mirrors/alpine/edge/testing
EOF

apk update
apk add ${__world}
