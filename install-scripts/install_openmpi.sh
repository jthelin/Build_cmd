#!/bin/bash

# Download info: https://www.open-mpi.org/software/ompi/v4.0/

OPENMPI_VERSION="4.0.1"
OPENMPI_TARFILE="openmpi-${OPENMPI_VERSION}.tar.gz"
OPENMPI_DOWNLOAD="https://download.open-mpi.org/release/open-mpi/v4.0/${OPENMPI_TARFILE}"
OPENMPI_BUILD="/home/openmpi-${OPENMPI_VERSION}"
OPENMPI_INSTALL="/opt/openmpi"

OPENMPI_HASH_SHA1="93967b5e100b7186f14937e0f41a35a7988134bc"

set -x

curl -fsSL -o "${OPENMPI_TARFILE}" "${OPENMPI_DOWNLOAD}"

echo "${OPENMPI_HASH_SHA1} ${OPENMPI_TARFILE}" | sha1sum -c - && \
echo "Downloaded file integrity checked OK." && \
mkdir -p "${OPENMPI_BUILD}" && \
tar -xf "${OPENMPI_TARFILE}" --strip 1 -C "${OPENMPI_BUILD}"

cd "${OPENMPI_BUILD}" && \
./configure --prefix="${OPENMPI_INSTALL}" && \
make all install
