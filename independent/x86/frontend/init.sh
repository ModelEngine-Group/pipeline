#!/bin/sh
set -e

WORK_DIR=$(pwd)

mkdir -p ${LOG_HOME}
chmod -R 750 ${LOG_HOME}

# 日志管理特性合入后统一整改
chmod -R 640 /var/log/*.log

sed -i "s/<HOSTNAME>/${HOSTNAME}/g" /etc/nginx/nginx.conf
sed -i "s/<POD_IP>/${POD_IP}/g" /etc/nginx/nginx.conf
sed -i "s/<HOST_IP>/${HOST_IP}/g" /etc/nginx/nginx.conf
sed -i "s/<LOG_HOME>/${LOG_HOME//\//\\/}/g" /etc/nginx/nginx.conf

cd ${LOG_HOME}
status_file="web.status"
while [ $(find . -type f -name "*.pid" | wc -l) -ge 2 ]; do
  if [ -e "${HOSTNAME}-nginx.pid" ]; then
    break
  fi
  echo "Wait pod terminating..."
  sleep 3
done
if [ ! -e ${status_file} ]; then
  touch "${status_file}"
  log_name=1
  echo "${HOSTNAME} 1" >> "${status_file}"
elif grep -q ${HOSTNAME} ${status_file}; then
  log_name=$(grep ${HOSTNAME} ${status_file} | awk '{print $2}')
elif [ $(cat ${status_file} | wc -l) -lt 2 ]; then
  log_name=2
  echo "${HOSTNAME} 2" >> "${status_file}"
else
  while IFS= read -r line; do
    pod_name=$(echo "$line" | awk '{print $1}')
    if [ ! -e "${pod_name}-nginx.pid" ]; then
      log_name=$(echo "$line" | awk '{print $2}')
      break
    fi
  done < "${status_file}"
  sed -i "s/${pod_name}/${HOSTNAME}/g" "${status_file}"
fi
sed -i "s/<LOG_NAME>/${log_name}/g" /etc/nginx/nginx.conf

cd /
# 创建logrotate配置文件
mkdir -p /opt/etc/logrotate/
nginx_logrotate_file="/opt/etc/logrotate/${HOSTNAME}-logrotate.conf"
cat > "$nginx_logrotate_file" << EOF
${LOG_HOME}/*${log_name}.log {
    hourly
    missingok
    dateext
    dateformat .%m%d-%H%s
    compress
    rotate 168
    maxsize 50M
    create 0640 nginx nginx
    sharedscripts
    postrotate
        kill -USR1 \`cat ${LOG_HOME}/${HOSTNAME}-nginx.pid\`
    endscript
}
EOF

# 启动定时任务
crond

# gosu切换为chroot
umask 0027
exec chroot / nginx -g 'daemon off;'
