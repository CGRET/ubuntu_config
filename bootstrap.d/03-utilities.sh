#!/bin/sh

#apt-get --yes --quiet install environment-modules

echo "Installing utilities."
apt-get --yes --quiet install ldap-utils ubuntu-drivers-common inetutils-traceroute sshpass

echo "Installing golang."
apt-get --yes --quiet install golang

echo "Installing cockpit."
apt-get --yes --quiet install cockpit cockpit-machines

echo "Installing KVM/qemu add ons."
apt-get --yes --quiet install qemu-system-ppc virt-top qemu-user-binfmt

echo "Installing Open JDK 8."
apt-get --yes --quiet install openjdk-8-jdk-headless
echo 'JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"' >> /etc/environment

echo "Installing mpich."
apt-get --yes --quiet install mpich
