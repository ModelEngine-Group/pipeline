/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.support;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import modelengine.jade.oms.operater.log.service.OperateLogClient;
import modelengine.jade.oms.operater.log.stub.SpanStub;
import modelengine.jade.oms.operater.log.vo.OperateLog;
import modelengine.jade.oms.response.ResultVo;

import io.opentelemetry.api.trace.StatusCode;
import io.opentelemetry.sdk.common.CompletableResultCode;

import modelengine.jade.oms.operater.log.util.Constants;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.util.Collections;
import java.util.List;

/**
 * 表示 {@link OmsOperationLogExporter} 的测试集。
 *
 * @author 何嘉斌
 * @since 2024-11-26
 */
public class OmsOperationLogExporterTest {
    private static OmsOperationLogExporter exporter;
    private static OmsOperationFlagResolver resolver;
    private static OperateLogClient client;

    @Test
    @DisplayName("输出 Operation logs 成功")
    void shouldOkWhenExport() {
        resolver = mock(OmsOperationFlagResolver.class);
        client = mock(OperateLogClient.class);
        ResultVo<Boolean> result = new ResultVo<>();
        result.setCode("success");
        result.setData(true);
        when(client.registryInternational(anyList())).thenReturn(result);
        ResultVo<Integer> logResult = new ResultVo<>();
        logResult.setCode("success");
        logResult.setData(1);
        when(client.registerLogs(anyList())).thenReturn(logResult);
        exporter = new OmsOperationLogExporter(resolver, client);
        exporter.init();

        ArgumentCaptor<List> logCaptor = ArgumentCaptor.forClass(List.class);
        SpanStub span = new SpanStub();
        span.updateName("testName");
        span.setAttribute(Constants.USER_NAME, "admin");
        span.setAttribute(Constants.LOG_TERMINAL, "terminal");
        span.setStatus(StatusCode.OK);
        CompletableResultCode code = exporter.export(Collections.singleton(span.toSpanData()));
        assertThat(code).isEqualTo(CompletableResultCode.ofSuccess());
        verify(client).registerLogs(logCaptor.capture());
        List<OperateLog> logs = logCaptor.getValue();
        OperateLog log = logs.get(0);
        assertThat(log).extracting("operation",
                        "logType",
                        "username",
                        "source",
                        "datetime",
                        "terminal",
                        "result",
                        "flag",
                        "detail")
                .containsExactly("testName",
                        "operation",
                        "admin",
                        "appEngine",
                        1L,
                        "terminal",
                        "success",
                        null,
                        "testName.succeed.detail");
    }

    @Test
    @DisplayName("达到最大重试次数时，OMS 日志不启动")
    void shouldFailWhenReachedMaxRetries() {
        resolver = mock(OmsOperationFlagResolver.class);
        client = mock(OperateLogClient.class);
        ResultVo<Boolean> result = new ResultVo<>();
        result.setCode("failed");
        result.setData(false);
        when(client.registryInternational(anyList())).thenReturn(result).thenReturn(result).thenReturn(result);
        exporter = new OmsOperationLogExporter(resolver, client);
        exporter.init();
        assertThat(exporter.isEnable()).isFalse();
    }
}