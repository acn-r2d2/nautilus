#!/usr/bin/env bash
set -euo pipefail

HADOLINT_VERSION=2.14.0

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID    # z.B. "ubuntu" oder "debian"
else
    echo "Cannot detect OS"
    exit 1
fi

# Add Docker's official GPG key
apt-get update
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL --retry 5 --retry-delay 5 https://download.docker.com/linux/${DISTRO}/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/${DISTRO}
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

apt-get update
apt-get install -y docker-ce-cli docker-buildx-plugin

curl -fsSL --retry 5 --retry-delay 5 https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64 -o /usr/local/bin/hadolint
chmod +x /usr/local/bin/hadolint
