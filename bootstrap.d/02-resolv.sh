#!/bin/sh

# Don't forget to set the DNS server in the subnet on MAAS!

echo "Modifying systemd-resolved configuration:"
echo "  Update DNS server"
sed --in-place "s/#DNS=/DNS=10.236.0.23/" /etc/systemd/resolved.conf

echo " Update Domains"
sed --in-place "s/#Domains=/Domains=dss.cdn.local/" /etc/systemd/resolved.conf

# This is for things that need the fqdn to resolve to CDN_IP
echo "Replace hosts template"
cp /srv/ubuntu_config/etc/cloud/templates/hosts.debian.tmpl /etc/cloud/templates/hosts.debian.tmpl

CDN_IP=$(ip route get 10.236.0.23 |  awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
echo "Update IP to ${CDN_IP} in template."
sed --in-place 's/CDN_IP/'"${CDN_IP}"'/' /etc/cloud/templates/hosts.debian.tmpl

