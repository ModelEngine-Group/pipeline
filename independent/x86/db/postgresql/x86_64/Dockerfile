ARG BASE
FROM ${BASE}
ARG PLAT_FORM
ENV PATH="/usr/local/pgsql/bin:${PATH}"
ENV PGPATH="/var/lib/postgresql"
ENV PGDATA="${PGPATH}/data"
ENV PGLOG="${PGPATH}/log"
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pgsql/lib

RUN yum makecache && \
    yum install -y wget gcc readline readline-devel zlib zlib-devel && \
    wget https://mirrors.aliyun.com/postgresql/source/v15.3/postgresql-15.3.tar.gz && \
    tar -xzvf postgresql-15.3.tar.gz && \
    cd postgresql-15.3 && \
    ./configure --prefix=/usr/local/pgsql && \
    make && \
    make install

COPY root /var/spool/cron/

RUN yum install -y shadow-utils cronie logrotate

RUN groupadd -g 1000 -r postgres && \
	useradd -u 1000 -r -g postgres -M -d $PGPATH -s /bin/sh postgres && \
	mkdir -p "$PGPATH" && \
    chown -R postgres:postgres $PGPATH && \
    chown -R postgres:postgres /usr/local/pgsql && \
    mkdir -p "$PGDATA" && \
    mkdir -p "$PGLOG"

COPY dbInit.sh /
RUN chmod 700 /dbInit.sh
EXPOSE 5432
ENTRYPOINT ["sh", "dbInit.sh"]
