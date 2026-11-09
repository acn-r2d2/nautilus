#!/usr/bin/env bash
# Shared helpers. Source this file, do not execute it.

# Usage: download <url> <output-file>
# Retries transient errors (e.g. 504 from release hosts) for up to 5 minutes.
download() {
  curl -fsSL --connect-timeout 20 \
    --retry 8 --retry-delay 20 --retry-max-time 300 \
    "$1" -o "$2"
}
