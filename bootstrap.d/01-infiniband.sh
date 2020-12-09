#!/bin/sh

# Install Mellanox Firmware Tools (MFT)
apt --yes install build-essential make dkms wget
wget https://www.mellanox.com/downloads/MFT/mft-4.15.0-104-x86_64-deb.tgz
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

# Activate the ipoib interface
modprobe mlx4_core
modprobe mlx4_ib
modprobe ib_ipoib
modprobe ib_umad
modprobe rdma_ucm

#Get the name of the ipoib interface
IPoIB=$(ip --brief link show type ipoib | cut -d' ' -f1)

cp /srv/ubuntu_config/etc/netplan/60-infiniband.yaml /etc/netplan/60-infiniband.yaml
echo "#${IPoIB}" >> /etc/netplan/60-infiniband.yaml

