#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/common.sh"

[[ -d "$KT_SRC_DIR" ]] || fail "kotlin-src not found"
pushd "$KT_SRC_DIR"

require_cmd ./gradlew

TASK=":prepare:ide-plugin-dependencies:analysis-api-standalone-embeddable-for-ide:embeddable"

log_info "Running Gradle task"
./gradlew "$TASK" --dependency-verification=off

log_info "Locating built JAR"

JAR_PATH=$(find prepare/ide-plugin-dependencies -name "analysis-api-standalone-embeddable-for-ide-*-SNAPSHOT.jar" | head -n1)

[[ -f "$JAR_PATH" ]] || fail "JAR not found"

cp "$JAR_PATH" "$OUT/"

popd # kotlin-src

log_success "Copied JAR to $OUT/"
