#!/bin/bash

if ! command -v java; then

logger -p user.info -t rc.local "Installing default JDK."
apt-get --yes --quiet install default-jdk
echo 'JAVA_HOME="/usr/lib/jvm/default-java/"' >> /etc/environment
source /etc/environment
logger -p user.info -t rc.local "Done installing default JDK.."

fi

if ! command -v mvn; then

logger -p user.info -t rc.local "Installing Apache Maven."
mkdir -p /opt/
pushd /opt/

export VERSION=3.6.3 && # adjust this as necessary \
wget --quiet https://ftp.wayne.edu/apache/maven/maven-3/3.6.3/binaries/apache-maven-${VERSION}-bin.tar.gz \
&& tar -xzf apache-maven-${VERSION}-bin.tar.gz \
&&  rm apache-maven-${VERSION}-bin.tar.gz \
&&  mv apache-maven-${VERSION} apache-maven
cp /srv/ubuntu_config/etc/profile.d/maven.sh /etc/profile.d/maven.sh

popd

logger -p user.info -t rc.local "Installing Apache Maven."

fi
