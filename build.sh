#!/bin/sh -e

./run-style-check.sh --ci-mode
./run-metrics.sh --ci-mode
./run-tests.sh --ci-mode
