# 独立部署

独立部署只包含应用使能，调用外部模型和向量知识库，实现应用编排的方式。

## X86 架构

### 硬件要求

| 名称   | 规格    |
|------|-------|
| 内存   | 2GB+  |
| 磁盘空间 | 20GB+ |

### 软件要求

| 软件名    | 版本       |
|--------|----------|
| Docker | 28.0.1   |
| Maven  | 3.8.8+   |
| Java   | 17       |
| Node   | v20.12.1 |
| Npm    | 10.5.0   |

### 编译

1. 打开 Ubuntu (安装wsl默认已安装Ubuntu)
2. 执行以下命令

```shell
cd /home
git clone https://gitcode.com/ModelEngine/pipeline.git
cd pipeline/independent/x86
bash build.sh <fit-framework-java-tag> <app-platform-tag> <fit-framework-elsa-tag> <image-version>
```
> 参数说明：
> 
> fit-framework-java-tag: FIT 框架分支或 Tag
> 
> app-platform-tag: App-Platform 分支或 Tag
> 
> fit-framework-elsa-tag: Elsa 框架分支或 Tag
> 
> image-version: 自定义镜像版本号

## Arm 架构

TODO

## 版本分支对应关系

| 版本     | pipeline | app-platform-tag | fit-framework-java-tag | fit-framework-elsa-tag | image-version    |
|--------|----------|------------------|------------------------|------------------------|------------------|
| v1.0.0 | v1.0.0   | v1.0.0           | v3.5.0-M2.1            | elsa-v0.1.0            | opensource-1.0.0 |
| v1.0.1 | v1.0.1   | v1.0.1           | v3.5.0-M2.1            | elsa-v0.1.1            | opensource-1.0.1 |
| v1.1.0 | v1.1.0   | v1.1.0           | v3.5.0-M2.1            | elsa-v0.2.0            | opensource-1.1.0 |
| v1.1.1 | v1.1.1   | v1.1.1           | v3.5.0-M2.1            | elsa-v0.2.0            | opensource-1.1.1 |
| v1.1.2 | v1.1.2   | v1.1.2           | v3.5.0-M2.1            | elsa-v0.2.0            | opensource-1.1.2 |
| v1.2.0 | v1.2.0   | v1.2.0           | v3.5.0-M4              | elsa-v0.3.0            | opensource-1.2.0 |

## FAQ

1. 前端编译不支持 Node v24.1.0 版本。
2. MacOS 编译问题：
   - **Q:** docker pull quay.io/openeuler/openeuler:latest 下载速度太慢
   - **A:** 从[官网下载基础镜像](https://dl-cdn.openeuler.openatom.cn/openEuler-24.03-LTS-SP1/docker_img/x86_64/openEuler-docker.x86_64.tar.xz)
     - docker load -i openEuler-docker.x86_64.tar.xz
     - docker tag openeuler-24.03-lts-sp1:latest quay.io/openeuler/openeuler:latest
   - **Q:** RUN yum makecache 报错 timeout
   - **A:** DNS 解析地址添加 nameserver 8.8.8.8 
     - vim /etc/resolv.conf
     - 最后一行添加nameserver 8.8.8.8
3. WSL 编译问题：
   - **Q:** 编译前端报错找不到 i18n 目录
   - **A:** npm 9.x.x 版本 npm link 命令未生效。修改 independent/x86/frontend/build.sh 第 46 行新增以下命令，同时删除第 41 行 npm link。
    ```shell
    cp -r ${elsa_core_dir}/i18n ${WORKSPACE}/app-platform/app-engine/frontend/node_modules/\@fit-elsa/elsa-core/
    cp -r ${elsa_react_dir}/src ${WORKSPACE}/app-platform/app-engine/frontend/node_modules/\@fit-elsa/elsa-react/
    ```
    或者升级 npm 版本到 10.x.x。