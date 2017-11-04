#!/bin/bash

# Install docker-ce on Linux.
#
# Based on: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository

cat /etc/os-release


# Remove any outdated copies of docker.
sudo apt-get remove docker docker-engine docker.io


# Add the GPG key for the official Docker repository to the system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Check Docker's official GPG key is registered.
sudo apt-key fingerprint 0EBFCD88

# Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

# Install docker-ce package.
sudo apt-get install docker-ce

# Check status of docker daemon.
sudo systemctl status docker

docker --version

# Verify  Docker CE is correctly installed and running.
sudo docker run hello-world

# Show Docker config files.
for cfg in /etc/init.d/docker /etc/default/docker /etc/init/docker.conf ; do echo $cfg ; sudo cat $cfg ; done

# Ubuntu 16.04 and above uses systemd to manage which services start when the system boots. 
# Ubuntu 14.10 and below uses upstart.
# https://docs.docker.com/engine/admin/systemd/
