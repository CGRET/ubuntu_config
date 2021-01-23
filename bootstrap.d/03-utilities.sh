#!/bin/sh

#apt --yes install environment-modules

echo "Installing utilities."
apt-get --yes --quiet install ldap-utils ubuntu-drivers-common inetutils-traceroute sshpass mpich

echo "Installing golang."
apt-get --yes --quiet install golang

echo "Installing cockpit."
apt-get --yes --quiet install cockpit cockpit-machines


echo "Install KVM/qemu add ons"
apt-get --yes --quet install qemu-system-ppc virt-top qemu-user-binfmt
