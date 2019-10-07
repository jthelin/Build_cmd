#!/bin/bash

# Install .NET Core SDK apt-get package on Ubuntu etc.
#
# https://www.microsoft.com/net/learn/get-started/linuxubuntu
#

DOTNET_SDK_VERSION=2.2

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# For Ubuntu / Linux Mint
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'

sudo apt-get update
sudo apt-get install "dotnet-sdk-${DOTNET_SDK_VERSION}"
