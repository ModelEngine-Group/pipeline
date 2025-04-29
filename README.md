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
| Node    | v12.22.9  |
| Npm     | 8.5.1     |
### 编译
1. 打开 Ubuntu (安装wsl默认已安装Ubuntu)

2. 执行以下命令
```shell
cd /home
git clone https://gitcode.com/ModelEngine/pipeline.git
bash independent/x86/build.sh
```
## Arm 架构



