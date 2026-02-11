FROM debian:13-slim

ARG HELM_VERSION=4.1.1
ARG KUBE_SCORE_VERSION=1.20.0
ARG KUBECONFORM_VERSION=0.7.0

COPY bricks /tmp/bricks
RUN bash -x /tmp/bricks/install-base-tools.sh && \
    bash -x /tmp/bricks/install-sonarqube-tools.sh && \
    bash -x /tmp/bricks/install-docker-tools.sh && \
    rm -rf /tmp/bricks

RUN bash -x <<EOF
set -euo pipefail

apt-get install -y curl tar gzip

cd /tmp

curl -fsSL --retry 5 --retry-delay 5 "https://github.com/zegl/kube-score/releases/download/v${KUBE_SCORE_VERSION}/kube-score_${KUBE_SCORE_VERSION}_linux_amd64.tar.gz" -o kube-score.tar.gz
tar -xzf kube-score.tar.gz
mv kube-score /usr/local/bin/
chmod +x /usr/local/bin/kube-score
rm -rf kube-score*

curl -fsSL --retry 5 --retry-delay 5 "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" -o helm.tar.gz
tar -xzf helm.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
chmod +x /usr/local/bin/helm
rm -rf helm*


curl -fsSL --retry 5 --retry-delay 5 "https://github.com/yannh/kubeconform/releases/download/v${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz" -o kubeconform.tar.gz
tar -xzf kubeconform.tar.gz
mv kubeconform /usr/local/bin/kubeconform
chmod +x /usr/local/bin/kubeconform
rm -rf kubeconform*
EOF
