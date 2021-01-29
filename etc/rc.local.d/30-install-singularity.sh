#!/bin/bash

if ! command -v singularity; then

logger -p user.info -t "rc.local.${0}" "Install singularity pre-reqs."
apt-get --yes --quiet install build-essential libseccomp-dev pkg-config squashfs-tools cryptsetup


logger -p user.info -t "rc.local.${0}" "Download, build, and install singularity."

pushd .
BUILDDIR=$(mktemp -d)
cd ${BUILDDIR}

export VERSION=3.7.0 && # adjust this as necessary \
wget --quiet https://github.com/hpcng/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz \
&& tar -xzf singularity-${VERSION}.tar.gz \
&&  cd singularity

$(pwd)/mconfig \
&&   cd ./builddir \
&&   make \
&&   sudo make install

popd

logger -p user.info -t "rc.local.${0}" "Done installing singularity."
fi
