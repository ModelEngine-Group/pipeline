#!/usr/bin/bash
set -ex

workdir=$(cd $(dirname $0); pwd)
cd $workdir
CURRENT_WORKSPACE=${WORKSPACE}/db/postgresql/x86_64
CURRENT_BUILD_DIR=${CURRENT_WORKSPACE}/build
base_image="quay.io/openeuler/openeuler:latest"
mkdir -p ${CURRENT_BUILD_DIR}

VERSION=${1:-"opensource-1.0.0"}
PLATFORM=x86_64
ENV_TYPE=x86_64
arch_type=x86_64
packageDir=${CURRENT_BUILD_DIR}/package
mkdir -p ${packageDir}
rm -rf ${packageDir}/*

cd ${packageDir}

cp ${CURRENT_WORKSPACE}/root ${packageDir}
cp ${CURRENT_WORKSPACE}/Dockerfile ${packageDir}
cp ${CURRENT_WORKSPACE}/db* ${packageDir}
cp ${CURRENT_WORKSPACE}/initDB.sh ${packageDir}

echo "ENV_TYPE value is : " "${ENV_TYPE}"

docker build --file=${packageDir}/Dockerfile --build-arg BASE=${base_image} --build-arg PLAT_FORM=${ENV_TYPE} -t postgres:15.2-${VERSION} ${packageDir}
