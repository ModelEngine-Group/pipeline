#！/bin/bash
set -exu

SKIP_TESTS=true

# 获取服务路径
echo $(pwd)
echo "workspace: " "${WORKSPACE}"
mkdir -p ${WORKSPACE}/framework/fit/fit-java/build
CURRENT_WORKSPACE=${WORKSPACE}/framework/fit/fit-java
CURRENT_BUILD_DIR=${CURRENT_WORKSPACE}/build
PUBLIC_DIR=${WORKSPACE}/public
VERSION=${1:-"opensource-1.0.0"}
PLATFORM=x86_64
ENV_TYPE=x86_64
java_engine_version=3.5.0-SNAPSHOT
# 获取服务参数
image_name="fit-runtime-java"

base_image="quay.io/openeuler/openeuler:latest"

packageDir="${CURRENT_BUILD_DIR}/package/"
if [ -z "$(ls -A "${packageDir}")" ]; then
  rm -rf "${packageDir:?}"/*
fi
rm -rf "${packageDir}"/*
mkdir -p "${packageDir}/framework-fit-java"

cd "${packageDir}" || exit
cp ${CURRENT_WORKSPACE}/Dockerfile "${packageDir}"
cp ${CURRENT_WORKSPACE}/secure_start.sh "${packageDir}"

mkdir -p ${packageDir}/java
tar -zxvf ${PUBLIC_DIR}/openlogic*.tar.gz -C ${packageDir}/java --strip-components=1

# 定义条件命令
SKIP_TESTS_CMD=""
if [ "$SKIP_TESTS" = "true" ]; then
    SKIP_TESTS_CMD="-DskipTests"
fi

# Print the value of SKIP_TESTS_CMD
echo "SKIP_TESTS"
echo "SKIP_TESTS value: ${SKIP_TESTS}"
echo "SKIP_TESTS_CMD value: ${SKIP_TESTS_CMD}"

# 基于源码编译代码
echo "get all code"
cd ${CURRENT_BUILD_DIR}
mkdir -p java-code
rm -rf java-code/*
rm -rf ${WORKSPACE}/fit-framework/build/*
cp -r ${WORKSPACE}/fit-framework/* ${CURRENT_BUILD_DIR}/java-code/
cd java-code
echo "start to execute maven"
mvn -version
mvn -f framework/fit/java clean install -U $SKIP_TESTS_CMD
cd ..

cd ${packageDir}
mkdir fit-fitframework
chmod +x fit-fitframework
cp -r ${CURRENT_BUILD_DIR}/java-code/build/* ./fit-fitframework/

rm -f ./fit-fitframework/plugins/fit-dynamic-plugin-mvn*
rm -f ./fit-fitframework/plugins/fit-http-openapi3*
rm -f ./fit-fitframework/plugins/fit-service-coordination-simple*

rm -f ./fit-fitframework/plugins/fel-langchain-runnable*
rm -f ./fit-fitframework/plugins/fel-model-openai-plugin*
rm -f ./fit-fitframework/plugins/fel-tokenizer-hanlp-plugin*
rm -f ./fit-fitframework/plugins/fel-tool-discoverer*
rm -f ./fit-fitframework/plugins/fel-tool-executor*
rm -f ./fit-fitframework/plugins/fel-tool-factory-repository*
rm -f ./fit-fitframework/plugins/fel-tool-repository-simple*

dos2unix ${packageDir}/fit-fitframework/bin/fit

# 打包镜像
docker build -f ${packageDir}/Dockerfile --build-arg BASE=${base_image} --build-arg PLAT_FORM=${ENV_TYPE} -t ${image_name}:${VERSION} .
docker save -o "${WORKSPACE}/output/${image_name}-${VERSION}.tar" ${image_name}:${VERSION}
