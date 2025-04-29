#!/usr/bin/bash

# 从环境变量中读取fit_start_command的值
command_value="${fit_start_command}"
# 检查fit_start_command是否为空
if [ -z "$command_value" ]; then
    echo "fit_start_command为空"
else
    # 以空格为分隔符将指令分割成数组
    IFS=' ' read -r -a commands <<< "$command_value"
    # 遍历数组中的每个指令，检查格式
    for command in "${commands[@]}"
    do
    # 使用正则表达式检查指令格式，这里假设格式为 key=value
      if [[ ! "$command" =~ ^[^=]+=[^=]+$ ]]; then
        echo "参数格式错误: $command"
        exit 1
      fi
    done
fi

mkdir -p ${LOG_HOME}
chown -R runtime:runtime ${LOG_HOME}
chown -R runtime:runtime /tmp
chmod -R 640 /var/log/*.log

chmod 750 ${LOG_HOME}

# 创建logrotate配置文件
mkdir -p /opt/etc/logrotate/
runtime_python_logrotate_file="/opt/etc/logrotate/${HOSTNAME}-logrotate.conf"
cat > "$runtime_python_logrotate_file" << EOF
${LOG_HOME}/*.log {
    hourly
    missingok
    dateext
    dateformat .%m%d-%H%s
    compress
    copytruncate
    rotate 168
    maxsize 50M
    create 0640 runtime runtime
    sharedscripts
}
EOF

# 启动定时任务
crond

PLUGINS_RUNNING_PATH=/app/python/custom_dynamic_plugins/
chown 1100:2000 -R ${PLUGINS_RUNNING_PATH}

python3 -m fitframework \
  worker.id=$WORKER_ID \
  registry-center.server.addresses=$REGISTRY_HOST:$REGISTRY_PORT \
  local_ip=$LOCAL_IP \
  worker-environment.env=$WORK_ENV \
  user_plugins_path=$USER_PLUGINS_PATH \
  ${fit_start_command} \
  server-thread-count=32 \
  registry-center.server.protocol=2 \
  terminate-main.enabled=true
