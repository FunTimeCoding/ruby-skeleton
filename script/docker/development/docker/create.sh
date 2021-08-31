#!/bin/sh -e

docker pull ruby
docker build --target development-docker --tag shiin/ruby-mine-remote-docker:0.0.1 .
# This is not used by the IDE. It is for separate work with a shell.
docker create --name ruby_mine_remote_docker shiin/ruby-mine-remote-docker:0.0.1
