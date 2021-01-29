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

echo "Installing default JDK."
apt-get --yes --quiet install default-jdk
echo 'JAVA_HOME="/usr/lib/jvm/default-java/"' >> /etc/environment

echo "Installing Apache Maven."
mkdir -p /opt/
pushd /opt/

export VERSION=3.6.3 && # adjust this as necessary \
wget https://ftp.wayne.edu/apache/maven/maven-3/3.6.3/binaries/apache-maven-${VERSION}-bin.tar.gz \
&& tar -xzf apache-maven-${VERSION}-bin.tar.gz \
&&  rm apache-maven-${VERSION}-bin.tar.gz \
&&  mv apache-maven-${VERSION} apache-maven 
cp /srv/ubuntu_config/etc/profile.d/maven.sh >> /etc/profile.d/maven.sh

popd

echo "Installing mpich."
apt-get --yes --quiet install mpich
