FROM node:24.12.0-trixie

COPY bricks /tmp/bricks
RUN bash -x /tmp/bricks/install-base-tools.sh && \
    bash -x /tmp/bricks/install-sonarqube-tools.sh && \
    bash -x /tmp/bricks/install-docker-tools.sh && \
    rm -rf /tmp/bricks

RUN corepack enable
RUN corepack install pnpm --global
