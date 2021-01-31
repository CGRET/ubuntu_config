#!/bin/sh

USER="virsh"
logger -p user.info -t rc.local "Updating ${USER}"

if [ ! -f /srv/.pass ]; then
        logger -p user.info -t rc.local "Missing password.  Will not update ${USER}"
else

if id "${USER}" &>/dev/null; then

PASSWORD=$(cat /srv/.pass)

logger -p user.info -t rc.local "Creating directory /var/lib/${USER}"
mkdir /var/lib/${USER}
chown ${USER}:${USER} /var/lib/${USER}
chmod 700 /var/lib/${USER}
logger -p user.info -t rc.local "Updating passwd entry"
usermod --home /var/lib/${USER} ${USER}
logger -p user.info -t rc.local "Copying /home/${USER} to /var/lib/${USER}"
cp -a /home/${USER}/. /var/lib/${USER}/
logger -p user.info -t rc.local "Removing /home/${USER}"
rm -fr /home/${USER}
logger -p user.info -t rc.local "Updating ${USER} password"
echo "${USER}:${PASSWORD}" | chpasswd

logger -p user.info -t rc.local "Done updating ${USER}"

else
	logger -p user.info -t rc.local "${USER} does not exist."
fi

fi
