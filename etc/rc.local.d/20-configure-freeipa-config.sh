#!/bin/bash

# Configuration will be on first boot

logger -p user.info -t rc.local  "Checking if we should configure freeIPA client."

if [ -f /srv/.pass ]; then

logger -p user.info -t rc.local "Will configure freeIPA."
PASSWORD=$(cat /srv/.pass)

target="10.236.0.23"
logger -p user.info -t rc.local  "Checking for IP that can reach ${target}:"
count=$( ping -c 1 $target | grep icmp* | wc -l )
if [ $count -eq 1 ]; then

CDN_IP=$(ip route get ${target} |  awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
logger -p user.info -t rc.local  "IP that can reach ${target}: ${CDN_IP}"

# freeIPA requires fully-qualified hostname
logger -p user.info -t rc.local  "Adding dss.cdn.local to hostname."
HOSTNAME=$(hostname -s).dss.cdn.local
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

logger -p user.info -t rc.local  "Getting TGT from realm."
echo ${PASSWORD} | kinit admin

logger -p user.info -t rc.local  "Adding A record and reverse PTR"
# Note the . at the end of domain
ipa dnsrecord-add dss.cdn.local. $(hostname -s) --a-rec=${CDN_IP} --a-create-reverse

#ipa hostgroup-add massnodes --desc="MAAS Nodes"

logger -p user.info -t rc.local  "Adding $(hostname) to massnodes hostgroup."
ipa hostgroup-add-member maasnodes --hosts $(hostname)

# Create the clients key on the ipa server
logger -p user.info -t rc.local  "Creating client nfs/${HOSTNAME} entry."
ipa service-add nfs/${HOSTNAME}

# Get the previously created key
# and store it in the clients keytab
logger -p user.info -t rc.local  "Updating krb5.keytab with nfs/${HOSTNAME}"
ipa-getkeytab \
--server=ipa.dss.cdn.local \
--principal=nfs/${HOSTNAME} \
--keytab=/etc/krb5.keytab

# Create the clients key on the ipa server
logger -p user.info -t rc.local  "Creating client host/${HOSTNAME} entry."
ipa service-add host/${HOSTNAME}

# Get the previously created key
# and store it in the clients keytab
logger -p user.info -t rc.local  "Updating krb5.keytab with host/${HOSTNAME}"
ipa-getkeytab \
--server=ipa.dss.cdn.local \
--principal=host/${HOSTNAME} \
--keytab=/etc/krb5.keytab

logger -p user.info -t rc.local "Setting up automount."
ipa-client-automount \
--unattended \
--location=default \
--server=ipa.dss.cdn.local

rm /srv/.pass
logger -p user.info -t rc.local "freeIPA configuration complete."
fi

# end of ping check
else
	logger -p user.info -t rc.local  "Could not reach ${target}."
fi

# end of .pass check
else
	logger -p user.info -t rc.local  "Will not configure freeIPA: no password set."
fi
