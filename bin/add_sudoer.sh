#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Error: must be run as root"
  exit 1
fi

if [[ ! ${1} ]]; then
  echo "Error: You must provide a username for an existing user."
  exit 1
fi

# use sudo or wheel
GROUP=$(getent group sudo | cut -d':' -f1)
GROUP=${GROUP:-$(getent group wheel | cut -d':' -f1)}
  
# If the usermod succeeds then 
# create a sudoers.d file for the user.
if usermod -aG ${GROUP} ${1}; then
  FILE="/etc/sudoers.d/${1}"
  echo "${1} ALL=(ALL) NOPASSWD: ALL" > ${FILE}
fi
