#!/bin/sh -e

CAMEL=$(echo "${1}" | grep --extended-regexp '^([A-Z]+[a-z0-9]*){2,}$') || CAMEL=""

if [ "${CAMEL}" = "" ]; then
    echo "Usage: ${0} UpperCamelCaseName"

    exit 1
fi

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    SED='gsed'
    FIND='gfind'
else
    SED='sed'
    FIND='find'
fi

DASH=$(echo "${CAMEL}" | sed --regexp-extended 's/([A-Za-z0-9])([A-Z])/\1-\2/g' | tr '[:upper:]' '[:lower:]')
UNDERSCORE=$(echo "${DASH}" | sed --regexp-extended 's/-/_/g')
INITIALS=$(echo "${CAMEL}" | sed 's/\([A-Z]\)[a-z]*/\1/g' | tr '[:upper:]' '[:lower:]')
rm -rf script/skeleton
# shellcheck disable=SC2016
${FIND} . -type f -regextype posix-extended ! -regex '^.*/(build|\.git|\.idea)/.*$' -exec sh -c '${1} -i --expression "s/RubySkeleton/${2}/g" --expression "s/ruby-skeleton/${3}/g" --expression "s/ruby_skeleton/${4}/g" --expression "s/bin\/rs/bin\/${5}/g" "${6}"' '_' "${SED}" "${CAMEL}" "${DASH}" "${UNDERSCORE}" "${INITIALS}" '{}' \;
git mv lib/ruby_skeleton "lib/${UNDERSCORE}"
git mv spec/ruby_skeleton_spec.rb "spec/${UNDERSCORE}_spec.rb"
git mv lib/ruby_skeleton.rb "lib/${UNDERSCORE}.rb"
git mv ruby_skeleton.gemspec "${UNDERSCORE}.gemspec"
git mv bin/rs "bin/${INITIALS}"
echo "# This dictionary file is for domain language." >"documentation/dictionary/${DASH}.dic"
