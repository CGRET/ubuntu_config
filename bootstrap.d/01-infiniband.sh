#!/bin/sh

echo "Checking for ConnectX cards:"
CX=$(lspci | grep ConnectX | wc -l)
if [ "$CX" -eq "0" ]; then
	echo "No ConnectX detected.  Skipping ConnectX & InfiniBand install."
        exit 0
fi

echo "${CX} ConnectX card(s) detected."
echo "Installing Mellanox Firmware Tools (MFT)."
apt-get --yes --quiet install build-essential make dkms wget
wget --quiet https://www.mellanox.com/downloads/MFT/mft-4.15.0-104-x86_64-deb.tgz
tar xvzf mft-4.15.0-104-x86_64-deb.tgz
pushd .
cd mft-4.15.0-104-x86_64-deb
$(pwd)/install.sh
popd


echo "Installing InfiniBand drivers, services and software."
apt-get --yes --quiet install opensm ibutils libibverbs-dev ibverbs-utils rdmacm-utils libibmad-dev numactl perftest iperf qperf mstflint
systemctl enable opensm

echo "Updating ConnectX & InfiniBand configuration files."
cat /srv/ubuntu_config/etc/mlx4_modules >> /etc/modules

cp /srv/ubuntu_config/etc/modprobe.d/mlx4_core.conf /etc/modprobe.d/mlx4_core.conf

cp /srv/ubuntu_config/etc/netplan/60-infiniband.yaml /etc/netplan/60-infiniband.yaml

echo "Configuring DHCP hack for IPoIB interface."
cp /srv/ubuntu_config/etc/rc.local /etc/rc.local
systemctl enable rc-local


