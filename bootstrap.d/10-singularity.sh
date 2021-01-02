#!/bin/sh

# Install pre-reqs
sudo apt-get update \
&& sudo apt-get install -y build-essential libseccomp-dev pkg-config squashfs-tools cryptsetup



# Download and extract go into /usr/local
#export VERSION=1.14.12 OS=linux ARCH=amd64 \
#&& wget --quiet -O /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz \
#&& sudo tar -C /usr/local -xzf /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz

# Configure go
#export PATH=/usr/local/go/bin:${PATH}

# sudo snap install go

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

