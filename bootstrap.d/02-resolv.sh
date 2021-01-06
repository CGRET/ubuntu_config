#!/bin/sh


# Update DNS
sed --in-place "s/#DNS=/DNS=10.236.0.22/" /etc/systemd/resolved.conf

# Update Domains
sed --in-place "s/#Domains=/Domains=dss.cdn.local/" /etc/systemd/resolved.conf
