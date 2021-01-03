#!/bin/sh


# Update DNS
sed --in-place "s/#DNS=/DNS=192.168.238.22/" /etc/systemd/resolved.conf

# Update Domains
sed --in-place "s/#Domains=/Domains=dss.cdn.local/" /etc/systemd/resolved.conf
