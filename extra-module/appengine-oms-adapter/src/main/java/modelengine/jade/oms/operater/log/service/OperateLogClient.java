/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.service;

import modelengine.jade.oms.operater.log.vo.LogI18N;
import modelengine.jade.oms.operater.log.vo.OperateLog;
import modelengine.jade.oms.response.ResultVo;

import java.util.List;

/**
 * OM 操作日志上报接口。
 *
 * @author 何嘉斌
 * @since 2024-11-26
 */
public interface OperateLogClient {
    /**
     * 上报审计日志接口。
     *
     * @param logs 表示log对象列表的 {@link List}{@code <}{@link OperateLog}{@code >}。
     * @return 表示日志上报成功数量的 {@link ResultVo}{@code <}{@link Integer}{@code >}。
     */
    ResultVo<Integer> registerLogs(List<OperateLog> logs);

    /**
     * 注册审计日志国际化。
     *
     * @param logI18ns 表示国际化对象的 {@link List}{@code <}{@link LogI18N}{@code >}。
     * @return 表示日志国家化信息注册结果的 {@link ResultVo}{@code <}{@link Boolean}{@code >}。
     */
    ResultVo<Boolean> registryInternational(List<LogI18N> logI18ns);
}