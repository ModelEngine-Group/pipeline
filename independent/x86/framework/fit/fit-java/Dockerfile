ARG BASE
FROM ${BASE}
# 使用 ARG 定义构建参数
ARG PLAT_FORM

# 使用 ENV 设置环境变量
ENV PLATFORM=$PLAT_FORM

RUN yum makecache && \
    yum install -y java-17-openjdk util-linux nfs-utils sudo && \
    groupadd -g 2000 -r appengine && \
    useradd -r -g appengine -G 2000 -M -u 201 modelenginepublic && \
    useradd -u 1300 -r -g 2000 -M runtime && \
    useradd -u 200 -r -g 2000 -M fit

COPY --chown=1300:2000 ./fit-fitframework/. fitframework/
RUN chown 1300:2000 /usr/bin/java
COPY secure_start.sh /

RUN chmod 700 /fitframework/bin/fit && \
    chmod 700 /secure_start.sh

WORKDIR entry
ENTRYPOINT ["/secure_start.sh"]
