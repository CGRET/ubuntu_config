#!/bin/sh

# This scripts is called by curtin.
# Check /etc/maas/preseeds/curtin_userdata for the invocation
# /var/snap/maas/current/preseeds/ if you installed maas using snap
# See: https://maas.io/docs/snap/2.8/ui/custom-machine-setup

for f in /srv/ubuntu_config/bootstrap.d/*.sh; do
	bash "$f"
done

# Update and Upgrade
apt -y update
apt -y upgrade

exit 0
