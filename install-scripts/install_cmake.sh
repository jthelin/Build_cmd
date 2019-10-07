#!/bin/bash

# Download info: https://github.com/Kitware/CMake/releases

CMAKE_VERSION="3.13.2"
CMAKE_TARFILE="cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz"
CMAKE_DOWNLOAD="https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_TARFILE}"
CMAKE_INSTALL="/opt/cmake"

CMAKE_RELEASE_PGP_SIG="EC8FEF3A7BFB4EDA"
# http://pool.sks-keyservers.net:11371/pks/lookup?op=get&search=0xCBA23971357C2E6590D9EFD3EC8FEF3A7BFB4EDA

gpg --receive-keys "${CMAKE_RELEASE_PGP_SIG}"

set -x

curl -fsSL -o "${CMAKE_TARFILE}" "${CMAKE_DOWNLOAD}"

mkdir -p "${CMAKE_INSTALL}" && \
tar -xf "${CMAKE_TARFILE}" --strip 1 -C "${CMAKE_INSTALL}"
