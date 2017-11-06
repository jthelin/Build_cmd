#!/bin/bash

# Install .NET Core 2.0 apt-get package.
#
# https://www.microsoft.com/net/learn/get-started/linuxubuntu
#

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# Ubuntu 16.04 / Linux Mint 18
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'

sudo apt-get update
sudo apt-get install dotnet-sdk-2.0.2
