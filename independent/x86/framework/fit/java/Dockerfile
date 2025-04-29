ARG BASE
FROM ${BASE}

# 使用 ARG 定义构建参数
ARG PLAT_FORM

# 使用 ENV 设置环境变量
ENV PLATFORM=$PLAT_FORM
ENV PGPATH="/var/lib/postgresql"

ENV APP_PATH /opt/fit-framework

COPY log_collect.sh /log_collect.sh
RUN chmod 550 /log_collect.sh

RUN mkdir -p /usr/local/java
COPY java /usr/local/java
ENV JAVA_HOME=/usr/local/java
ENV PATH=/usr/local/java/bin:${PATH}
RUN chmod -R +x /usr/local/java/bin

#镜像仓里的
RUN mkdir -p /opt
RUN mkdir -p $APP_PATH
COPY fit $APP_PATH

RUN mkdir -p /opt/fit-framework/data/share
RUN mkdir -p /var/temporary/tools
RUN mkdir -p /opt/fit/tools
RUN mkdir -p /opt/fit/tools/java
RUN mkdir -p /opt/fit/tools/python
RUN mkdir -p /var/store/tools
RUN mkdir -p /var/store/tools/python
RUN mkdir -p /var/store/tools/java
COPY icon/ /opt/fit-framework/data/share

RUN mkdir $APP_PATH/dynamic-plugins
WORKDIR $APP_PATH/dynamic-plugins
RUN ls $APP_PATH
RUN chmod -R a+x $APP_PATH

RUN mkdir -p /opt/appbuilder/form
COPY form/template.zip /opt/appbuilder/form


RUN mkdir -p /opt/fit-framework/data/smart-form
COPY smart-form/ /opt/fit-framework/data/smart-form

ENTRYPOINT ["/opt/fit-framework/bin/start.sh"]
