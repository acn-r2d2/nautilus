#!/usr/bin/env bash
set -euo pipefail

CONFTEST_VERSION=0.66.0
RIPGREP_VERSION=15.1.0

apt-get update
apt-get install -y unzip curl git

curl -fsSL --retry 5 --retry-delay 5 "https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_linux_x86_64.tar.gz" -o /usr/local/bin/conftest.tar.gz
tar -xzf /usr/local/bin/conftest.tar.gz -C /usr/local/bin conftest
chmod +x /usr/local/bin/conftest
rm -f /usr/local/bin/conftest.tar.gz

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}-1_amd64.deb
dpkg -i ripgrep_${RIPGREP_VERSION}-1_amd64.deb
