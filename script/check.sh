#!/bin/sh -e

if [ "$(command -v shellcheck || true)" = "" ]; then
    echo "Command not found: shellcheck"

    exit 1
fi

CONTINUOUS_INTEGRATION_MODE=false

if [ "${1}" = "--ci-mode" ]; then
    shift
    mkdir -p build/log
    CONTINUOUS_INTEGRATION_MODE=true
fi

#     12345678901234567890123456789012345678901234567890123456789012345678901234567890
echo "================================================================================"
echo
echo "Running RuboCop."

if [ "${CONTINUOUS_INTEGRATION_MODE}" = true ]; then
    rubocop | tee build/log/rubocop.txt || true
else
    rubocop || true
fi

echo
echo "================================================================================"

if [ "${CONTINUOUS_INTEGRATION_MODE}" = true ]; then
    roodi "**/*.rb" | tee build/log/roodi.txt
else
    roodi "**/*.rb"
fi

echo
echo "================================================================================"
echo
echo "Running flog."
echo

if [ "${CONTINUOUS_INTEGRATION_MODE}" = true ]; then
    find . -name '*.rb' -exec sh -c 'flog ${1}' '_' '{}' \; | tee build/log/flog.txt
else
    find . -name '*.rb' -exec sh -c 'echo ${1}; flog ${1}' '_' '{}' \;
fi

echo
echo "================================================================================"
echo
echo "Run ShellCheck."

if [ "${CONTINUOUS_INTEGRATION_MODE}" = true ]; then
    # shellcheck disable=SC2016
    find . -name '*.sh' -and -not -path '*/vendor/*' -exec sh -c 'shellcheck ${1} || true' '_' '{}' \; | tee build/log/shellcheck.txt
else
    # shellcheck disable=SC2016
    find . -name '*.sh' -and -not -path '*/vendor/*' -exec sh -c 'shellcheck ${1} || true' '_' '{}' \;
fi

echo
echo "================================================================================"
