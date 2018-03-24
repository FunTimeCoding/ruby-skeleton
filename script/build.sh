#!/bin/sh -e

script/check.sh --ci-mode
script/measure.sh --ci-mode
script/test.sh --ci-mode
