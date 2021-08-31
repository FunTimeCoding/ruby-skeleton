#!/bin/sh -e

docker pull ruby
docker build --target development-ssh --tag shiin/ruby-mine-remote-ssh:0.0.1 .
HOSTNAME=$(hostname -f)
# shellcheck disable=SC2086
docker run --detach \
    --publish 127.0.0.1:2222:22 \
    --name ruby_mine_remote_ssh \
    --volume "${PWD}:/ruby_skeleton" \
    shiin/ruby-mine-remote-ssh:0.0.1
