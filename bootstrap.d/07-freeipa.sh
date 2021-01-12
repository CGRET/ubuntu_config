#!/bin/sh


echo "Checking for IP that can reach 10.236.0.23:"
CDN_IP=$(ip route get 10.236.0.23 |  awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
echo "IP that can reach 10.236.0.23: ${CDN_IP}"


echo "Installing freeipa-client."
DEBIAN_FRONTEND=noninteractive apt-get -yqq install freeipa-client

echo "FreeIPA requires fully-qualified hostname"
echo "Adding dss.cdn.local to hostname."
HOSTNAME=$(hostname).dss.cdn.local
echo "hostname: ${HOSTNAME}"
hostnamectl set-hostname ${HOSTNAME}


if [ ! -f /srv/.pass ]; then
        echo "Will not configure FreeIPA: no password set."
        exit 0
fi

PASSWORD=$(cat /srv/.pass)

echo "ipa-client-install for ${HOSTNAME}"
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
if [ ! "$OK" -eq "0" ]; then
        echo "ipa-client-install failed with error ${OK}"
	rm /srv/.pass
        exit 0
fi


echo "Getting TGT from realm."
echo ${PASSWORD} | kinit admin

echo "Adding A record and reverse PTR"
# Note the . at the end of domain
ipa dnsrecord-add dss.cdn.local. $(hostname) --a-rec=${CDN_IP} --a-create-reverse

#ipa hostgroup-add massnodes --desc="MAAS Nodes"

echo "Adding $(hostname) to massnodes hostgroup."
ipa hostgroup-add-member maasnodes --hosts $(hostname)

echo "Creating client nfs/${HOSTNAME} entry."
ipa service-add nfs/${HOSTNAME}

echo "Setting up automount."
ipa-client-automount \
--unattended \
--location=default \
--server=ipa.dss.cdn.local

rm /srv/.pass

