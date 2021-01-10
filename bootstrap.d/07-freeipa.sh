#!/bin/sh

DEBIAN_FRONTEND=noninteractive apt-get -yq install freeipa-client

# FreeIPA requires fully-qualified hostname
hostnamectl set-hostname $(hostname).dss.cdn.local
HOSTNAME=$(hostname -f)

PASSWORD=$(cat /srv/.pass)

ipa-client-install --unattended \
--hostname=${HOSTNAME} \
--mkhomedir \
--server=ipa.dss.cdn.local \
--domain dss.cdn.local \
--realm DSS.CDN.LOCAL \
--force-join \
--principal=admin \
--password=${PASSWORD}

echo ${PASSWORD} | kinit admin

#ipa hostgroup-add massnodes --desc="MAAS Nodes"

ipa hostgroup-add-member maasnodes \
--hosts ${HOSTNAME}

ipa service-add nfs/${HOSTNAME}

ipa-client-automount \
--location=default \
--server=ipa.dss.cdn.local

rm /srv/.pass


