/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.service;

import modelengine.jade.oms.alarm.vo.EventInfo;
import modelengine.jade.oms.alarm.vo.RegisterEventDefinitionReq;

import java.util.List;

/**
 * 告警信息上报接口。
 *
 * @author 何嘉斌
 * @since 2024-12-05
 */
public interface AlarmClient {
    /**
     * 表示告警事件结构体注册。
     *
     * @param req 表示注册告警事件结构请求的 {@link RegisterEventDefinitionReq}。
     * @return 表示告警事件注册结果的 {@code boolean}。
     */
    boolean registerEventDefinition(RegisterEventDefinitionReq req);

    /**
     * 通过 rest 接口发送告警。
     *
     * @param eventInfos 表示告警信息。
     * @return 表示发送告警请求结果的 {@code boolean}。
     */
    boolean sendEvents(List<EventInfo> eventInfos);
}