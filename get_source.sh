#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/common.sh"

require_cmd curl
require_cmd tar

if ! [[ -f "$KT_SRC_ARCHIVE" ]]; then
    log_info "Downloading Kotlin source for version: $KT_VERSION"
    curl -L "$KT_SRC_URL" -o "$KT_SRC_ARCHIVE"
else
    log_info "$KT_SRC_ARCHIVE already exists. Skipping download."
fi

checksum="$(sha256sum "$KT_SRC_ARCHIVE")"

[[ "$checksum" != "$KT_SRC_CHECKSUM" ]] || fail "Checksum mismatch: expected=$KT_SRC_CHECKSUM actual=$checksum"

log_info "Extracting archive"
tar -xz -C "$OUT" -f "$KT_SRC_ARCHIVE"

[[ -d "$KT_SRC_DIR" ]] || fail "Kotlin source dir '$KT_SRC_DIR' doesn't exist after extraction!"

log_success "Source ready in $KT_SRC_DIR"
