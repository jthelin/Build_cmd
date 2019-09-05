#!/bin/bash

# Install .NET Core 2.1 Runtime into a Docker container image.
#
# https://github.com/dotnet/dotnet-docker/blob/master/2.1/runtime/stretch-slim/amd64/Dockerfile
#

DOTNET_VERSION=2.1.12
DOTNET_DOWNLOAD_URL="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/${DOTNET_VERSION}/dotnet-runtime-${DOTNET_VERSION}-linux-x64.ta.gz"
DOTNET_DOWNLOAD_SHA='9b6d07e180ba1d19f0b00263af9dcf3147b0869564ef82ec20584b25d801a2d5c353f0f2bd7bd7e92e75ceb4e4bca35ec3eade73a2b25a0306d4d95ef5071a08'

curl -SL --output dotnet.tar.gz ${DOTNET_DOWNLOAD_URL} \
    && dotnet_sha512=${DOTNET_DOWNLOAD_SHA} \
    && echo "${dotnet_sha512} dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
