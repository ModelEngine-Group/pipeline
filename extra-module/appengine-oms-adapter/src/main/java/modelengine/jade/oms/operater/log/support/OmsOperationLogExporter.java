/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.support;

import static modelengine.fitframework.util.ObjectUtils.cast;

import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.annotation.Initialize;
import modelengine.fitframework.log.Logger;
import modelengine.fitframework.parameterization.StringFormatException;
import modelengine.fitframework.util.IoUtils;
import modelengine.fitframework.util.MapBuilder;
import modelengine.fitframework.util.StringUtils;
import modelengine.jade.oms.operater.log.service.OperateLogClient;
import modelengine.jade.oms.operater.log.vo.LogI18N;
import modelengine.jade.oms.operater.log.vo.OperateLog;
import modelengine.jade.oms.response.ResultVo;
import modelengine.jade.service.CarverSpanExporter;

import io.opentelemetry.api.common.Attributes;
import io.opentelemetry.api.trace.StatusCode;
import io.opentelemetry.sdk.common.CompletableResultCode;
import io.opentelemetry.sdk.trace.data.SpanData;
import io.opentelemetry.sdk.trace.data.StatusData;
import modelengine.jade.oms.operater.log.util.Constants;

import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 表示 {@link CarverSpanExporter} 的 OMS 操作日志导出器，包含以下功能：
 * <ul>
 *     <li>初始化时，注册国际化信息至 OMS，注册成功则标记导出器状态为可用；</li>
 *     <li>运行过程中，若导出器可用，则将操作 Span 转换为 OMS 操作日志导出至 OMS 后端服务。</li>
 * </ul>
 *
 * @author 易文渊
 * @author 何嘉斌
 * @since 2024-11-19
 */
@Component
public class OmsOperationLogExporter implements CarverSpanExporter {
    private static final Logger log = Logger.get(OmsOperationLogExporter.class);

    private final OmsOperationFlagResolver flagResolver;
    private final OperateLogClient client;
    private final Integer maxRetires = 3;
    private boolean enable = false;

    public OmsOperationLogExporter(OmsOperationFlagResolver flagResolver, OperateLogClient client) {
        this.flagResolver = flagResolver;
        this.client = client;
    }

    @Initialize
    void init() {
        List<LogI18N> i18NList = parseProperties();
        this.enable = false;
        ResultVo<Boolean> result;
        for (int i = 0; i < this.maxRetires; i++) {
            result = this.client.registryInternational(i18NList);
            if (result.getData()) {
                this.enable = true;
                break;
            }
        }
    }

    /**
     * 获取导出器是否有效。
     *
     * @return 表示是否有效的 {@code boolean}。
     */
    public boolean isEnable() {
        return this.enable;
    }

    @Override
    public String name() {
        return "oms.operation.exporter";
    }

    @Override
    public CompletableResultCode export(Collection<SpanData> spans) {
        if (!this.isEnable()) {
            return CompletableResultCode.ofSuccess();
        }
        List<OperateLog> opLogs = spans.stream().map(this::createLog).collect(Collectors.toList());
        if (opLogs.isEmpty()) {
            return CompletableResultCode.ofSuccess();
        }
        ResultVo<Integer> result = this.client.registerLogs(opLogs);
        if (!result.getCode().equals(Constants.OK)) {
            log.error("Operation log registration failed.");
        }
        return CompletableResultCode.ofSuccess();
    }

    @Override
    public CompletableResultCode flush() {
        return CompletableResultCode.ofSuccess();
    }

    @Override
    public CompletableResultCode shutdown() {
        return CompletableResultCode.ofSuccess();
    }

    private static List<LogI18N> parseProperties() {
        Map<String, String> propertiesMapping = MapBuilder.<String, String>get()
                .put("zh-cn", "/i18n/messages_zh.properties")
                .put("en-us", "/i18n/messages_en.properties")
                .build();
        return propertiesMapping.entrySet()
                .stream()
                .flatMap(entry -> IoUtils.properties(OmsOperationLogExporter.class,
                                entry.getValue(),
                                StandardCharsets.UTF_8)
                        .entrySet()
                        .stream()
                        .map(property -> new LogI18N(cast(property.getKey()),
                                entry.getKey(),
                                cast(property.getValue()))))
                .collect(Collectors.toList());
    }

    private OperateLog createLog(SpanData span) {
        Attributes attributes = span.getAttributes();
        Map<String, Object> args = span.getAttributes()
                .asMap()
                .entrySet()
                .stream()
                .collect(Collectors.toMap(entry -> entry.getKey().getKey(), Map.Entry::getValue));
        StatusData data = span.getStatus();
        String detail;
        OperateLog logVo = new OperateLog();
        logVo.setOperation(span.getName());
        logVo.setLogType(Constants.OPERATION);
        logVo.setSource(Constants.MY_SOURCE_NAME);
        logVo.setDatetime(span.getStartEpochNanos() / 1000000);
        logVo.setUsername(attributes.get(Constants.USER_NAME));
        logVo.setTerminal(attributes.get(Constants.LOG_TERMINAL));
        if (StatusCode.ERROR.equals(data.getStatusCode())) {
            logVo.setResult(Constants.FAILED_RESULT);
            args.put("cause", data.getDescription().isEmpty() ? Constants.DEFAULT_ERROR_MSG : data.getDescription());
            detail = StringUtils.concat(span.getName(), Constants.FAILED_SUFFIX);
        } else {
            logVo.setResult(Constants.SUCCEED_RESULT);
            detail = StringUtils.concat(span.getName(), Constants.SUCCEED_SUFFIX);
        }
        logVo.setDetail(detail);
        try {
            logVo.setFlag(this.flagResolver.resolve(detail, args));
        } catch (StringFormatException ex) {
            log.error("Flag format failed, operation: [{}]\nSpan args: [{}]\nError message: [{}]",
                    span.getName(),
                    args,
                    ex.getMessage(),
                    ex);
        }
        return logVo;
    }
}