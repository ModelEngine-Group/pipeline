#!/bin/bash

set -eux

export VERSION=${1:-"opensource-default"}

docker login

docker tag app-builder:${VERSION} modelengine/app-builder:${VERSION}
docker tag postgres:15.2-${VERSION} modelengine/postgres:15.2-${VERSION}
docker tag jade-web:${VERSION} modelengine/jade-web:${VERSION}
docker tag fit-runtime-python:${VERSION} modelengine/fit-runtime-python:${VERSION}
docker tag fit-runtime-java:${VERSION} modelengine/fit-runtime-java:${VERSION}

docker push modelengine/app-builder:${VERSION}
docker push modelengine/postgres:15.2-${VERSION}
docker push modelengine/jade-web:${VERSION}
docker push modelengine/fit-runtime-python:${VERSION}
docker push modelengine/fit-runtime-java:${VERSION}