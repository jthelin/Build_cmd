#!/bin/bash

# From: https://www.mono-project.com/download/stable/#download-lin-ubuntu

set -x

sudo apt-get install --yes --no-install-recommends --quiet \
    ca-certificates \
    gnupg \
    lsb-release

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --receive-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list

sudo apt-get update

sudo apt-get install --yes --no-install-recommends --quiet \
    mono-devel
