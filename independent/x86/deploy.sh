#!/bin/bash
set -eux
export WORKSPACE=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)
export VERSION=${1:-"opensource-default"}
export REPO="crpi-62znuv6vkgxcv731.cn-hangzhou.personal.cr.aliyuncs.com/modelengine-hub"

echo "=== Deploying... ==="
cd ${WORKSPACE}/package
mkdir -p appengine/app-builder
mkdir -p appengine/fit-runtime
mkdir -p appengine/jade-db
mkdir -p appengine/log

docker tag app-builder:${VERSION} ${REPO}/app-builder:${VERSION}
docker tag postgres:15.2-${VERSION} ${REPO}/postgres:15.2-${VERSION}
docker tag jade-web:${VERSION} ${REPO}/jade-web:${VERSION}
docker tag fit-runtime-python:${VERSION} ${REPO}/fit-runtime-python:${VERSION}
docker tag fit-runtime-java:${VERSION} ${REPO}/fit-runtime-java:${VERSION}

echo "Starting service..."
docker-compose up -d
echo "Service started"

echo "=== Finished ==="
