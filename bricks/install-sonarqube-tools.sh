#!/usr/bin/env bash
set -euo pipefail

SONAR_SCANNER_CLI_VERSION=7.3.0.5189

curl -fsSL --retry 5 --retry-delay 5 https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_CLI_VERSION}-linux-x64.zip --output /tmp/sonar.zip
unzip /tmp/sonar.zip -d /tmp/sonar
mv /tmp/sonar/sonar-scanner* /opt/sonar-scanner
rm -rf /tmp/sonar*
ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner
