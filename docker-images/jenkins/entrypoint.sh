#!/bin/bash
set -e

# Fix Docker socket permissions so jenkins user can connect to the Docker daemon.
# On macOS Docker Desktop the socket mounts as root:root 660 — open it inside the container.
if [ -S /var/run/docker.sock ]; then
    chmod 666 /var/run/docker.sock
fi

# Ensure jenkins owns its home directory (can drift after volume re-create or uid mismatch)
chown -R jenkins:jenkins /var/jenkins_home

exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
