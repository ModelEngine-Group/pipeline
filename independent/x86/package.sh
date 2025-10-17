#!/bin/bash
set -eux
export WORKSPACE=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)
MODEL_ENGINE_VERSION=${1:-"v25.05.15"}
CPU_ARCH=${2:-"x86_64"}

echo "=== Packaging... ==="
cd ${WORKSPACE}/pack
zip -r ModelEngine_${MODEL_ENGINE_VERSION}_${CPU_ARCH}.zip .

echo "=== Finished ==="
