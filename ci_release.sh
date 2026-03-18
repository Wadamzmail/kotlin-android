#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/helpers.sh"

require_cmd gh
require_cmd sha256sum
require_cmd git

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
[[ "$BRANCH" != "main" ]] && fail "Not on main branch"

JAR=$(find outputs -type f -name '*.jar' | head -n1)
[[ -f "$JAR" ]] || fail "No JAR found in outputs/"

FILENAME=$(basename "$JAR")

KOTLIN_VERSION=$(echo "$FILENAME" | sed -E 's/.*-([0-9]+\.[0-9]+\.[0-9]+)-SNAPSHOT.*/\1/')
TAG="$KOTLIN_VERSION"

log_info "Computing checksum"
SHA256=$(sha256sum "$JAR" | awk '{print $1}')

NOTES=$(cat <<EOF
Kotlin Version: $KOTLIN_VERSION

Artifact: $FILENAME

SHA256: $SHA256
EOF
)

log_info "Creating GitHub release: $TAG"

gh release create "$TAG" "$JAR" \
  --title "Kotlin $KOTLIN_VERSION (patched build)" \
  --notes "$NOTES"

log_success "Release created"
