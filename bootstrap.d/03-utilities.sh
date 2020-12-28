#!/bin/sh

#apt --yes install environment-modules
apt --yes install ubuntu-drivers-common inetutils-traceroute

# Install golang for use by singularity
snap install go
