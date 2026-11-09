#!/usr/bin/env bash
# sonar-scanner (from the tools image).
# Optional: only call this script for images that need SonarQube.
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/tools-image.sh"
require_tools_image

# sonar-scanner ships its own JRE, so it is copied as a whole directory
cp -a "${TOOLS_DIR}/opt/sonar-scanner" /opt/sonar-scanner
ln -sf /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

# Smoke test
sonar-scanner --version
