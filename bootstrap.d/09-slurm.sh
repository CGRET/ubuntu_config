#!/bin/sh

logger -p user.info -t "bootstrap.${0}" "Install & configure munge and slurm"

if [ ! -f /srv/.pass ]; then
        logger -p user.info -t "bootstrap.${0}" "Missing password.  Will not install."
        exit 0
fi

PASSWORD=$(cat /srv/.pass)

logger -p user.info -t "bootstrap.${0}" "Creating users and groups for slurm and munge."
adduser -u 1111 munge --disabled-password --gecos "" --no-create-home
usermod --home /none munge
adduser -u 1121 slurm --disabled-password --gecos "" --no-create-home
usermod --home /none slurm

#logger -p user.info -t "bootstrap.${0}" "Installing munge"
#apt-get install --yes --quiet munge libmunge-dev libmunge2
#systemctl enable munge
# need to get the munge.key from maas.dss.cdn.local/etc/munge/munge.key 
#  to /etc/munge/munge.key
#  will have to do this on first boot in rc.local


#logger -p user.info -t "bootstrap.${0}" "Installing slurm node"
#apt-get install --yes --quiet slurm-wlm slurm-wlm-basic-plugins slurm-wlm-torque slurmd
#systemctl enable slurmd
