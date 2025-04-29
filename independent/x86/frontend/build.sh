#！/bin/bash
set -ex
node -v
npm -v

elsa_core_dir=${WORKSPACE}/fit-framework/framework/elsa/fit-elsa
elsa_react_dir=${WORKSPACE}/fit-framework/framework/elsa/fit-elsa-react
appdir=${WORKSPACE}/app-platform/app-engine
workdir=${WORKSPACE}/frontend
CURRENT_BUILD_DIR=${workdir}/build
mkdir -p ${CURRENT_BUILD_DIR}
tag=prod
ssoApi=/jober/v1/user/sso_login_info
base_image="quay.io/openeuler/openeuler:latest"
echo "workspace: " "${WORKSPACE}"

arch_type=x86_64
ENV_TYPE=x86_64
PLATFORM=x86_64
VERSION=opensource-1.0.0
rm -rf $appdir/frontend/build
rm -rf $appdir/frontend/node_modules
cd $workdir

echo "workdir: " "${workdir}"
cd $workdir

#npm install elsa-core
cd ${elsa_core_dir}
npm config set strict-ssl false
## 强制清除缓存
npm cache clean -f
npm install --legacy-peer-deps --registry=https://registry.npmmirror.com
npm run build
npm link

#npm install elsa-react
cd ${elsa_react_dir}
npm install --legacy-peer-deps  --registry=https://registry.npmmirror.com
npm run build

#npm install
cd ${appdir}/frontend
npm install --legacy-peer-deps --force --registry=https://registry.npmmirror.com

# 打包静态资源
npm run build:$tag

# 打包产物
ls -l

mkdir -p $workdir/output
rm -rf $workdir/output/*
cp -r build/* $workdir/output/

cd $workdir

docker build --build-arg BASE=${base_image} --build-arg PLAT_FORM=${ENV_TYPE} -t jade-web:${VERSION} .
docker save -o ${WORKSPACE}/output/jade-web-${VERSION}.tar jade-web:${VERSION}
