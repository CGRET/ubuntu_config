#!/bin/sh

USER="owner"
logger -p user.info -t bootstrap "Creating ${USER}"

if [ ! -f /srv/.pass ]; then
        logger -p user.info -t bootstrap "Missing password.  Will not create ${USER}"
        exit 0
fi

PASSWORD=$(cat /srv/.pass)

adduser --disabled-password --gecos "" ${USER}

mkdir /${USER}
chown ${USER}:${USER} /${USER}
chmod 700 /${USER}
usermod --home /${USER} ${USER}
cp -a /home/${USER}/. /${USER}/
rm -fr /home/${USER}
echo "${USER}:${PASSWORD}" | chpasswd

# use sudo or wheel
GROUP=$(getent group sudo | cut -d':' -f1)
GROUP=${GROUP:-$(getent group wheel | cut -d':' -f1)}

# If the usermod succeeds then
# create a sudoers.d file for the user.
if usermod -aG ${GROUP} ${USER}; then
  FILE="/etc/sudoers.d/${USER}"
  echo "${USER} ALL=(ALL) NOPASSWD: ALL" > ${FILE}
fi

