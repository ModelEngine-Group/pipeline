# 独立部署
独立部署只包含应用使能，调用外部模型和向量知识库，实现应用编排的方式。
## X86 架构
### 硬件要求
| 名称   | 规格    |
|------|-------|
| 内存   | 2GB+  |
| 磁盘空间 | 20GB+ |
### 软件要求
| 软件名     | 版本        |
|---------|-----------|
| Docker  | 28.0.1    |
| Maven   | 3.8.8+    |
| Java    | 17        |
| Node    | v20.12.1  |
| Npm     | 10.5.0     |
### 编译
1. 打开 Ubuntu (安装wsl默认已安装Ubuntu)

2. 执行以下命令
```shell
cd /home
git clone https://gitcode.com/ModelEngine/pipeline.git
bash independent/x86/build.sh <fit-framework-java-tag> <app-platform-tag> <fit-framework-elsa-tag> <image-version>
```
## Arm 架构
TODO

## 版本分支对应关系
| 版本     | pipeline | app-platform-tag | fit-framework-java-tag     | fit-framework-elsa-tag | image-version    |
|--------|----------|---------------|-------------------------------|---------------------------|------------------|
| v1.0.0 | v1.0.0   | v1.0.0        | v3.5.0-M2.1                   | elsa-v0.1.0               | opensource-1.0.0 |
| v1.0.1 | v1.0.1   | v1.0.1        | v3.5.0-M2.1                   | elsa-v0.1.1               | opensource-1.0.1 |
| v1.1.0 | v1.1.0   | v1.1.0        | v3.5.0-M2.1                   | elsa-v0.2.0               | opensource-1.1.0 |
| v1.1.1 | v1.1.1 | v1.1.1        | v3.5.0-M2.1 |       elsa-v0.2.0         | opensource-1.1.1 |

## FAQ
1. 前端编译不支持 Node v24.1.0 版本。


