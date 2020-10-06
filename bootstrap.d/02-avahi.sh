#!/bin/sh

# Install and configure avahi (AKA Bonjour)
apt -y install avahi-daemon avahi-utils
systemctl enable avahi-daemon
sed --in-place=.orig "s/#host-name=foo/host-name=$(hostname)/" /etc/avahi/avahi-daemon.conf

cp /srv/ubuntu_config/etc/avahi/services/ssh.service /etc/avahi/services/ssh.service

