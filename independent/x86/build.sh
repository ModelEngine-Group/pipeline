#!/bin/bash
set -eux

export WORKSPACE=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)
source "${WORKSPACE}/env.sh"

IMAGE_VERSION=${1:-"opensource-1.0.0"}
REPO_PASSWD=${2}

cd ${WORKSPACE}

# 修改 elsa 依赖路径
bash modify.sh

mkdir -p ${WORKSPACE}/output

# 下载 jdk17
mkdir -p ${WORKSPACE}/public
wget -P ${WORKSPACE}/public https://builds.openlogic.com/downloadJDK/openlogic-openjdk/17.0.14+7/openlogic-openjdk-17.0.14+7-linux-x64.tar.gz

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