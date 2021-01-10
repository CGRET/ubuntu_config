#!/bin/sh

echo "Install singularity pre-reqs."
apt-get --yes --quiet install build-essential libseccomp-dev pkg-config squashfs-tools cryptsetup


echo "Download, build, and install singularity."

pushd .
mkdir singularity
cd singularity

export VERSION=3.7.0 && # adjust this as necessary \
wget --quiet https://github.com/hpcng/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz \
&& tar -xzf singularity-${VERSION}.tar.gz \
&&  cd singularity

$(pwd)/mconfig \
&&   cd ./builddir \
&&   make \
&&   sudo make install

popd

