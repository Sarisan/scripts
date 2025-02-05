#!/usr/bin/env dash
#
# Copyright (C) 2025 Maria Lisina
# SPDX-License-Identifier: Apache-2.0
#
# nftables ASN filter

set -e

if [ ${#} -eq 0 ]
then
    echo "No ASNs specified!"
    exit 1
fi

__blocked_asns="${@}"
shift ${#}

for __asn in ${__blocked_asns}
do
    __asn_ips="$(curl --get --silent "https://2ip.io/as/${__asn}.json" | jq -r '.prefixes[].ipv4Prefix')"
    set -- ${@} ${__asn_ips}
done

while [ ${#} -gt 0 ]
do
    _asn_ips="$(printf "%s%s" "${_asn_ips}" "${1}")"

    if [ ${#} -gt 1 ]
    then
        _asn_ips="$(printf "%s%c" "${_asn_ips}" ",")"
    fi

    shift
done

cat << EOF > /etc/nftables.d/asn_filter.nft
#!/usr/sbin/nft -f

table inet asn_filter {
    set blocked_addresses {
        typeof ip saddr
        flags interval
        auto-merge
        elements = { ${_asn_ips} }
    }

    chain input {
        type filter hook input priority 0;
        ip saddr @blocked_addresses drop
    }
}
EOF
