#!/bin/sh

USER="owner"
echo "Creating ${USER}"

if [ ! -f /srv/.pass ]; then
        echo "Missing password.  Will not create ${USER}"
        exit 0
fi

PASSWORD=$(cat /srv/.pass)

adduser ${USER}

mkdir /${USER}
chown ${USER}:${USER} /${USER}
chmod 700 /${USER}
usermod --home /${USER} ${USER}
cp -a /home/${USER} /${USER}
echo ${PASSWORD} | passwd ${USER}

# use sudo or wheel
GROUP=$(getent group sudo | cut -d':' -f1)
GROUP=${GROUP:-$(getent group wheel | cut -d':' -f1)}

# If the usermod succeeds then
# create a sudoers.d file for the user.
if usermod -aG ${GROUP} ${USER}; then
  FILE="/etc/sudoers.d/${USER}"
  echo "${USER} ALL=(ALL) NOPASSWD: ALL" > ${FILE}
fi

adduser --create-home --home /owner --password ${PASSWORD}

