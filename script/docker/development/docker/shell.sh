#!/bin/sh -e

# shellcheck disable=SC2086
docker run --rm --interactive --tty --entrypoint sh --volume ${PWD}:/ruby_skeleton shiin/ruby-mine-remote-docker:0.0.1
