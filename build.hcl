variable "REGISTRY" {
  default = "ghcr.io"
}

variable "VERSION" {
  default = "latest"
}

group "all" {
  targets = ["cicd", "cicd-go", "cicd-rust", "cicd-k8s", "cicd-maven", "cicd-pnpm"]
}

# All downloaded binaries are x86_64 builds, so every target is pinned to linux/amd64.

# Downloads all release binaries once. The images take them via
# RUN --mount=type=bind,from=tools. Bake builds it automatically as a dependency.
target "tools" {
  dockerfile = "images/tools/Dockerfile"
  platforms = ["linux/amd64"]
  tags = ["${REGISTRY}/tools:${VERSION}"]
}

# Shared by all image targets: platform plus the tools image as named context "tools"
target "_common" {
  platforms = ["linux/amd64"]
  contexts = {
    tools = "target:tools"
  }
}

target "cicd" {
  inherits = ["_common"]
  dockerfile = "images/cicd/Dockerfile"
  tags = ["${REGISTRY}/cicd:${VERSION}"]
}

target "cicd-go" {
  inherits = ["_common"]
  dockerfile = "images/cicd-go/Dockerfile"
  tags = ["${REGISTRY}/cicd-go:${VERSION}"]
}

target "cicd-rust" {
  inherits = ["_common"]
  dockerfile = "images/cicd-rust/Dockerfile"
  tags = ["${REGISTRY}/cicd-rust:${VERSION}"]
}

target "cicd-k8s" {
  inherits = ["_common"]
  dockerfile = "images/cicd-k8s/Dockerfile"
  tags = ["${REGISTRY}/cicd-k8s:${VERSION}"]
}

target "cicd-maven" {
  inherits = ["_common"]
  dockerfile = "images/cicd-maven/Dockerfile"
  tags = ["${REGISTRY}/cicd-maven:${VERSION}"]
}

target "cicd-pnpm" {
  inherits = ["_common"]
  dockerfile = "images/cicd-pnpm/Dockerfile"
  tags = ["${REGISTRY}/cicd-pnpm:${VERSION}"]
}
