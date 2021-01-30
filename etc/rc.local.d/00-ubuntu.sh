#!/bin/sh

USER="ubuntu"
logger -p user.info -t rc.local "Updating ${USER}"

if [ ! -f /srv/.pass ]; then
        logger -p user.info -t rc.local "Missing password.  Will not update ${USER}"
        exit 0
fi

if id "${USER}" &>/dev/null; then

PASSWORD=$(cat /srv/.pass)

logger -p user.info -t rc.local "Creating directory /${USER}"
mkdir /${USER}
chown ${USER}:${USER} /${USER}
chmod 700 /${USER}
logger -p user.info -t rc.local "Updating passwd entry"
usermod --home /${USER} ${USER}
logger -p user.info -t rc.local "Copying /home/${USER} to /${USER}"
cp -a /home/${USER}/. /${USER}/
logger -p user.info -t rc.local "Removing /home/${USER}"
rm -fr /home/${USER}
logger -p user.info -t rc.local "Updating ${USER} password"
echo "${USER}:${PASSWORD}" | chpasswd

logger -p user.info -t rc.local "Enabling passwordless sudo for ${USER}"
# use sudo or wheel
GROUP=$(getent group sudo | cut -d':' -f1)
GROUP=${GROUP:-$(getent group wheel | cut -d':' -f1)}

# If the usermod succeeds then
# create a sudoers.d file for the user.
if usermod -aG ${GROUP} ${USER}; then
  FILE="/etc/sudoers.d/${USER}"
  echo "${USER} ALL=(ALL) NOPASSWD: ALL" > ${FILE}
fi

logger -p user.info -t rc.local "Done updating ${USER}"

else
	logger -p user.info -t rc.local "${USER} does not exist."
fi

