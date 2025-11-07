#!/bin/bash
set -eux

export WORKSPACE=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)
source "${WORKSPACE}/env.sh"

IMAGE_VERSION=${1:-"opensource-1.0.0"}
REPO_PASSWD=${2}

cd ${WORKSPACE}

mkdir -p ${WORKSPACE}/output

cd ${WORKSPACE}
echo "=== Building app-builder... ==="
bash framework/fit/java/build.sh ${IMAGE_VERSION}
echo "=== Finished app-builder ==="

echo "=== Building fit-runtime-java... ==="
bash framework/fit/fit-java/build.sh ${IMAGE_VERSION}
echo "=== Finished fit-runtime-java ==="

echo "=== Building fit-runtime-python... ==="
bash framework/fit/fit-python/build.sh ${IMAGE_VERSION}
echo "=== Finished fit-runtime-python ==="

echo "=== Building web... ==="
bash frontend/build.sh ${IMAGE_VERSION}
echo "=== Finished web ==="

echo "=== Building db... ==="
bash db/postgresql/x86_64/build.sh ${IMAGE_VERSION}
echo "=== Finished db ==="

bash push_images.sh ${IMAGE_VERSION} ${REPO_PASSWD}