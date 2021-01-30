#!/bin/sh

logger -p user.info -t bootstrap "Checking for ConnectX cards:"
CX=$(lspci | grep ConnectX | wc -l)
if [ "$CX" -eq "0" ]; then
	logger -p user.info -t bootstrap "No ConnectX detected.  Skipping ConnectX & InfiniBand install."
        exit 0
fi

#logger -p user.info -t bootstrap "${CX} ConnectX card(s) detected."
#echo "Installing Mellanox Firmware Tools (MFT)."
#apt-get --yes --quiet install build-essential make dkms wget
#wget --quiet https://www.mellanox.com/downloads/MFT/mft-4.15.0-104-x86_64-deb.tgz
#tar xvzf mft-4.15.0-104-x86_64-deb.tgz
#pushd mft-4.15.0-104-x86_64-deb
#$(pwd)/install.sh
#popd


logger -p user.info -t bootstrap "Installing InfiniBand drivers, services and software."
apt-get --yes --quiet install opensm ibutils libibverbs-dev ibverbs-utils rdmacm-utils libibmad-dev numactl perftest iperf qperf mstflint
systemctl enable opensm

logger -p user.info -t bootstrap "Updating ConnectX & InfiniBand configuration files."
cat /srv/ubuntu_config/etc/mlx4_modules >> /etc/modules

cp /srv/ubuntu_config/etc/modprobe.d/mlx4_core.conf /etc/modprobe.d/mlx4_core.conf

cp /srv/ubuntu_config/etc/netplan/60-infiniband.yaml /etc/netplan/60-infiniband.yaml

logger -p user.info -t bootstrap "Check rc.local for the DHCP hack for IPoIB interface."


