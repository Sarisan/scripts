#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# Quark Kernel base defconfig based on Azure Linux 6.6

set -e

__wsl2_required_configs="
    CONFIG_BINFMT_MISC
    CONFIG_NET_IP_TUNNEL
    CONFIG_NET_UDP_TUNNEL
    CONFIG_INET_DIAG
    CONFIG_INET_TCP_DIAG
    CONFIG_INET_UDP_DIAG
    CONFIG_NETFILTER_NETLINK
    CONFIG_NETFILTER_NETLINK_LOG
    CONFIG_NF_CONNTRACK
    CONFIG_NF_NAT
    CONFIG_NF_TABLES
    CONFIG_NFT_MASQ
    CONFIG_NFT_NAT
    CONFIG_NF_DEFRAG_IPV4
    CONFIG_NF_DEFRAG_IPV6
    CONFIG_VSOCKETS
    CONFIG_VSOCKETS_DIAG
    CONFIG_HYPERV_VSOCKETS
    CONFIG_NETLINK_DIAG
    CONFIG_NET_9P
    CONFIG_NET_9P_FD
    CONFIG_NET_9P_VIRTIO
    CONFIG_PCI_HYPERV
    CONFIG_PCI_HYPERV_INTERFACE
    CONFIG_SCSI_FC_ATTRS
    CONFIG_HYPERV_STORAGE
    CONFIG_VXLAN
    CONFIG_HYPERV_NET
    CONFIG_HYPERV_KEYBOARD
    CONFIG_VIRTIO_CONSOLE
    CONFIG_HYPERV
    CONFIG_HYPERV_TIMER
    CONFIG_HYPERV_UTILS
    CONFIG_HYPERV_BALLOON
    CONFIG_DXGKRNL
    CONFIG_FUSE_FS
    CONFIG_VIRTIO_FS
    CONFIG_OVERLAY_FS
    CONFIG_NETFS_SUPPORT
    CONFIG_FSCACHE
    CONFIG_9P_FS
    CONFIG_9P_FSCACHE

    CONFIG_NETFILTER_XTABLES
    CONFIG_NETFILTER_XT_TARGET_RATEEST
    CONFIG_NETFILTER_XT_TARGET_TCPMSS
    CONFIG_NETFILTER_XT_MATCH_DSCP
    CONFIG_NETFILTER_XT_MATCH_HL
    CONFIG_NETFILTER_XT_MATCH_RATEEST
    CONFIG_NETFILTER_XT_MATCH_TCPMSS
"

for __arch in arm64 x86_64
do
    if [ ${__arch} = arm64 ]
    then
        _arch=aarch64
    else
        _arch=x86_64
    fi

    rm -fr ../out-${__arch}
    mkdir ../out-${__arch}
    cp ../azure-${__arch} ../out-${__arch}/.config
    make -j 16 ARCH=${__arch} O=../out-${__arch} CROSS_COMPILE=${_arch}-linux-gnu- olddefconfig
    sed -i 's/CONFIG_LOCALVERSION.*$/CONFIG_LOCALVERSION="-microsoft-quark-WSL2"/' ../out-${__arch}/.config
    sed -i 's/CONFIG_SYSTEM_TRUSTED_KEYS.*$//' ../out-${__arch}/.config

    for __config in ${__wsl2_required_configs}
    do
        echo "${__config}=y" >> ../out-${__arch}/.config
    done

    make -j 16 ARCH=${__arch} O=../out-${__arch} CROSS_COMPILE=${_arch}-linux-gnu- olddefconfig

    echo "# CONFIG_MODULES is not set" >> ../out-${__arch}/.config

    for __module in $(grep '=m' ../out-${__arch}/.config)
    do
        sed -i "s/${__module}/# ${__module%=*} is not set/g" ../out-${__arch}/.config
    done

    make -j 16 ARCH=${__arch} O=../out-${__arch} CROSS_COMPILE=${_arch}-linux-gnu- olddefconfig
    make -j 16 ARCH=${__arch} O=../out-${__arch} CROSS_COMPILE=${_arch}-linux-gnu- savedefconfig
done
