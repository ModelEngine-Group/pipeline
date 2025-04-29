/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.support;

import static modelengine.fitframework.util.ObjectUtils.cast;

import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.annotation.Initialize;
import modelengine.fitframework.parameterization.ParameterizedString;
import modelengine.fitframework.parameterization.ParameterizedStringResolver;
import modelengine.fitframework.util.IoUtils;
import modelengine.fitframework.util.StringUtils;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 表示 {@link OmsOperationFlagResolver} 的 OMS 操作日志 Flag 拼接器。
 *
 * @author 易文渊
 * @author 何嘉斌
 * @since 2024-11-25
 */
@Component
public class OmsOperationFlagResolver {
    private final Map<String, ParameterizedString> cache = new HashMap<>();

    @Initialize
    void init() {
        ParameterizedStringResolver formatter = ParameterizedStringResolver.create("{{", "}}", '/');
        cache.putAll(IoUtils.properties(OmsOperationFlagResolver.class,
                        "/flag_messages.properties",
                        StandardCharsets.UTF_8)
                .entrySet()
                .stream()
                .collect(Collectors.toMap(property -> cast(property.getKey()),
                        property -> formatter.resolve(cast(property.getValue())))));
    }

    public String resolve(String detail, Map<String, ?> args) {
        ParameterizedString template = this.cache.get(detail);
        if (template == null) {
            return StringUtils.EMPTY;
        }
        return template.format(args);
    }
}