#!/bin/sh

echo "Creating owner"

if [ ! -f /srv/.pass ]; then
        echo "Missing password.  Will not create owner"
        exit 0
fi

PASSWORD=$(cat /srv/.pass)

adduser --create-home --home /owner --password ${PASSWORD}

