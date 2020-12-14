#!/bin/sh

apt-get --yes install  nfs-common
mkdir /share
chmod 777 /share
# Count ConnectX cards
CX=$(lspci | grep ConnectX | wc -l)
if [ "$CX" -eq "0" ]; then
	echo "#10.236.1.23:/export/share        /share  nfs     auto    0       0" >> /etc/fstab
	echo "192.168.238.23:/export/share      /share  nfs     auto    0       0" >> /etc/fstab
        exit
fi
echo "10.236.1.23:/export/share	/share	nfs	auto	0	0" >> /etc/fstab
echo "#192.168.238.23:/export/share	/share	nfs	auto	0	0" >> /etc/fstab