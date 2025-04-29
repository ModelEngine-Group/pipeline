ARG BASE
FROM ${BASE}

# 使用 ARG 定义构建参数
ARG PLAT_FORM

# 使用 ENV 设置环境变量
ENV PLATFORM=$PLAT_FORM

COPY root /var/spool/cron

RUN yum makecache && \
    yum install -y nginx

RUN mkdir -p /appengine
COPY output /appengine
COPY output /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY init.sh /
RUN chmod +x /init.sh

RUN yum install -y shadow-utils logrotate cronie

EXPOSE 8001
RUN chown -R root:root /usr/share/nginx/html

ENTRYPOINT ["/init.sh"]
