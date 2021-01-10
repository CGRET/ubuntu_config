#!/bin/sh

echo "Checking for NVIDIA GPUs:"
NVIDIA_GPU=$(lspci | grep VGA | grep NVIDIA | wc -l)
if [ "$NVIDIA_GPU" -eq "0" ]; then
	echo "No NVIDIA GPU found."
	exit 0
fi

echo "${NVIDIA_GPU} NVIDIA GPU(s) found."

echo "Installing NVIDIA GPU drivers and software."
add-apt-repository --yes ppa:graphics-drivers/ppa
apt update
apt-get --yes --quiet install ubuntu-drivers-common
ubuntu-drivers autoinstall

echo "Installing CUDA in /usr."
apt-get --yes --quite install nvidia-cuda-toolkit

# echo "Installing NCCL"
#apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
#wget --quiet https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
#dpkg -i nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
#apt update
#apt --yes install libnccl2 libnccl-dev

