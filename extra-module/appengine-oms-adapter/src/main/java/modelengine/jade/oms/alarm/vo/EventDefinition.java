/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 告警结构定义。
 *
 * @author 何嘉斌
 * @since 2024-12-04
 */
@Setter
@Getter
@NoArgsConstructor
public class EventDefinition {
    /**
     * 事件Id。
     */
    private String eventId;

    /**
     * 事件的名字。
     */
    private String name;

    /**
     * 事件影响。
     */
    private String effect;

    /**
     * 告警所属设备类型，此属性必须，且需要跟其它接口用到的设备Category相匹配。
     */
    private String category;

    /**
     * 告警事件描述。
     */
    private String description;

    /**
     * 设备类型。
     */
    private String subjectType;

    /**
     * 事件类型，分为"alert"(告警)和"event"(事件)。
     */
    private String type;

    /**
     * 部件类型，用于描述部件之间的父子关系。
     */
    private String parts;

    /**
     * 造成告警事件可能的原因。
     */
    private String cause;

    /**
     * 告警事件的严重程度。
     */
    private String severity;

    /**
     * 针对此事件，建议采取的操作步骤。
     */
    private String suggestion;

    /**
     * 版本，预留。
     */
    private String version;

    /**
     * 语言。
     */
    private String language;

    /**
     * 告警定义匹配字段，用于告警基本信息与国际化定义信息的匹配。
     */
    private String defineMatchKey;
}