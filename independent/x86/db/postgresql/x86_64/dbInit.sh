#!/bin/bash
set -e

chown -R postgres:postgres "$PGDATA"

mkdir -p ${LOG_HOME}
chown -R postgres:postgres "$LOG_HOME"
chmod -R 750 ${LOG_HOME}
chown -R postgres:postgres /log
chmod 750 /log
chmod 700 "${PGDATA}"

# 创建logrotate配置文件
mkdir -p /opt/etc/logrotate/
logrotate_file="/opt/etc/logrotate/${HOSTNAME}-logrotate.conf"
cat >"$logrotate_file" <<EOF
${LOG_HOME}/postgresql.log {
    hourly
    su postgres postgres
    missingok
    dateext
    dateformat .%m%d-%H%s
    compress
    copytruncate
    rotate 168
    maxsize 50M
    create 0640 postgres postgres
}
EOF

# 启动定时任务

crond

set +e
chroot --userspec=postgres:postgres / bash -c "/usr/local/pgsql/bin/initdb -D ${PGDATA} --pwfile=<(printf \"%s\n\" '${POSTGRES_PASSWORD}')"
unset pwd
chroot --userspec=postgres:postgres / bash -c "cd ${PGDATA} && \
    sed -i 's/#listen_/listen_/' postgresql.conf && \
    sed -i 's/localhost/*/' postgresql.conf && \
    sed -i 's/#logging_collector = off/logging_collector = on/' postgresql.conf && \
    sed -i 's/#log_connections = off/log_connections = on/' postgresql.conf && \
    sed -i 's/#log_disconnections = off/log_disconnections = on/' postgresql.conf && \
    sed -i 's/#log_duration = off/log_duration = on/' postgresql.conf && \
    sed -i \"s/#log_statement = 'none'/log_statement = 'ddl'/\" postgresql.conf && \
    sed -i \"s/#log_directory = 'log'/log_directory = '${LOG_HOME//\//\\/}'/\" postgresql.conf && \
    sed -i \"s/#log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'/log_filename = 'postgresql.log'/\" postgresql.conf && \
    sed -i \"s/#log_rotation_age = 1d/log_rotation_age = 0/\" postgresql.conf && \
    sed -i \"s/#log_rotation_size = 10MB/log_rotation_size = 0/\" postgresql.conf && \
    sed -i '/all\s\+all/d' pg_hba.conf && \
    echo 'host all all all scram-sha-256' >> pg_hba.conf"

set -e
# 启动数据库
exec chroot --userspec=postgres:postgres / postgres -D ${PGDATA}
echo "exit"
