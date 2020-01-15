#!/bin/bash

if [ "$1" != "" ]; then
  INSTALL_ROOT=$1
else
  INSTALL_ROOT=/opt
fi

# This is the same version of cmake included in Visual Studio 2019
CMAKE_VERSION="3.15.3"

# Download info: https://github.com/Kitware/CMake/releases

CMAKE_HASH_SHA256="020812a9f87293482cec51fdf44f41cc47e794de568f945a8175549d997e1760"
CMAKE_TARFILE="cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz"
CMAKE_DOWNLOAD="https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_TARFILE}"
CMAKE_INSTALL="${INSTALL_ROOT}/cmake"

curl -fsSL -o "${CMAKE_TARFILE}" "${CMAKE_DOWNLOAD}"

echo "Installing cmake v${CMAKE_VERSION} to ${CMAKE_INSTALL}"

sudo mkdir -p "${CMAKE_INSTALL}" && \
echo "${CMAKE_HASH_SHA256} ${CMAKE_TARFILE}" | sha256sum --check - && \
echo "Downloaded file integrity checked OK." && \
sudo tar -xf "${CMAKE_TARFILE}" --strip 1 -C "${CMAKE_INSTALL}"
