#！/bin/bash
set -exu

# 获取服务路径
echo $(pwd)
echo "workspace: " "${WORKSPACE}"

# 获取服务参数
image_name="fit-runtime-python"
mkdir -p ${WORKSPACE}/framework/fit/fit-python/build
CURRENT_WORKSPACE=${WORKSPACE}/framework/fit/fit-python
CURRENT_BUILD_DIR=${CURRENT_WORKSPACE}/build
PUBLIC_DIR=${WORKSPACE}/public
cd ${CURRENT_WORKSPACE}
PLATFORM=x86_64
ENV_TYPE=x86_64
VERSION=opensource-1.0.0
base_image="quay.io/openeuler/openeuler:latest"
packageDir="${CURRENT_WORKSPACE}/package"
mkdir -p ${packageDir}
rm -rf ${packageDir}/*

cd ${packageDir}

mkdir python
chmod +x python
cp -r ${WORKSPACE}/fit-framework/framework/fit/python/* python/

cp -r ${WORKSPACE}/fit-framework/framework/fel/python/plugins/builtins/* python/plugin/
cp ${WORKSPACE}/fit-framework/framework/fel/python/requirements.txt python/fel-requirements.txt


# 添加动态加载插件目录
cd python
mkdir custom_dynamic_plugins
cd ..

cp ${CURRENT_WORKSPACE}/root ${packageDir}
cp ${CURRENT_WORKSPACE}/Dockerfile_${ENV_TYPE} ${packageDir}/Dockerfile
cp ${CURRENT_WORKSPACE}/fit_start.sh ${packageDir}

# 打包镜像
docker build --file=${packageDir}/Dockerfile --build-arg BASE=${base_image} --build-arg PLAT_FORM=${ENV_TYPE} -t ${image_name}:${VERSION} ${packageDir}
docker save -o "${WORKSPACE}/output/${image_name}-${VERSION}.tar" ${image_name}:${VERSION}
