#!/bin/sh

# Install Mellanox Firmware Tools (MFT)
apt --yes install build-essential make dkms wget
wget --quiet https://www.mellanox.com/downloads/MFT/mft-4.15.0-104-x86_64-deb.tgz
tar xvzf mft-4.15.0-104-x86_64-deb.tgz
pushd .
cd mft-4.15.0-104-x86_64-deb
$(pwd)/install.sh
popd


# Install InfiniBand drivers and software
apt --yes install opensm ibutils libibverbs-dev ibverbs-utils rdmacm-utils libibmad-dev numactl perftest iperf qperf mstflint
systemctl enable opensm

cat /srv/ubuntu_config/etc/mlx4_modules >> /etc/modules

cp /srv/ubuntu_config/etc/modprobe.d/mlx4_core.conf /etc/modprobe.d/mlx4_core.conf

cp /srv/ubuntu_config/etc/netplan/60-infiniband.yaml /etc/netplan/60-infiniband.yaml

cp /srv/ubuntu_config/etc/rc.local /etc/rc.local
systemctl enable rc-local

