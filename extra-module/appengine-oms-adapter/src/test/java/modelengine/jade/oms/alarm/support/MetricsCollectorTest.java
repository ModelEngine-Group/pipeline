/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.support;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

import modelengine.jade.oms.alarm.enums.PvcEnum;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

/**
 * 表示 {@link MetricsCollector} 的测试集。
 *
 * @author 何嘉斌
 * @since 2024-12-06
 */
public class MetricsCollectorTest {
    private static MetricsCollector collector;

    @Test
    @DisplayName("获取 PVC 使用率成功")
    public void shouldOkWhenGetStorageUsage() throws IOException {
        try (MockedStatic mocked = mockStatic(Runtime.class)) {
            Runtime runtime = mock(Runtime.class);
            mocked.when(Runtime::getRuntime).thenReturn(runtime);
            collector = new MetricsCollector();
            File file = new File("src/test/resources/alarm/StorageUsageOutput.txt");
            try (InputStream inputStream = new FileInputStream(file)) {
                Process process = mock(Process.class);
                when(process.getInputStream()).thenReturn(inputStream);
                when(runtime.exec(anyString())).thenReturn(process);
                Map<String, Integer> output = collector.getStorageUsage();
                assertThat(output.get(PvcEnum.RUNTIME_PVC.getPath())).isEqualTo(15);
            }
        }
    }
}