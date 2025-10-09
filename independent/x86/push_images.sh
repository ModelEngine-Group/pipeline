#!/bin/bash

set -eux

export VERSION=${1:-"opensource-default"}
export REPO_PASSWD=${2}
export REPO="crpi-62znuv6vkgxcv731.cn-hangzhou.personal.cr.aliyuncs.com/modelengine-hub"

echo ${REPO_PASSWD} | docker login --username=nick2701484369 crpi-62znuv6vkgxcv731.cn-hangzhou.personal.cr.aliyuncs.com

docker tag app-builder:${VERSION} ${REPO}/app-builder:${VERSION}
docker push ${REPO}/app-builder:${VERSION}

docker tag postgres:15.2-${VERSION} ${REPO}/postgres:15.2-${VERSION}
docker push ${REPO}/postgres:15.2-${VERSION}

docker tag jade-web:${VERSION} ${REPO}/jade-web:${VERSION}
docker push ${REPO}/jade-web:${VERSION}

docker tag fit-runtime-python:${VERSION} ${REPO}/fit-runtime-python:${VERSION}
docker push ${REPO}/fit-runtime-python:${VERSION}

docker tag fit-runtime-java:${VERSION} ${REPO}/fit-runtime-java:${VERSION}
docker push ${REPO}/fit-runtime-java:${VERSION}