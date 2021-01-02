#!/bin/sh

# Create users and groups for slurm and munge
adduser -u 1111 munge --disabled-password --gecos ""
adduser -u 1121 slurm --disabled-password --gecos ""

#addgroup -gid 1111 munge
#addgroup -gid 1121 slurm
adduser -u 1111 munge --disabled-password --gecos "" -gid 1111
adduser -u 1121 slurm --disabled-password --gecos "" -gid 1121

