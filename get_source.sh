#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/helpers.sh"

TAG="${1:-}"

[[ -z "$TAG" ]] && fail "usage: $0 <kotlin-release-tag>"

require_cmd curl
require_cmd tar

REPO_URL="https://github.com/JetBrains/kotlin/archive/refs/tags/${TAG}.tar.gz"
ARCHIVE="kotlin-${TAG}.tar.gz"
SRC_DIR="kotlin-${TAG}"

log_info "Downloading Kotlin source for tag: $TAG"
curl -L "$REPO_URL" -o "$ARCHIVE"

log_info "Extracting archive"
tar -xzf "$ARCHIVE"

log_info "Normalizing directory"
rm -rf kotlin-src
mv "$SRC_DIR" kotlin-src

log_success "Source ready in ./kotlin-src"
