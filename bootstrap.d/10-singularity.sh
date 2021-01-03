#!/bin/sh

# Install pre-reqs
sudo apt-get update \
&& sudo apt-get install -y build-essential libseccomp-dev pkg-config squashfs-tools cryptsetup


# Download, build, and install singularity

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

