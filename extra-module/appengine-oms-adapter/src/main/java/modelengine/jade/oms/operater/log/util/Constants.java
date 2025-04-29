/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.util;

import io.opentelemetry.api.common.AttributeKey;

/**
 * 表示插件常量定义。
 *
 * @author 易文渊
 * @since 2024-11-20
 */
public interface Constants {
    /**
     * 模块名。
     */
    String MY_SOURCE_NAME = "appEngine";

    /**
     * 表面时操作日志。
     */
    String OPERATION = "operation";

    /**
     * 操作成功 detail 后缀。
     */
    String SUCCEED_SUFFIX = ".succeed.detail";

    /**
     * 操作失败 detail 后缀。
     */
    String FAILED_SUFFIX = ".failed.detail";

    /**
     * 操作成功。
     */
    String SUCCEED_RESULT = "success";

    /**
     * 操作失败。
     */
    String FAILED_RESULT = "failed";

    /**
     * 用户名。
     */
    AttributeKey<String> USER_NAME = AttributeKey.stringKey("oms.oplog.username");

    /**
     * 主机。
     */
    AttributeKey<String> LOG_TERMINAL = AttributeKey.stringKey("oms.oplog.terminal");

    /**
     * 默认错误信息。
     */
    String DEFAULT_ERROR_MSG = "Appengine Internal error.";

    /**
     * 注册日志 uri。
     */
    String REGISTER_LOGS_URI = "/framework/v1/log/operateLogs/actions/register/internal";

    /**
     * 注册国际化信息 uri。
     */
    String REGISTER_INTERNATION_URI = "/framework/v1/log/operateLogs/actions/register/internation/internal";

    /**
     * 表示 OMS 调用成功的 code。
     */
    String OK = "0";
}