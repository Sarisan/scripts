#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# Quark Kernel defconfig based on Azure Linux 6.6

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

__wsl2_quark_configs="
    CONFIG_KERNEL_ZSTD

    CONFIG_ZRAM
    CONFIG_ZRAM_BACKEND_ZSTD
    CONFIG_ZRAM_WRITEBACK
    CONFIG_ZRAM_MEMORY_TRACKING
    CONFIG_ZRAM_MULTI_COMP
    CONFIG_CRYPTO_ZSTD

    CONFIG_HIDRAW
    CONFIG_HID_BPF
    CONFIG_USB_HIDDEV
    CONFIG_USB
    CONFIG_USB_STORAGE
    CONFIG_USB_UAS
    CONFIG_USBIP_CORE
    CONFIG_USBIP_VHCI_HCD
    CONFIG_USB_SERIAL

    CONFIG_USB_SERIAL_CH341

    CONFIG_EROFS_FS

    CONFIG_INIT_STACK_ALL_ZERO

    CONFIG_POSIX_MQUEUE
    CONFIG_CGROUPS
    CONFIG_MEMCG
    CONFIG_CGROUP_SCHED
    CONFIG_CGROUP_FREEZER
    CONFIG_CPUSETS
    CONFIG_CGROUP_DEVICE
    CONFIG_CGROUP_CPUACCT
    CONFIG_CGROUP_BPF
    CONFIG_NAMESPACES
    CONFIG_UTS_NS
    CONFIG_IPC_NS
    CONFIG_PID_NS
    CONFIG_NET_NS
    CONFIG_BRIDGE_NETFILTER
    CONFIG_NF_NAT
    CONFIG_NETFILTER_XT_MARK
    CONFIG_NETFILTER_XT_NAT
    CONFIG_NETFILTER_XT_TARGET_MASQUERADE
    CONFIG_NETFILTER_XT_MATCH_ADDRTYPE
    CONFIG_NETFILTER_XT_MATCH_CONNTRACK
    CONFIG_NETFILTER_XT_MATCH_IPVS
    CONFIG_IP_VS
    CONFIG_BRIDGE
    CONFIG_VETH
    CONFIG_KEYS

    CONFIG_ANDROID_BINDER_IPC
    CONFIG_ANDROID_BINDERFS
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
    make -j 16 O=../out-${__arch} ARCH=${__arch} CROSS_COMPILE=${_arch}-linux-gnu- olddefconfig
    sed -i 's/^CONFIG_LOCALVERSION=.*$/CONFIG_LOCALVERSION="-microsoft-quark-WSL2"/' ../out-${__arch}/.config
    sed -i 's/^CONFIG_SYSTEM_TRUSTED_KEYS=.*$//' ../out-${__arch}/.config

    for __config in ${__wsl2_required_configs}
    do
        echo "${__config}=y" >> ../out-${__arch}/.config
    done

    make -j 16 O=../out-${__arch} ARCH=${__arch} CROSS_COMPILE=${_arch}-linux-gnu- olddefconfig

    echo "# CONFIG_MODULES is not set" >> ../out-${__arch}/.config

    for __module in $(grep '=m$' ../out-${__arch}/.config)
    do
        sed -i "s/${__module}/# ${__module%=*} is not set/" ../out-${__arch}/.config
    done

    make -j 16 O=../out-${__arch} ARCH=${__arch} CROSS_COMPILE=${_arch}-linux-gnu- olddefconfig

    for __config in ${__wsl2_quark_configs}
    do
        echo "${__config}=y" >> ../out-${__arch}/.config
    done

    make -j 16 O=../out-${__arch} ARCH=${__arch} CROSS_COMPILE=${_arch}-linux-gnu- olddefconfig
    make -j 16 O=../out-${__arch} ARCH=${__arch} CROSS_COMPILE=${_arch}-linux-gnu- savedefconfig
done
