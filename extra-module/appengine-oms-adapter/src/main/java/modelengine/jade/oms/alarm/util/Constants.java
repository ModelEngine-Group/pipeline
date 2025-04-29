/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.util;

/**
 * 表示插件常量定义。
 *
 * @author 何嘉斌
 * @since 2024-12-05
 */
public interface Constants {
    /**
     * 收集 PVC 对应挂载路径使用率的质指令。
     */
    String LIST_USAGE_COMMAND = "df";

    /**
     * 收集 PVC 对应挂载路径使用率的质指令输出列数。
     */
    int USAGE_COMMAND_OUTPUT_LENGTH = 6;

    /**
     * 表示空字符串。
     */
    String SPACE_REGEX = "\\s+";

    /**
     * 注册告警信息 URI。
     */
    String REGISTER_EVENT_DEFINE_URI = "/monitor/v1/events/defines";

    /**
     * 上报告警信息 URI。
     */
    String ADD_EVENT_URI = "/monitor/v1/events/service/send-alarm/internal";

    /**
     * 类型，alert-告警，event-事件，目前容器侧只有告警没有事件。
     */
    String ALARM_EVENT_TYPE = "alert";

    /**
     * 应用类型。
     */
    String ALARM_CATEGORY = "application";

    /**
     * 设备类型。
     */
    String ALARM_DEVICE_ID = "AppEngine";

    /**
     * 服务名称。
     */
    String SERVICE_NAME = "AppEngine";

    /**
     * 服务英文名称。
     */
    String SERVICE_NAME_EN = "AppEngine";

    /**
     * 服务中文名称。
     */
    String SERVICE_NAME_ZH = "应用使能";

    /**
     * 告警事务类型。
     */
    String EVENT_SUBJECT_TYPE = "PVC";

    /**
     * 告警等级。
     */
    String WARNING = "warning";

    /**
     * 清除告警（历史告警）。
     */
    String CLEARED = "Cleared";

    /**
     * 上报告警（活跃告警）。
     */
    String UNCLEARED = "Uncleared";

    /**
     * 自动清除。
     */
    String AUTO_CLEAR = "AutoClear";

    /**
     * 表示 OMS 调用成功的 code。
     */
    String OK = "0";
}