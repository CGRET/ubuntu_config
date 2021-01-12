#!/bin/sh

INSTALLED=$(which singularity)
if [ ! "$INSTALLED" -eq "0" ]; then

echo "Install singularity pre-reqs."
apt-get --yes --quiet install build-essential libseccomp-dev pkg-config squashfs-tools cryptsetup


echo "Download, build, and install singularity."

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


fi
