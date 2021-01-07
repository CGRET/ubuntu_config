#!/bin/sh

DEBIAN_FRONTEND=noninteractive apt-get -yq install freeipa-client

# FreeIPA requires fully-qualified hostname
hostnamectl set-hostname $(hostname).dss.cdn.local

PASSWORD=$(cat /srv/.pass)

ipa-client-install --unattended \
--hostname=$(hostname -f) \
--mkhomedir \
--server=ipa.dss.cdn.local \
--domain dss.cdn.local \
--realm DSS.CDN.LOCAL \
--force-join \
--principal=admin \
--password=${PASSWORD}

echo ${PASSWORD} | kinit admin

ipa hostgroup-add-member \
--hosts $(hostname -f) \
--groups massnodes

ipa service-add nfs/$(hostname -f)

ipa-client-automount \
--location=default \
--server=ipa.dss.cdn.local

rm /srv/.pass


