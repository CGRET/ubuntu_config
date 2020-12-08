#!/bin/sh

apt-get --yes install  nfs-common
mkdir /share
echo "192.168.238.23:/export/   /share   nfs    auto  0  0" >> /etc/fstab
