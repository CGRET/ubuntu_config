#!/bin/sh

DEBIAN_FRONTEND=noninteractive apt-get -yq install freeipa-client

# FreeIPA requires fully-qualified hostname
hostnamectl set-hostname $(hostname).maas.dss.cdn.local

