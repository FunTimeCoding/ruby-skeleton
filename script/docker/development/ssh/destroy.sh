#!/bin/sh -e

script/docker/development/ssh/stop.sh || true
docker rm ruby_mine_remote_ssh || true
ssh-keygen -f "${HOME}/.ssh/known_hosts" -R "[localhost]:2222"
