#!/bin/sh

# Install and configure avahi (AKA Bonjour)
apt -y install avahi-daemon avahi-utils
systemctl enable avahi-daemon

# Update hostname
sed --in-place "s/#host-name=foo/host-name=$(hostname)/" /etc/avahi/avahi-daemon.conf
# Upaate domain name
sed --in-place "s/#domain-name=local/domain-name=maas/" /etc/avahi/avahi-daemon.conf

cp /srv/ubuntu_config/etc/avahi/services/ssh.service /etc/avahi/services/ssh.service

