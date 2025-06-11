#!/bin/bash
set -eux
export WORKSPACE=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)

echo "=== Deploying... ==="
cd ${WORKSPACE}/package
mkdir -p appengine/app-builder
mkdir -p appengine/fit-runtime
mkdir -p appengine/jade-db
mkdir -p appengine/log

echo "Starting service..."
docker-compose up -d
echo "Service started"

echo "=== Finished ==="
