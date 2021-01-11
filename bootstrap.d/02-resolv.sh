#!/bin/sh

echo "systemd-resolve --status"
systemd-resolve --status

echo "Modifying systemd-resolved configuration."
echo "Update DNS server"
sed --in-place "s/#DNS=/DNS=10.236.0.23/" /etc/systemd/resolved.conf

echo "Update Domains"
sed --in-place "s/#Domains=/Domains=dss.cdn.local/" /etc/systemd/resolved.conf

# Doesnt work in chroot
#echo "Reload configuration."
#systemctl daemon-reload

echo "Restarting systemd-resolved"
systemctl restart systemd-resolved

echo "systemd-resolve --status"
systemd-resolve --status

