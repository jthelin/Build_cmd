#!/bin/bash

# Temporary working files
TMP_ENV_VAR_LIST=$(mktemp /tmp/envvar.XXX)
TMP_ORIGIN_INFO=$(mktemp /tmp/origin-info.XXX)
# Auto-delete temporary working files after script exits
trap "rm -f ""${TMP_ENV_VAR_LIST}"" ""${TMP_ORIGIN_INFO}"" " 0 2 3 15

env | sort >"${TMP_ENV_VAR_LIST}"

echo "HOSTNAME=$(hostname)" >"${TMP_ORIGIN_INFO}"
for pattern in '^BUILD_.*' '^CMAKE_BUILD_.*' '^JETBRAINS_.*'
do
    grep --ignore-case "${pattern}" <"${TMP_ENV_VAR_LIST}" >>"${TMP_ORIGIN_INFO}"
done

cat "${TMP_ORIGIN_INFO}"
