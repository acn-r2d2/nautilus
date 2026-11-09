FROM eclipse-temurin:25.0.5_8-jdk-noble

# Base tools come from the tools image (see images/tools/Dockerfile)
RUN --mount=type=bind,source=bricks,target=/tmp/bricks \
    --mount=type=bind,from=tools,source=/,target=/tools \
    bash -x /tmp/bricks/install-base-tools.sh && \
    bash -x /tmp/bricks/install-sonarqube-tools.sh && \
    bash -x /tmp/bricks/install-docker-tools.sh

RUN apt-get install -y maven
