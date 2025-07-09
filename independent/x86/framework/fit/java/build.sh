#！/bin/bash
set -exu
echo ${WORKSPACE}
SKIP_TESTS=true

# 流水线传入的参数
app=fit
image_name=app-builder
image_tag=3.5.0
VERSION=${1:-"opensource-1.0.0"}
PACKAGE_TYPE=internal
PLATFORM=x86_64
ENV_TYPE=x86_64
currentdir=$(cd $(dirname $0); pwd)
base_image="quay.io/openeuler/openeuler:latest"

# 获取服务路径
echo $(pwd)
echo "workspace: " "${WORKSPACE}"
mkdir -p ${WORKSPACE}/framework/fit/java/build
CURRENT_WORKSPACE=${WORKSPACE}/framework/fit/java
CURRENT_BUILD_DIR=${CURRENT_WORKSPACE}/build
PUBLIC_DIR=${WORKSPACE}/public

mkdir -p ${CURRENT_BUILD_DIR}

# 拷贝智能表单
cp -r ${WORKSPACE}/app-platform/examples/smart-form ${CURRENT_BUILD_DIR}/

cd "${WORKSPACE}/app-platform/shell"
chmod -R 755 ./
./sql_build.sh
cd "${WORKSPACE}"
mkdir -p "${WORKSPACE}"/package/sql/init
mkdir -p "${WORKSPACE}"/package/sql/upgrade
mv -f ${WORKSPACE}/app-platform/sql/* "${WORKSPACE}"/package/sql/init/
mv -f ${CURRENT_WORKSPACE}/upgrade.sql "${WORKSPACE}"/package/sql/upgrade/

cd "${CURRENT_BUILD_DIR}"
mkdir -p icon
rm -rf icon/*

# 拷贝应用头像
cd "${WORKSPACE}/app-platform/shell"
./icon_build.sh
mv -f ${WORKSPACE}/app-platform/icon/* ${CURRENT_BUILD_DIR}/icon/

MVN_CMD="mvn clean install -U"
# 定义条件命令
SKIP_TESTS_CMD=""
if [ "$SKIP_TESTS" = "true" ]; then
    SKIP_TESTS_CMD="-DskipTests"
fi

# Print the value of SKIP_TESTS_CMD
echo "SKIP_TESTS"
echo "SKIP_TESTS value: ${SKIP_TESTS}"
echo "SKIP_TESTS_CMD value: ${SKIP_TESTS_CMD}"

# 编译 FIT 框架
cd "${WORKSPACE}/fit-framework"
echo "start to execute maven"
mvn -version
$MVN_CMD $SKIP_TESTS_CMD

# 编译 app-platform
cd "${WORKSPACE}/app-platform"
echo "start to execute maven"
mvn -version
$MVN_CMD $SKIP_TESTS_CMD
mv -f ${WORKSPACE}/app-platform/build/plugins/* ${WORKSPACE}/fit-framework/build/plugins/
mv -f ${WORKSPACE}/app-platform/build/shared/* ${WORKSPACE}/fit-framework/build/shared/

packageDir="${CURRENT_BUILD_DIR}/package/"
mkdir -p ${packageDir}
rm -rf ${packageDir}/*
if [ -z "$(ls -A "${packageDir}")" ]; then
  rm -rf "${packageDir:?}"/*
fi

# 删除多余插件
rm -f ${WORKSPACE}/fit-framework/build/plugins/fel-tool-discoverer*
rm -f ${WORKSPACE}/fit-framework/build/plugins/fel-tool-executor*
rm -f ${WORKSPACE}/fit-framework/build/plugins/fel-tool-factory-repository*
rm -f ${WORKSPACE}/fit-framework/build/plugins/fel-tool-repository-simple*

ls "${WORKSPACE}/fit-framework/build/plugins"
mkdir -p ${packageDir}/fit
cp -r "${WORKSPACE}/fit-framework/build"/* "${packageDir}/fit/"

# 替换 fitframework.yml 适配部署环境
cp "${CURRENT_WORKSPACE}/fitframework.yml" "${packageDir}/fit/conf"
cd "${packageDir}" || exit
cp "${CURRENT_WORKSPACE}"/Dockerfile "${packageDir}"
cp "${CURRENT_WORKSPACE}"/log_collect.sh "${packageDir}"

mkdir -p "${packageDir}/icon"
mv "${CURRENT_BUILD_DIR}/icon"/* "${packageDir}/icon"

mkdir -p ${packageDir}/smart-form
cp -r ${CURRENT_BUILD_DIR}/smart-form ${packageDir}
cp -r ${WORKSPACE}/app-platform/examples/app-demo/normal-form/* ${packageDir}/smart-form/

cp "${CURRENT_WORKSPACE}/start.sh" "${packageDir}/fit/bin/"
chmod 700 "${packageDir}"/fit/bin/*.sh

mkdir -p ${packageDir}/java
tar -zxvf ${PUBLIC_DIR}/openlogic*.tar.gz -C ${packageDir}/java --strip-components=1
echo "build the backend image by base image"

mkdir -p "${packageDir}/form"
cp ${CURRENT_WORKSPACE}/template.zip ${packageDir}/form/

dos2unix ${packageDir}/fit/bin/fit

# Step5 出镜像
docker build --build-arg PLAT_FORM=${ENV_TYPE} --build-arg BASE=${base_image} -t ${image_name}:${VERSION} --file=${packageDir}/Dockerfile ${packageDir}/
docker save -o "${WORKSPACE}/output/${image_name}-${VERSION}.tar" ${image_name}:${VERSION}
