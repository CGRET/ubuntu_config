#!/bin/sh

CDN_IP=$(ip route get 10.236.0.23 |  awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
echo "IP that can reach 10.236.0.23: ${CDN_IP}"

DEBIAN_FRONTEND=noninteractive apt-get -yq install freeipa-client

# FreeIPA requires fully-qualified hostname
echo "Adding dss.cdn.local to hostname."
HOSTNAME=$(hostname).dss.cdn.local
echo "hostname: ${HOSTNAME}"
hostnamectl set-hostname ${HOSTNAME}


if [ ! -f /srv/.pass ]; then
        echo "Will not configure FreeIPA: no password set."
        exit 0
fi

PASSWORD=$(cat /srv/.pass)

echo "installing ${HOSTNAME}"
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

echo ${PASSWORD} | kinit admin

echo "adding A record and reverse PTR"
# Note the . at the end of domain
ipa dnsrecord-add dss.cdn.local. $(hostname) --a-rec=${CDN_IP} --a-create-reverse

#ipa hostgroup-add massnodes --desc="MAAS Nodes"

echo "adding $(hostname) to massnodes hostgroup."
ipa hostgroup-add-member maasnodes --hosts $(hostname)

echo "creating client nfs/${HOSTNAME} entry."
ipa service-add nfs/${HOSTNAME}

echo "setting up automount."
ipa-client-automount \
--location=default \
--server=ipa.dss.cdn.local

rm /srv/.pass

