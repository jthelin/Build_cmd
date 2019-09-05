#!/bin/bash

# Install .NET Core 2.2 Runtime into a Docker container image.
#
# https://github.com/dotnet/dotnet-docker/blob/master/2.2/runtime/stretch-slim/amd64/Dockerfile
#

DOTNET_VERSION=2.2.6
DOTNET_DOWNLOAD_URL="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/${DOTNET_VERSION}/dotnet-runtime-${DOTNET_VERSION}-linux-x64.ta.gz"
DOTNET_DOWNLOAD_SHA='8af7a39407b4a3503a7c6d83106336140eeef2bc24decf1b817c7d5a3e5596c8cefed8f211019148cd89a31759d851836dd6147e544b8c1d183dcfbd5a8d4636' \
  
curl -SL --output dotnet.tar.gz $DOTNET_DOWNLOAD_URL \
    && dotnet_sha512=$DOTNET_DOWNLOAD_SHA \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
