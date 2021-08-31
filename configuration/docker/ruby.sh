#!/bin/sh -e

export GEM_HOME=/usr/local/bundle
export BUNDLE_PATH=/usr/local/bundle
export BUNDLE_SILENCE_ROOT_WARNING=1
export BUNDLE_APP_CONFIG="${GEM_HOME}"
export PATH="${GEM_HOME}/bin:${PATH}"
