#!/bin/bash
set -e

# Fix Docker socket permissions so the jenkins user can connect to the Docker daemon.
# On macOS Docker Desktop the socket is mounted as root:root 660, so we open it to
# all users inside the container (safe for a local dev pipeline).
if [ -S /var/run/docker.sock ]; then
    chmod 666 /var/run/docker.sock
fi

exec gosu jenkins /usr/local/bin/jenkins.sh "$@"
