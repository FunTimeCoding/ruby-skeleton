#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(
    cd "${DIRECTORY}" || exit 1
    pwd
)
ruby -I "${SCRIPT_DIRECTORY}/../lib" "${SCRIPT_DIRECTORY}/rs"
