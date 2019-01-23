#!/bin/bash

echo "System configuration info for host $HOSTNAME"

echo .
echo uname
echo .
uname -a

echo .
echo os-release
echo .
cat /etc/os-release

echo .
echo lscpu
echo .
lscpu

# echo .
# echo meminfo
# echo .
# cat /proc/meminfo

echo .
echo Show NVIDIA Kernel Modules and Packages Installed
echo .

( lspci | grep -i NVIDIA ) || echo "WARNING: No NVIDIA modules found."

for pkg in NVIDIA CUDA NCCL
do
    echo .
    echo "$pkg Packages"
    dpkg-query --list "*${pkg,,*}*"
done

if [ `which nvidia-smi` ]
then

echo .
echo nvidia device info
echo .
nvidia-container-cli --load-kmods info
echo .
echo nvidia driver info
echo .
nvidia-container-cli list

echo .
echo nvidia-smi
echo .
nvidia-smi

echo .
echo nvidia-topo
echo .
nvidia-smi topo -m

else
    echo !
    echo "WARNING: nvidia-smi app was not found."
    echo !
fi
