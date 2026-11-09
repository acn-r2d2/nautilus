# syntax=docker/dockerfile:1
#
# Downloads all release binaries once. The other images copy what they need:
#   COPY --from=tools / /
#   COPY --from=tools /usr/local/bin/shfmt /usr/local/bin/shfmt
#
# Build only via buildx bake (named context "tools"), not plain `docker build`.

FROM debian:13-slim AS fetch

ARG CONFTEST_VERSION=0.71.1
ARG RIPGREP_VERSION=15.2.0
ARG GIT_CLIFF_VERSION=2.14.2
ARG SONAR_SCANNER_CLI_VERSION=8.1.0.6389
ARG HADOLINT_VERSION=2.15.1
ARG SHFMT_VERSION=3.14.1
ARG HELM_VERSION=4.3.1
ARG KUBE_SCORE_VERSION=1.20.0
ARG KUBECONFORM_VERSION=0.8.0

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl tar gzip unzip \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /rootfs/usr/local/bin /rootfs/opt

COPY bricks/lib.sh /usr/local/lib/lib.sh

# One RUN per tool: bumping a version only re-downloads that tool.

RUN source /usr/local/lib/lib.sh \
 && download "https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_linux_x86_64.tar.gz" /tmp/conftest.tar.gz \
 && tar -xzf /tmp/conftest.tar.gz -C /rootfs/usr/local/bin conftest \
 && rm /tmp/conftest.tar.gz

# Static musl build instead of the .deb, so no dpkg is needed in the target images
RUN source /usr/local/lib/lib.sh \
 && download "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz" /tmp/rg.tar.gz \
 && tar -xzf /tmp/rg.tar.gz -C /rootfs/usr/local/bin --strip-components=1 --wildcards '*/rg' \
 && rm /tmp/rg.tar.gz

RUN source /usr/local/lib/lib.sh \
 && download "https://github.com/orhun/git-cliff/releases/download/v${GIT_CLIFF_VERSION}/git-cliff-${GIT_CLIFF_VERSION}-x86_64-unknown-linux-gnu.tar.gz" /tmp/git-cliff.tar.gz \
 && tar -xzf /tmp/git-cliff.tar.gz -C /rootfs/usr/local/bin --strip-components=1 "git-cliff-${GIT_CLIFF_VERSION}/git-cliff" \
 && rm /tmp/git-cliff.tar.gz

# The scanner ships its own JRE. The symlink target is absolute on purpose:
# it resolves correctly once the tree is copied to / in the target image.
RUN source /usr/local/lib/lib.sh \
 && download "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_CLI_VERSION}-linux-x64.zip" /tmp/sonar.zip \
 && unzip -q /tmp/sonar.zip -d /tmp/sonar \
 && mv /tmp/sonar/sonar-scanner-* /rootfs/opt/sonar-scanner \
 && ln -s /opt/sonar-scanner/bin/sonar-scanner /rootfs/usr/local/bin/sonar-scanner \
 && rm -rf /tmp/sonar /tmp/sonar.zip

RUN source /usr/local/lib/lib.sh \
 && download "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64" /rootfs/usr/local/bin/hadolint \
 && chmod +x /rootfs/usr/local/bin/hadolint

RUN source /usr/local/lib/lib.sh \
 && download "https://github.com/mvdan/sh/releases/download/v${SHFMT_VERSION}/shfmt_v${SHFMT_VERSION}_linux_amd64" /rootfs/usr/local/bin/shfmt \
 && chmod +x /rootfs/usr/local/bin/shfmt

RUN source /usr/local/lib/lib.sh \
 && download "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" /tmp/helm.tar.gz \
 && tar -xzf /tmp/helm.tar.gz -C /rootfs/usr/local/bin --strip-components=1 linux-amd64/helm \
 && rm /tmp/helm.tar.gz

RUN source /usr/local/lib/lib.sh \
 && download "https://github.com/zegl/kube-score/releases/download/v${KUBE_SCORE_VERSION}/kube-score_${KUBE_SCORE_VERSION}_linux_amd64.tar.gz" /tmp/kube-score.tar.gz \
 && tar -xzf /tmp/kube-score.tar.gz -C /rootfs/usr/local/bin kube-score \
 && rm /tmp/kube-score.tar.gz

RUN source /usr/local/lib/lib.sh \
 && download "https://github.com/yannh/kubeconform/releases/download/v${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz" /tmp/kubeconform.tar.gz \
 && tar -xzf /tmp/kubeconform.tar.gz -C /rootfs/usr/local/bin kubeconform \
 && rm /tmp/kubeconform.tar.gz

# Smoke test: fails the build if an archive layout or asset name is wrong
RUN export PATH="/rootfs/usr/local/bin:${PATH}" \
 && conftest --version \
 && rg --version \
 && git-cliff --version \
 && hadolint --version \
 && shfmt --version \
 && helm version --short \
 && kube-score version \
 && kubeconform -v \
 && /rootfs/opt/sonar-scanner/bin/sonar-scanner --version

# Final stage contains only the finished file tree
FROM scratch AS tools
COPY --from=fetch /rootfs/ /
