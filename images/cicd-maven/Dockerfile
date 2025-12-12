FROM eclipse-temurin:25.0.1_8-jdk-noble

COPY bricks /tmp/bricks
RUN bash -x /tmp/bricks/install-base-tools.sh && \
    bash -x /tmp/bricks/install-sonarqube-tools.sh && \
    bash -x /tmp/bricks/install-docker-tools.sh && \
    rm -rf /tmp/bricks

RUN apt-get install -y maven
