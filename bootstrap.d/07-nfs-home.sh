#!/bin/sh

apt-get --yes install  nfs-common
echo "192.168.238.23:/export/home   /home   nfs    auto  0  0" >> /etc/fstab
