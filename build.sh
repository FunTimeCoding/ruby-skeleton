#!/bin/sh -e

CLEAN=0

while true; do
    case ${1} in
        -h|--help)
            echo "Usage: [-h|--help][-v|--verbose][-c|--clean][-w|--workspace WORKSPACE]"

            exit 0
            ;;
        -v|--verbose)
            set -x
            shift
            ;;
        -c|--clean)
            CLEAN=1
            shift
            ;;
        -w|--workspace)
            WORKSPACE="${2-}"
            shift 2
            ;;
        --)
            shift

            break
            ;;
        *)
            if [ ! "${1}" = "" ]; then
                echo "Unknown option: ${1}"
            fi

            break
            ;;
    esac
done

if [ "${WORKSPACE}" = "" ]; then
    DIR=$(dirname "${0}")
    SCRIPT_DIR=$(cd "${DIR}"; pwd)
    WORKSPACE="${SCRIPT_DIR}"
fi

echo "WORKSPACE: ${WORKSPACE}"

if [ "${CLEAN}" = "1" ]; then
    "${WORKSPACE}/clear-cache.sh"
fi

"${WORKSPACE}/run-style-check.sh" --ci-mode
"${WORKSPACE}/run-metrics.sh" --ci-mode
"${WORKSPACE}/run-tests.sh" --ci-mode
