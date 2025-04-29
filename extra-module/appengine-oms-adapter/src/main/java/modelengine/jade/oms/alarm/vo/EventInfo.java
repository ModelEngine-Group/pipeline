/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

/**
 * 告警结构体。
 *
 * @author 何嘉斌
 * @since 2024-12-04
 */
@Setter
@Getter
@NoArgsConstructor
public class EventInfo {
    /**
     * 事件id号，对应event_list表中的id字段，查询的时候返回，上报不填。
     */
    private String id;

    /**
     * 事件序列号，存储中的sequence，虚拟化中的sn，可选。
     */
    private String serialNumber;

    /**
     * 事件同步号，存储中的sync_no，虚拟化中的 sync no，可选。
     */
    private Integer syncNo;

    /**
     * 事件ID eventId。
     */
    private String eventId;

    /**
     * 事件名称 name。
     */
    private String eventName;

    /**
     * alert-告警，event-事件。
     */
    private String eventType;

    /**
     * 告警对象。
     */
    private String eventSubject;

    /**
     * 告警对象类型。
     */
    private String eventSubjectType;

    /**
     * 事件描述 description。
     */
    private String eventDescription;

    /**
     * 事件描述参数。
     */
    private List<String> eventDescriptionArgs;

    /**
     * 事件级别（warning, minor, major, severity)。
     */
    private String severity;

    /**
     * 事件影响。
     */
    private String effect;

    /**
     * 告警分类。
     */
    private String eventCategory;

    /**
     * 事件的可能原因。
     */
    private String possibleCause;

    /**
     * 事件修复建议 suggestion。
     */
    private String suggestion;

    /**
     * 事件状态（已确认，已恢复，未确认，未恢复）。
     */
    private String status;

    /**
     * 事件发生的时间戳。
     */
    private String eventTimestamp;

    /**
     * 事件首次发生时间。
     */
    private String firstOccurTime;

    /**
     * 事件清除时间。
     */
    private String clearTime;

    /**
     * 事件来源（设备或者组件的IP）。
     */
    private String eventSource;

    /**
     * 事件来源的设备序列号，可选。
     */
    private String deviceSn;

    /**
     * 事件来源的设备类型，可选，例如服务器-server。
     */
    private String deviceType;

    /**
     * 设备URL，预留。
     */
    private String devURL;

    /**
     * 所属部件类型。
     */
    private String parts;

    /**
     * 告警语言。
     */
    private String language;

    /**
     * 虚拟化告警刷新标识。
     */
    private int computerCategory;

    /**
     * 该条告警在对应的设备是否已经删除。
     */
    private boolean shouldDeleted;

    /**
     * 清除类型，ManualClear、AutoClear。
     */
    private String clearType;

    /**
     * 告警定义匹配值。
     */
    private String defineMatchKey;

    /**
     * 上条告警匹配值。
     */
    private String lastEventMatchKey;

    /**
     * 该条告警是否需要抽取定义进行保存，默认true。
     */
    private Boolean shouldSaveDefine = true;

    /**
     * 设备唯一标识，自动填充。
     */
    private String deviceId;
}