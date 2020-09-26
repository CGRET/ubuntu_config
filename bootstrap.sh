#!/bin/sh

# This scripts is called by curtin.
# Check /etc/maas/preseeds/curtin_userdata for the invocation


for f in /srv/ubuntu_config/bootstrap.d/*.sh; do
	bash "$f"
done

# Update and Upgrade
apt -y update
apt -y upgrade

exit 0
