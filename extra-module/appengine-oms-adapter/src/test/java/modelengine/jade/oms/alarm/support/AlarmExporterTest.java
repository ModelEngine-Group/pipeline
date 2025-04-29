/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.support;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import modelengine.fit.serialization.json.jackson.JacksonObjectSerializer;
import modelengine.fitframework.serialization.ObjectSerializer;
import modelengine.fitframework.util.MapBuilder;
import modelengine.jade.oms.alarm.enums.PvcEnum;
import modelengine.jade.oms.alarm.service.AlarmClient;
import modelengine.jade.oms.alarm.vo.EventInfo;

import modelengine.jade.oms.alarm.util.Constants;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.util.List;
import java.util.Map;

/**
 * 表示 {@link AlarmExporter} 的测试集。
 *
 * @author 何嘉斌
 * @since 2024-12-06
 */
public class AlarmExporterTest {
    private static AlarmExporter exporter;
    private static AlarmClient client;
    private static MetricsCollector collector;
    private static ObjectSerializer serializer;

    @Test
    @DisplayName("检查 PVC 使用量成功")
    void shouldOkWhenCheckStorageUsage() {
        collector = mock(MetricsCollector.class);
        client = mock(AlarmClient.class);
        serializer = new JacksonObjectSerializer(null, null, null);
        when(client.sendEvents(anyList())).thenReturn(true);
        when(client.registerEventDefinition(any())).thenReturn(true);
        exporter = new AlarmExporter(client, collector, serializer);
        exporter.init();

        Map<String, Integer> output = MapBuilder.<String, Integer>get().put("/var/store/tools", 15).build();
        when(collector.getStorageUsage()).thenReturn(output);

        ArgumentCaptor<List> eventCaptor = ArgumentCaptor.forClass(List.class);
        exporter.checkStorageUsage();
        verify(client).sendEvents(eventCaptor.capture());
        List<EventInfo> events = eventCaptor.getValue();
        EventInfo event = events.get(0);
        assertThat(event).extracting("eventId",
                        "eventType",
                        "eventSubject",
                        "eventSubjectType",
                        "severity",
                        "eventCategory",
                        "status",
                        "deviceType",
                        "parts",
                        "clearType",
                        "defineMatchKey",
                        "deviceId",
                        "shouldSaveDefine")
                .containsExactly(PvcEnum.RUNTIME_PVC.getId(),
                        Constants.ALARM_EVENT_TYPE,
                        PvcEnum.RUNTIME_PVC.getName(),
                        Constants.EVENT_SUBJECT_TYPE,
                        Constants.WARNING,
                        Constants.SERVICE_NAME,
                        Constants.CLEARED,
                        Constants.EVENT_SUBJECT_TYPE,
                        Constants.ALARM_CATEGORY,
                        Constants.AUTO_CLEAR,
                        Constants.SERVICE_NAME + "_" + PvcEnum.RUNTIME_PVC.getId(),
                        Constants.ALARM_DEVICE_ID,
                        false);
    }
}