FROM debian:13-slim

# Base tools come from the tools image (see images/tools/Dockerfile);
RUN --mount=type=bind,source=bricks,target=/tmp/bricks \
    --mount=type=bind,from=tools,source=/,target=/tools \
    bash -x /tmp/bricks/install-base-tools.sh helm kube-score kubeconform && \
    bash -x /tmp/bricks/install-sonarqube-tools.sh && \
    bash -x /tmp/bricks/install-docker-tools.sh
