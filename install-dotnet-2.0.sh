#!/bin/bash

# Install .NET Core 2.0 into a Docker container image.
#
# https://github.com/dotnet/dotnet-docker/blob/master/2.0/runtime/stretch/amd64/Dockerfile
#

DOTNET_VERSION=2.0.0
DOTNET_DOWNLOAD_URL=https://dotnetcli.blob.core.windows.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-x64.ta.gz
DOTNET_DOWNLOAD_SHA=2D4A3F8CB275C6F98EC7BE36BEF93A3B4E51CC85C418B9F6A5EEF7C4E0DE53B36587AF5CE23A56BC6584B1DE9265C67C0C3136430E02F47F44F9CFE194219178

curl -SL $DOTNET_DOWNLOAD_URL --output dotnet.tar.gz \
    && echo "$DOTNET_DOWNLOAD_SHA dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
