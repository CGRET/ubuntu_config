#!/bin/sh

# This scripts is called by curtin.
# Check /etc/maas/preseeds/curtin_userdata for the invocation

# Install InfiniBand drivers and software
apt -y install opensm ibutils ibverbs-utils rdmacm-utils libibmad-dev numactl perftest iperf qperf mstflint
systemctl enable opensm

cat /srv/ubuntu_config/mlx4_modules >> /etc/modules

# Install and configure avahi (AKA Bonjour)
apt -y install avahi-daemon avahi-utils
systemctl enable avahi-daemon
sed --in-place=.orig "s/#host-name=foo/host-name=$(hostname)/" /etc/avahi/avahi-daemon.conf

# Update and Upgrade
apt -y update
apt -y upgrade

exit 0
