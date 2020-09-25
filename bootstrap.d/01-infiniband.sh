#!/bin/sh

# Install InfiniBand drivers and software
apt -y install opensm ibutils ibverbs-utils rdmacm-utils libibmad-dev numactl perftest iperf qperf mstflint
systemctl enable opensm

cat /srv/ubuntu_config/mlx4_modules >> /etc/modules

