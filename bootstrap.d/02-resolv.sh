#!/bin/sh

# Don't forget to set the DNS server in the subnet on MAAS!

echo "Modifying systemd-resolved configuration:"
echo "  Update DNS server"
sed --in-place "s/#DNS=/DNS=10.236.0.23/" /etc/systemd/resolved.conf

echo " Update Domains"
sed --in-place "s/#Domains=/Domains=dss.cdn.local/" /etc/systemd/resolved.conf

# This is for things that need the fqdn to resolve to 127.0.0.1
echo "Replace hosts template"
cp /srv/ubuntu_config/etc/cloud/templates/hosts.debian.tmpl /etc/cloud/templates/hosts.debian.tmpl
