variable "REGISTRY" {
  default = "ghcr.io"
}

variable "VERSION" {
  default = "latest"
}

group "all" {
  targets = ["cicd", "cicd-go", "cicd-k8s", "cicd-maven", "cicd-pnpm"]
}

target "cicd" {
  dockerfile = "images/cicd/Dockerfile"
  tags = ["${REGISTRY}/cicd:${VERSION}"]
}

target "cicd-go" {
  dockerfile = "images/cicd-go/Dockerfile"
  tags = ["${REGISTRY}/cicd-go:${VERSION}"]
}

target "cicd-k8s" {
  dockerfile = "images/cicd-k8s/Dockerfile"
  tags = ["${REGISTRY}/cicd-k8s:${VERSION}"]
}

target "cicd-maven" {
  dockerfile = "images/cicd-maven/Dockerfile"
  tags = ["${REGISTRY}/cicd-maven:${VERSION}"]
}

target "cicd-pnpm" {
  dockerfile = "images/cicd-pnpm/Dockerfile"
  tags = ["${REGISTRY}/cicd-pnpm:${VERSION}"]
}
