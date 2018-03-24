#!/bin/sh -e

REMOTE=$(git config --get remote.origin.url)

# shellcheck disable=SC2016
jjm --locator "${REMOTE}" --build-command script/build.sh --checkstyle 'build/log/checkstyle-*.xml' --recipients funtimecoding@gmail.com > job.xml