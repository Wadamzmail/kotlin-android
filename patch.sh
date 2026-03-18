#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/helpers.sh"

require_cmd patch

[[ -d kotlin-src ]] || fail "kotlin-src not found"
[[ -d patches ]] || fail "patches directory not found"

cd kotlin-src

log_info "Applying patches"

for p in $(find ../patches -type f -name '*.patch' | sort); do
  log_info "Applying $p"
  patch -p1 < "../patches/$p"
done

log_success "All patches applied"
