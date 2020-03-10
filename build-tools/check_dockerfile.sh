#!/bin/bash

DOCKERFILE=${1:-"Dockerfile"}

echo "Check Dockerfile using hadolint"
# https://github.com/hadolint/hadolint
if docker run --rm -i hadolint/hadolint < "${DOCKERFILE}"; then
    echo "OK - Dockerfile lint passed OK"
else
    echo "ERROR - Some errors from Dockerfile lint check"
    exit 1
fi
