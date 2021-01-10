#!/bin/sh

#apt --yes install environment-modules

echo "Installing utilities."
apt-get --yes --quiet install ubuntu-drivers-common inetutils-traceroute

echo "Installing golang."
apt-get --yes --quiet install golang

echo "Installing cockpit."
apt-get --yes --quiet install cockpit cockpit-machines


