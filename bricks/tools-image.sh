#!/usr/bin/env bash
# Helpers for taking binaries from the tools image. Source this file, do not execute it.
#
# The tools image must be mounted at /tools:
#   RUN --mount=type=bind,source=bricks,target=/tmp/bricks \
#       --mount=type=bind,from=tools,source=/,target=/tools \
#       bash -x /tmp/bricks/install-....sh

TOOLS_DIR=/tools

# Usage: require_tools_image
require_tools_image() {
  if [ ! -d "${TOOLS_DIR}/usr/local/bin" ]; then
    echo "Tools image is not mounted at ${TOOLS_DIR}." >&2
    echo "Use: RUN --mount=type=bind,from=tools,source=/,target=${TOOLS_DIR} ..." >&2
    exit 1
  fi
}

# Usage: install_tools <name>...
# Copies binaries from the tools image to /usr/local/bin.
install_tools() {
  local tool src
  for tool in "$@"; do
    src="${TOOLS_DIR}/usr/local/bin/${tool}"
    if [ ! -f "${src}" ]; then
      echo "Tool '${tool}' not found in the tools image (${src})" >&2
      return 1
    fi
    install -m 0755 "${src}" "/usr/local/bin/${tool}"
  done
}
