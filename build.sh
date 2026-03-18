#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/helpers.sh"

require_cmd ./gradlew

[[ -d kotlin-src ]] || fail "kotlin-src not found"

cd kotlin-src

TASK=":prepare:ide-plugin-dependencies:analysis-api-standalone-embeddable-for-ide:embeddable"

log_info "Running Gradle task"
./gradlew "$TASK"

log_info "Locating built JAR"

JAR_PATH=$(find prepare/ide-plugin-dependencies -name "analysis-api-standalone-embeddable-for-ide-*-SNAPSHOT.jar" | head -n1)

[[ -f "$JAR_PATH" ]] || fail "JAR not found"

mkdir -p ../outputs
cp "$JAR_PATH" ../outputs/

log_success "Copied JAR to outputs/"