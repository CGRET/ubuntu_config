#!/bin/sh

echo "Install NFS"
apt-get --yes --quiet install  nfs-common

echo "Creating /share directory."
mkdir /share
chmod 777 /share

echo "Configuring NFS mount for /share."
# Count ConnectX cards
#CX=$(lspci | grep ConnectX | wc -l)
#if [ "$CX" -eq "0" ]; then
#	echo "10.236.0.23:/exports/share        /share  nfs     auto    0       0" >> /etc/fstab
#	echo "#192.168.238.23:/exports/share      /share  nfs     auto    0       0" >> /etc/fstab
#        exit 0
#fi
#echo "#10.236.0.23:/exports/share	/share	nfs	auto	0	0" >> /etc/fstab
#echo "192.168.238.23:/exports/share	/share	nfs	auto	0	0" >> /etc/fstab

echo "ipa.dss.cdn.local:/home /home   nfs4    rw,hard,intr,sec=krb5 0 0" >> /etc/fstab
echo "ipa.dss.cdn.local:/share /share   nfs4    rw,hard,intr,sec=krb5 0 0" >> /etc/fstab

