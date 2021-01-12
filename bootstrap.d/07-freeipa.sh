#!/bin/sh


echo "Installing freeipa-client."
DEBIAN_FRONTEND=noninteractive apt-get -yqq install freeipa-client


# Configuration moved to rc.local.d

