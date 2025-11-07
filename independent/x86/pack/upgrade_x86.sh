#!/bin/bash

export IS_UPGRADE=true

# 版本格式校验函数
validate_version_format() {
    local version=$1
    # 校验格式 vx.x.x，其中 x 是数字
    if [[ ! $version =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 1
    fi
    return 0
}

while true; do
    echo -n "Please enter previous version (e.g., v1.2.3): "
    read PRE_VERSION

    # 检查是否输入为空
    if [ -z "$PRE_VERSION" ]; then
        echo "Error: Version cannot be empty. Please try again."
        echo
        continue
    fi

    # 校验版本格式
    if validate_version_format "$PRE_VERSION"; then
        echo "Using previous version: $PRE_VERSION"
        echo
        break
    else
        echo "Error: Invalid version format. Please use format 'vx.x.x' where x is number (e.g., v1.2.3)."
        echo
    fi
done

export PRE_VERSION=$PRE_VERSION

echo "=== Upgrading... ==="

mkdir -p appengine/app-builder
mkdir -p appengine/fit-runtime
mkdir -p appengine/jade-db
mkdir -p appengine/log

echo "Starting service"
docker-compose up -d
echo "Service started"

echo "=== Finished ==="
