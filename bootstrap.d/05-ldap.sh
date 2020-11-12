#!/bin/sh

# Install ldap utilities
apt-get install --yes ldap-utils

# Install Active Directory CA certificate
cp /srv/ubuntu_config/usr/lib/ssl/certs/cdn.local.pem /usr/lib/ssl/certs/cdn.local.pem
c_rehash

# Configure ldap utilities
mkdir -p /etc/ldap
cat /srv/ubuntu_config/etc/hosts >> /etc/hosts
cat /srv/ubuntu_config/etc/ldap/ldap.conf >> /etc/ldap/ldap.conf

