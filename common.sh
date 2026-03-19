#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(dirname "$0")"
SCRIPT_DIR="$(realpath "$SCRIPT_DIR")"
export SCRIPT_DIR

source "$SCRIPT_DIR/helpers.sh"

export OUT="$SCRIPT_DIR/out"
mkdir -p "$OUT"

export KT_VERSION="2.3.20"
export KT_SRC_ARCHIVE="${OUT}/kotlin-v${KT_VERSION}.tar.gz"
export KT_SRC_DIR="${OUT}/kotlin-${KT_VERSION}"
export KT_SRC_URL="https://github.com/JetBrains/kotlin/archive/refs/tags/v${KT_VERSION}.tar.gz"
export KT_SRC_CHECKSUM="0de60619d72ea5b8e2f149c56c6566e7cae65b27bebb8c6d0e3b5436b9bcbe57"

export PATCHES_DIR="$SCRIPT_DIR/patches"
