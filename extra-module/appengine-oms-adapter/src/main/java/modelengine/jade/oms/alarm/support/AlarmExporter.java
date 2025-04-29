/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.support;

import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.annotation.Fit;
import modelengine.fitframework.annotation.Initialize;
import modelengine.fitframework.annotation.Value;
import modelengine.fitframework.exception.FitException;
import modelengine.fitframework.log.Logger;
import modelengine.fitframework.schedule.annotation.Scheduled;
import modelengine.fitframework.serialization.ObjectSerializer;
import modelengine.fitframework.util.IoUtils;
import modelengine.fitframework.util.MapBuilder;
import modelengine.fitframework.util.TypeUtils;
import modelengine.jade.oms.alarm.enums.PvcEnum;
import modelengine.jade.oms.alarm.service.AlarmClient;
import modelengine.jade.oms.alarm.vo.EventDefinition;
import modelengine.jade.oms.alarm.vo.EventInfo;
import modelengine.jade.oms.alarm.vo.RegisterEventDefinitionReq;
import modelengine.jade.oms.alarm.util.Constants;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 表示告警输出器。
 *
 * @author 何嘉斌
 * @since 2024-12-05
 */
@Component
public class AlarmExporter {
    private static final Logger log = Logger.get(AlarmExporter.class);
    private final AlarmClient client;
    private final MetricsCollector collector;
    private final ObjectSerializer serializer;

    @Value("${worker.host}")
    private String envIp;

    public AlarmExporter(AlarmClient client, MetricsCollector collector,
            @Fit(alias = "json") ObjectSerializer serializer) {
        this.client = client;
        this.collector = collector;
        this.serializer = serializer;
    }

    @Initialize
    void init() {
        List<EventDefinition> defineList = parseAlarmDefinition();
        RegisterEventDefinitionReq defineReq = new RegisterEventDefinitionReq();
        defineReq.setServiceName(Constants.SERVICE_NAME);
        defineReq.setServiceEn(Constants.SERVICE_NAME_EN);
        defineReq.setServiceZh(Constants.SERVICE_NAME_ZH);
        defineReq.setEventDefines(defineList);
        boolean result = this.client.registerEventDefinition(defineReq);
        if (!result) {
            log.error("Alarm definition registration failed.");
        }
    }

    private List<EventDefinition> parseAlarmDefinition() {
        try {
            String enContents = IoUtils.content(EventDefinition.class, "/alarm/alarm_definition_en-US.json");
            String zhContents = IoUtils.content(EventDefinition.class, "/alarm/alarm_definition_zh-CN.json");
            Map<String, String> resourceMapping =
                    MapBuilder.<String, String>get().put("en", enContents).put("zh", zhContents).build();
            return resourceMapping.entrySet().stream().flatMap(entry -> {
                List<EventDefinition> eventDefines = this.serializer.deserialize(entry.getValue(),
                        TypeUtils.parameterized(List.class, new Type[] {EventDefinition.class}));
                eventDefines.forEach(define -> {
                    define.setLanguage(entry.getKey());
                    define.setParts(Constants.ALARM_CATEGORY);
                    define.setDefineMatchKey(Constants.SERVICE_NAME + "_" + define.getEventId());
                });
                return eventDefines.stream();
            }).collect(Collectors.toList());
        } catch (IOException ex) {
            throw new FitException("Failed to load alarm definitions.", ex);
        }
    }

    @Scheduled(strategy = Scheduled.Strategy.FIXED_RATE, initialDelay = 10000L, value = "3600000")
    void checkStorageUsage() {
        Map<String, Integer> usages = this.collector.getStorageUsage();
        List<EventInfo> eventInfos = usages.entrySet()
                .stream()
                .map(entry -> validateUsage(entry.getKey(), entry.getValue()))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
        boolean result = this.client.sendEvents(eventInfos);
        if (!result) {
            log.error("Send alarm failed.");
        }
    }

    private EventInfo validateUsage(String name, Integer usage) {
        PvcEnum pvc = PvcEnum.getByPath(name);
        Integer threshold = pvc.getThreshold();
        if (threshold == null) {
            return null;
        }
        if (usage >= threshold) {
            log.warn("The filesystem {} usage exceeds threshold, current usage: {}%.", pvc, usage);
        }
        String status = usage >= threshold ? Constants.UNCLEARED : Constants.CLEARED;
        EventInfo info = new EventInfo();
        info.setEventId(pvc.getId());
        info.setEventCategory(Constants.SERVICE_NAME);
        info.setParts(Constants.ALARM_CATEGORY);
        info.setDeviceType(Constants.EVENT_SUBJECT_TYPE);
        info.setDeviceId(Constants.ALARM_DEVICE_ID);
        info.setEventSubject(pvc.getName());
        info.setEventSubjectType(Constants.EVENT_SUBJECT_TYPE);
        info.setStatus(status);
        info.setSeverity(Constants.WARNING);
        info.setEventType(Constants.ALARM_EVENT_TYPE);
        info.setEventSource(this.envIp);
        info.setShouldSaveDefine(false);
        info.setDefineMatchKey(Constants.SERVICE_NAME + "_" + info.getEventId());
        info.setClearType(Constants.AUTO_CLEAR);
        String currentTime = String.valueOf(System.currentTimeMillis());
        if (status.equals(Constants.CLEARED)) {
            info.setClearTime(currentTime);
        }
        info.setEventTimestamp(currentTime);
        return info;
    }
}