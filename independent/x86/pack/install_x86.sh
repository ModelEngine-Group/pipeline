#!/bin/bash

echo "=== Deploying... ==="

mkdir -p appengine/app-builder
mkdir -p appengine/fit-runtime
mkdir -p appengine/jade-db
mkdir -p appengine/log

echo "Starting service"
docker-compose up -d
echo "Service started"

echo "=== Finished ==="
