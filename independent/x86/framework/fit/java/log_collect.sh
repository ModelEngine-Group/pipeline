#!/bin/bash

TEMP_DIR="/tmp"
LOG_DIR="/log-app"

# 检查输入参数
if [ "$#" -ne 2 ]; then
    echo "Parameter error. Please check the input parameter."
    exit 1
fi

# 输入的开始和结束时间
start_time=$1
end_time=$2

now_time=$(date '+%Y%m%d%H%M%S')

# 将时间转换为时间戳
start_timestamp=$(date -d "$start_time" +%s)
end_timestamp=$(date -d "$end_time" +%s)

rm -rf $TEMP_DIR$LOG_DIR
mkdir -p $TEMP_DIR$LOG_DIR

# 查找文件并检查访问时间
find $LOG_DIR -type f -not -name "*.pid"  | while read -r file; do
    # 获取文件的创建时间
    access_time=$(stat -c %x "$file")
    access_timestamp=$(date -d "$access_time" +%s)

    # 获取文件的修改时间
    modify_time=$(stat -c %y "$file")
    modify_timestamp=$(date -d "$modify_time" +%s)
    modify_timestamp_minus_one_hour=$((modify_timestamp - 3600))

    # 检查访问时间是否在范围内
    if [[ $access_timestamp -ge $start_timestamp && $access_timestamp -le $end_timestamp ]] \
    || [[ $modify_timestamp -ge $start_timestamp && $modify_timestamp -le $end_timestamp ]] \
    || [[ $modify_timestamp_minus_one_hour -le $end_timestamp && modify_timestamp -ge $end_timestamp ]]; then
        mkdir -p "$TEMP_DIR$(dirname "$file")"
        cp "$file" "$TEMP_DIR$file"
    fi
done

cd $TEMP_DIR$LOG_DIR || exit 1
rm -rf ../logCollect*.zip
zip -r ../logCollect_"${now_time}".zip ./* -i "*"
rm -rf $TEMP_DIR$LOG_DIR