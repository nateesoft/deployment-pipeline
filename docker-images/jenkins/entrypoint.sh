#!/bin/bash
set -e

DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

if ! getent group docker; then
  groupadd -g $DOCKER_GID docker
else
  groupmod -g $DOCKER_GID docker
fi

usermod -aG docker jenkins

exec gosu jenkins /usr/local/bin/jenkins.sh