#!/bin/sh

# This scripts is called by curtin.
# Check /etc/maas/preseeds/curtin_userdata for the invocation

# Install InfiniBand drivers and software
apt -y install opensm ibutils ibverbs-utils rdmacm-utils libibmad-dev numactl perftest iperf qperf
systemctl enable opensm

cat /srv/ubuntu_config/mlx4_modules >> /etc/modules

# Update and Upgrade
apt -y update
apt -y upgrade
