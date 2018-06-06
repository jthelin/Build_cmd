#!/bin/bash

# Install .NET Core 2.1 into a Docker container image.
#
# https://github.com/dotnet/dotnet-docker/blob/master/2.1/runtime/stretch-slim/amd64/Dockerfile
#

DOTNET_VERSION=2.1.0
DOTNET_DOWNLOAD_URL=https://dotnetcli.blob.core.windows.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-x64.ta.gz
DOTNET_DOWNLOAD_SHA=f93edfc068290347df57fd7b0221d0d9f9c1717257ed3b3a7b4cc6cc3d779d904194854e13eb924c30eaf7a8cc0bd38263c09178bc4d3e16281f552a45511234

curl -SL --output dotnet.tar.gz $DOTNET_DOWNLOAD_URL \
    && dotnet_sha512=$DOTNET_DOWNLOAD_SHA \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
