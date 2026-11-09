FROM debian:13-slim

ARG SQLFLUFF_VERSION=4.5.0

# Base tools come from the tools image (see images/tools/Dockerfile)
RUN --mount=type=bind,source=bricks,target=/tmp/bricks \
    --mount=type=bind,from=tools,source=/,target=/tools \
    bash -x /tmp/bricks/install-base-tools.sh shfmt && \
    bash -x /tmp/bricks/install-sonarqube-tools.sh && \
    bash -x /tmp/bricks/install-docker-tools.sh

RUN bash -x <<EOT
set -euo pipefail

apt-get install -y python3 python3-pip yamllint shellcheck git
pip install gitlint sqlfluff==${SQLFLUFF_VERSION} --break-system-packages
EOT
