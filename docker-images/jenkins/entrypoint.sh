#!/bin/bash
set -e

DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1 || true)

if [ -n "$EXISTING_GROUP" ]; then
  usermod -aG "$EXISTING_GROUP" jenkins
else
  groupadd -g "$DOCKER_GID" docker
  usermod -aG docker jenkins
fi

exec gosu jenkins /usr/local/bin/jenkins.sh