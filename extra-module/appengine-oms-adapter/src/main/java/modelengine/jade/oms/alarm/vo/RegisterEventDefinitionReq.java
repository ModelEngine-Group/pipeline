/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * 注册告警事件结构请求。
 *
 * @author 何嘉斌
 * @since 2024-12-04
 */
@Setter
@Getter
public class RegisterEventDefinitionReq {
    /**
     * 服务名。
     */
    private String serviceName;

    /**
     * 服务英文名。
     */
    private String serviceEn;

    /**
     * 服务中文名。
     */
    private String serviceZh;

    /**
     * 告警事件结构体列表。
     */
    private List<EventDefinition> eventDefines;
}