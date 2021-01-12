#!/bin/sh


echo "Installing and configuring rc.local"
cp /srv/ubuntu_config/etc/rc.local /etc/rc.local

mkdir -p /etc/rc.local.d
cp /srv/ubuntu_config/etc/rc.local.d/*.sh /etc/rc.local.d/

systemctl enable rc-local


