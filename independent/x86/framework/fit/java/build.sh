#！/bin/bash
set -exu
echo ${WORKSPACE}
SKIP_TESTS=true

# 流水线传入的参数
app=fit
image_name=app-builder
image_tag=3.5.0
VERSION=opensource-1.0.0
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

cd "${WORKSPACE}"
mkdir -p sql/schema
mkdir -p sql/data

# app plugin相关sql语句
app_plugin_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-builder/jane/plugins/aipp-plugin/src/main/resources/sql/schema -name "*.sql")
echo "${app_plugin_schema_sql_list}"
for i in ${app_plugin_schema_sql_list}
do
  cp "$i" sql/schema
done

app_plugin_data_sql_list=$(find "${WORKSPACE}"/app-platform/app-builder/jane/plugins/aipp-plugin/src/main/resources/sql/data -name "*.sql")
echo "${app_plugin_data_sql_list}"
for i in ${app_plugin_data_sql_list}
do
  cp "$i" sql/data
done

# store相关sql语句
store_schema_sql_list=$(find "${WORKSPACE}"/app-platform/carver/plugins/tool-repository-postgresql/src/main/resources/sql/schema -name "*.sql")
echo "${store_schema_sql_list}"
for i in ${store_schema_sql_list}
do
  cp "$i" sql/schema
done

store_schema_sql_list_task=$(find "${WORKSPACE}"/app-platform/store/plugins/store-repository-postgresql/src/main/resources/sql/schema -name "*.sql")
echo "${store_schema_sql_list_task}"
for i in ${store_schema_sql_list_task}
do
  cp "$i" sql/schema
done

store_data_sql_list_task=$(find "${WORKSPACE}"/app-platform/store/plugins/store-repository-postgresql/src/main/resources/sql/data -name "*.sql")
echo "${store_data_sql_list_task}"
for i in ${store_data_sql_list_task}
do
  cp "$i" sql/data
done

# app-engine-announcement 相关sql 脚本
app_announcement_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-engine/plugins/app-announcement/src/main/resources/sql/schema -name "*.sql")
echo "${app_announcement_schema_sql_list}"
for i in ${app_announcement_schema_sql_list}
do
  cp "$i" sql/schema
done

# app-engine-metrics 相关sql 脚本
app_metrics_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-engine/plugins/app-metrics/src/main/resources/sql/schema -name "*.sql")
echo "${app_metrics_schema_sql_list}"
for i in ${app_metrics_schema_sql_list}
do
  cp "$i" sql/schema
done

app_base_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-engine/plugins/app-base/src/main/resources/sql/schema -name "*.sql")
echo "${app_base_schema_sql_list}"
for i in ${app_base_schema_sql_list}
do
  cp "$i" sql/schema
done

# app-eval 相关 sql 脚本
eval_dataset_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-eval/plugins/eval-dataset/src/main/resources/sql/schema -name "*.sql")
echo "${eval_dataset_schema_sql_list}"
for i in ${eval_dataset_schema_sql_list}
do
  cp "$i" sql/schema
done

eval_task_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-eval/plugins/eval-task/src/main/resources/sql/schema -name "*.sql")
echo "${eval_task_schema_sql_list}"
for i in ${eval_task_schema_sql_list}
do
  cp "$i" sql/schema
done

app_worker_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-eval/plugins/simple-uid-generator/src/main/resources/sql/schema -name "*.sql")
echo "${app_worker_schema_sql_list}"
for i in ${app_worker_schema_sql_list}
do
  cp "$i" sql/schema
done

# 自定义模型相关 sql 脚本
app_model_center_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-builder/plugins/aipp-custom-model-center/src/main/resources/sql/schema -name "*.sql")
echo "${app_model_center_schema_sql_list}"
for i in ${app_model_center_schema_sql_list}
do
  cp "$i" sql/schema
done

app_model_center_data_sql_list=$(find "${WORKSPACE}"/app-platform/app-builder/plugins/aipp-custom-model-center/src/main/resources/sql/data -name "*.sql")
echo "${app_model_center_data_sql_list}"
for i in ${app_model_center_data_sql_list}
do
  cp "$i" sql/data
done

# 自定义知识库相关 sql 脚本
app_knowledge_schema_sql_list=$(find "${WORKSPACE}"/app-platform/app-knowledge/plugins/knowledge-manager/src/main/resources/sql/schema -name "*.sql")
echo "${app_knowledge_schema_sql_list}"
for i in ${app_knowledge_schema_sql_list}
do
  cp "$i" sql/schema
done

app_knowledge_data_sql_list=$(find "${WORKSPACE}"/app-platform/app-knowledge/plugins/knowledge-manager/src/main/resources/sql/data -name "*.sql")
echo "${app_knowledge_data_sql_list}"
for i in ${app_knowledge_data_sql_list}
do
  cp "$i" sql/data
done

# wenjie 相关 sql 脚本
app_wenjie_data_sql_list=$(find "${WORKSPACE}"/app-platform/app-builder/plugins/plugins-show-case-parent/aito-data/src/main/resources/sql/data -name "*.sql")
echo "${app_wenjie_data_sql_list}"
for i in ${app_wenjie_data_sql_list}
do
  cp "$i" sql/data
done

cd "${CURRENT_BUILD_DIR}"
mkdir -p icon
rm -rf icon/*
appbuilder_icon_list=$(find "${CURRENT_WORKSPACE}/${PACKAGE_TYPE}"/icon -name "*.png")
echo "${appbuilder_icon_list}"
for i in ${appbuilder_icon_list}
do
  cp "$i" icon/
done

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
ls "${WORKSPACE}/fit-framework/build/plugins"
mkdir -p ${packageDir}/fit
cp -r "${WORKSPACE}/fit-framework/build"/* "${packageDir}/fit/"

# 替换 fitframework.yml 适配部署环境
cp "${CURRENT_WORKSPACE}/fitframework.yml" "${packageDir}/fit/conf"
cd "${packageDir}" || exit
cp "${CURRENT_WORKSPACE}"/Dockerfile "${packageDir}"
cp "${CURRENT_WORKSPACE}"/log_collect.sh "${packageDir}"

mkdir -p "${packageDir}/icon"
cp "${CURRENT_WORKSPACE}/internal/icon"/* "${packageDir}/icon"

mkdir -p ${packageDir}/smart-form
cp -r ${CURRENT_BUILD_DIR}/smart-form ${packageDir}
cp -r ${WORKSPACE}/app-platform/examples/app-demo/normal-form/* ${packageDir}/smart-form/

cp "${CURRENT_WORKSPACE}/start.sh" "${packageDir}/fit/bin/"
chmod 700 "${packageDir}"/fit/bin/*.sh

mkdir -p ${packageDir}/java
tar -zxvf ${PUBLIC_DIR}/openlogic*.tar.gz -C ${packageDir}/java --strip-components=1
echo "build the backend image by base image"

mkdir -p "${packageDir}/form"
cp ${CURRENT_WORKSPACE}/opensource/template.zip ${packageDir}/form/

dos2unix ${packageDir}/fit/bin/fit

# Step5 出镜像
docker build --build-arg PLAT_FORM=${ENV_TYPE} --build-arg BASE=${base_image} -t ${image_name}:${VERSION} --file=${packageDir}/Dockerfile ${packageDir}/
docker save -o "${WORKSPACE}/output/${image_name}-${VERSION}.tar" ${image_name}:${VERSION}
