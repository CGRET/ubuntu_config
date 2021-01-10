#!/bin/sh

echo "Creating users and groups for slurm and munge."
adduser -u 1111 munge --disabled-password --gecos ""
adduser -u 1121 slurm --disabled-password --gecos ""

