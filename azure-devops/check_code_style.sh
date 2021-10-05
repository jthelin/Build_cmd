#!/bin/bash

# Get the directory path of this script.
CMD_HOME=$( dirname "$(realpath -s "$0")" )
REPO_ROOT=${CMD_HOME}/..

cd "${REPO_ROOT}" || exit

echo "Check Linux scripts using shellcheck"
# https://github.com/koalaman/shellcheck

find . -iname '*.sh' -print0 | xargs -0 shellcheck

# If files have changed, exit with error
if git diff-index --quiet --ignore-submodules HEAD ./*.py; then
    echo "==================================================="
    echo "OK - shellcheck passed OK"
    echo "==================================================="
else
    echo "==================================================="
    echo "##[error] ERROR - Some errors from shellcheck rules"
    git diff
    echo "==================================================="
    exit 1
fi
