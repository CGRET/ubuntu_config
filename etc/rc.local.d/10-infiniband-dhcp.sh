#!/bin/bash
# The systemd-networkd DHCP implementation does not work wit IP over InfiniBand (ipoib).
# This is a horrid hack to force the use of dhclient for ipoib interfaces

IPoIB=$(ip --brief link show type ipoib | cut -d' ' -f1)

logger -p user.info -t "rc.local.${0}" "Running dhclient on ${IPoIB}"

dhclient ${IPoIB}
