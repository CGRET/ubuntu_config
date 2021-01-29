#!/bin/sh

USER="ubuntu"
logger -p user.info -t "rc.local.${0}" "Updating ${USER}"

if [ ! -f /srv/.pass ]; then
        logger -p user.info -t "rc.local.${0}" "Missing password.  Will not update ${USER}"
        exit 0
fi

PASSWORD=$(cat /srv/.pass)

logger -p user.info -t "rc.local.${0}" "Creating directory /${USER}"
mkdir /${USER}
chown ${USER}:${USER} /${USER}
chmod 700 /${USER}
logger -p user.info -t "rc.local.${0}" "Updating passwd entry"
usermod --home /${USER} ${USER}
logger -p user.info -t "rc.local.${0}" "Copying /home/${USER} to /${USER}"
cp -a /home/${USER}/. /${USER}/
logger -p user.info -t "rc.local.${0}" "Removing /home/${USER}"
rm -fr /home/${USER}
logger -p user.info -t "rc.local.${0}" "Updating ${USER} password"
echo "${USER}:${PASSWORD}" | chpasswd

logger -p user.info -t "rc.local.${0}" "Enabling passwordless sudo for ${USER}"
# use sudo or wheel
GROUP=$(getent group sudo | cut -d':' -f1)
GROUP=${GROUP:-$(getent group wheel | cut -d':' -f1)}

# If the usermod succeeds then
# create a sudoers.d file for the user.
if usermod -aG ${GROUP} ${USER}; then
  FILE="/etc/sudoers.d/${USER}"
  echo "${USER} ALL=(ALL) NOPASSWD: ALL" > ${FILE}
fi

logger -p user.info -t "rc.local.${0}" "Done updating ${USER}"
