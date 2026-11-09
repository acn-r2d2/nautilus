#!/usr/bin/env bash
# Base setup for every image: apt basics plus conftest, rg and git-cliff.
#
# Extra tools from the tools image can be passed as arguments:
#   install-base-tools.sh                 # base only
#   install-base-tools.sh shfmt           # base + shfmt
#   install-base-tools.sh helm kube-score kubeconform
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/tools-image.sh"
require_tools_image

# The apt lists are kept on purpose: later RUN steps (e.g. apt-get install maven)
# rely on them.
apt-get update
apt-get install -y ca-certificates curl git unzip

install_tools conftest rg git-cliff "$@"

# Smoke test: fails the build if a binary does not run on this base image
conftest --version
rg --version
git-cliff --version
