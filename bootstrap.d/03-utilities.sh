#!/bin/sh

#apt-get --yes --quiet install environment-modules

echo "Installing utilities."
apt-get --yes --quiet install ldap-utils ubuntu-drivers-common inetutils-traceroute sshpass

echo "Installing golang."
apt-get --yes --quiet install golang

echo "Installing cockpit."
apt-get --yes --quiet install cockpit cockpit-machines

echo "Installing KVM/qemu add ons."
apt-get --yes --quiet install qemu-system-arm qemu-efi-aarch64 qemu-efi-arm qemu-system-ppc virt-top qemu-user-binfmt

echo "Installing mpich."
apt-get --yes --quiet install mpich
