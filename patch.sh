#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/common.sh"

[[ -d "$KT_SRC_DIR" ]] || fail "kotlin-src not found"
[[ -d "$PATCHES_DIR" ]] || fail "patches directory not found"

log_info "Applying patches"

require_cmd git

pushd "$KT_SRC_DIR"

for p in $(find "$PATCHES_DIR" -type f -name "*.patch" | sort); do
  log_info "Applying $p (patch)"
  patch -p1 <"$p" || fail "patch failed on $p"
done

popd

log_success "All patches applied"
