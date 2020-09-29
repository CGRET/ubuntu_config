#!/bin/sh

# Install Mellanox Firware Tools (MFT)
apt --yes install build-essential make dkms wget
wget https://www.mellanox.com/downloads/MFT/mft-4.15.0-104-x86_64-deb.tgz
tar xvzf mft-4.15.0-104-x86_64-deb.tgz
pushd .
cd mft-4.15.0-104-x86_64-deb
$(pwd)/install.sh
popd


# Install InfiniBand drivers and software
apt --yes install opensm ibutils ibverbs-utils rdmacm-utils libibmad-dev numactl perftest iperf qperf mstflint
systemctl enable opensm

cat /srv/ubuntu_config/mlx4_modules >> /etc/modules

cp /srv/ubuntu_confing/etc/netplan/60-infiniband.yaml /etc/netplan/
