#!/bin/sh

# Install pre-reqs
sudo apt-get update \
&& sudo apt-get install -y build-essential libseccomp-dev pkg-config squashfs-tools cryptsetup sudo


# Download go
export VERSION=1.14.12 OS=linux ARCH=amd64 wget -O /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz
https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz \ && sudo tar -C /usr/local -xzf
/tmp/go${VERSION}.${OS}-${ARCH}.tar.gz

# Configure go
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc \
&& echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc \
&& source ~/.bashrc

# curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(go env GOPATH)/bin v1.21.0


# Download, build, and install singularity

pushd .
mkdir singularity
cd singularity

wget https://github.com/hpcng/singularity/releases/download/v3.7.0/singularity-3.7.0.tar.gz
tar xzf singularity-3.7.0.tar.gz

cd singularity/
$(pwd)/mconfig \
&&   cd ./builddir \
&&   make \
&&   sudo make install

popd

