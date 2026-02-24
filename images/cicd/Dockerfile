FROM debian:13-slim

ARG SQLFLUFF_VERSION=4.0.4
ARG SHFMT_VERSION=3.12.0

COPY bricks /tmp/bricks
RUN bash -x /tmp/bricks/install-base-tools.sh && \
    bash -x /tmp/bricks/install-sonarqube-tools.sh && \
    bash -x /tmp/bricks/install-docker-tools.sh && \
    rm -rf /tmp/bricks

RUN bash -x <<EOF
set -euo pipefail

curl -fsSL --retry 5 --retry-delay 5 https://github.com/mvdan/sh/releases/download/v${SHFMT_VERSION}/shfmt_v${SHFMT_VERSION}_linux_amd64 -o /usr/local/bin/shfmt
chmod +x /usr/local/bin/shfmt

apt-get install -y python3 python3-pip yamllint shellcheck git
pip install gitlint sqlfluff==${SQLFLUFF_VERSION} --break-system-packages
EOF
