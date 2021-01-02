#!/bin/sh

#apt --yes install environment-modules
apt --yes install ubuntu-drivers-common inetutils-traceroute maas-cli

# Install golang for use by singularity
snap install --color=never --unicode=never go --classic

