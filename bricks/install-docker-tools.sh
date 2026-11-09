#!/usr/bin/env bash
# Docker CLI (from Docker's apt repository) and hadolint (from the tools image).
# Optional: only call this script for images that need Docker tooling.
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
source "$(dirname "${BASH_SOURCE[0]}")/tools-image.sh"
require_tools_image

if [ ! -f /etc/os-release ]; then
  echo "Cannot detect OS" >&2
  exit 1
fi
. /etc/os-release
DISTRO=${ID} # e.g. "debian" or "ubuntu"

# Add Docker's official GPG key
apt-get update
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
download "https://download.docker.com/linux/${DISTRO}/gpg" /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources
cat > /etc/apt/sources.list.d/docker.sources <<DOCKER_SOURCES
Types: deb
URIs: https://download.docker.com/linux/${DISTRO}
Suites: ${VERSION_CODENAME}
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
DOCKER_SOURCES

apt-get update
apt-get install -y docker-ce-cli docker-buildx-plugin

install_tools hadolint

# Smoke test
docker --version
hadolint --version
