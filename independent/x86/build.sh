#!/bin/bash
set -eux

export WORKSPACE=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)

FIT_JAVA_BRANCH=${1:-"3.5.x"}
APP_PLATFORM_BRANCH=${2:-"develop"}
ELSA_BRANCH=${3:-"elsa-0.1.x"}
IMAGE_VERSION=${4:-"opensource-1.0.0"}

cd ${WORKSPACE}
git clone -b ${FIT_JAVA_BRANCH} https://gitcode.com/ModelEngine/fit-framework.git ${WORKSPACE}/fit-framework
git clone -b ${APP_PLATFORM_BRANCH} https://gitcode.com/ModelEngine/app-platform.git ${WORKSPACE}/app-platform
git clone -b ${ELSA_BRANCH} https://gitcode.com/ModelEngine/fit-framework.git ${WORKSPACE}/elsa

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

sed -i "s/<VERSION>/${IMAGE_VERSION}/g" ${WORKSPACE}/package/docker-compose.yml

bash deploy.sh