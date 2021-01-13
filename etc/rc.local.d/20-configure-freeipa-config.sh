#!/bin/bash

# Configuration will be on first boot

logger -p user.info -t rc.local  "Checking if we should configure freeIPA client."

if [ -f /srv/.pass ]; then

logger -p user.info -t rc.local "Will configer freeIPA."
PASSWORD=$(cat /srv/.pass)


logger -p user.info -t rc.local  "Checking for IP that can reach 10.236.0.23:"
CDN_IP=$(ip route get 10.236.0.23 |  awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
logger -p user.info -t rc.local  "IP that can reach 10.236.0.23: ${CDN_IP}"

# freeIPA requires fully-qualified hostname
logger -p user.info -t rc.local  "Adding dss.cdn.local to hostname."
HOSTNAME=$(hostname).dss.cdn.local
logger -p user.info -t rc.local  "hostname: ${HOSTNAME}"
hostnamectl set-hostname ${HOSTNAME}

logger -p user.info -t rc.local  "ipa-client-install for ${HOSTNAME}"
ipa-client-install --unattended \
--hostname=${HOSTNAME} \
--mkhomedir \
--server=ipa.dss.cdn.local \
--domain=dss.cdn.local \
--realm=DSS.CDN.LOCAL \
--force-join \
--principal=admin \
--password=${PASSWORD} \
--enable-dns-updates

OK=$?
if [  "$OK" -eq "0" ]; then

echo "Getting TGT from realm."
echo ${PASSWORD} | kinit admin

echo "Adding A record and reverse PTR"
# Note the . at the end of domain
ipa dnsrecord-add dss.cdn.local. $(hostname) --a-rec=${CDN_IP} --a-create-reverse

#ipa hostgroup-add massnodes --desc="MAAS Nodes"

echo "Adding $(hostname) to massnodes hostgroup."
ipa hostgroup-add-member maasnodes --hosts $(hostname)

# Create the clients key on the ipa server
echo "Creating client nfs/${HOSTNAME} entry."
ipa service-add nfs/${HOSTNAME}

# Get the previously created key
# and store it in the clients keytab
echo "Updating krb5.keytab"
ipa-getkeytab \
--server=ipa.dss.cdn.local \
--principal=nfs/${HOSTNAME} \
--keytab=/etc/krb5.keytab

echo "Setting up automount."
ipa-client-automount \
--unattended \
--location=default \
--server=ipa.dss.cdn.local

rm /srv/.pass
fi

fi

#echo "Will not configure freeIPA: no password set."

