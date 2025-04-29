/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.util.parser.support;

import static modelengine.fitframework.inspection.Validation.notNull;

import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.annotation.Fit;
import modelengine.fitframework.resource.Resource;
import modelengine.fitframework.serialization.ObjectSerializer;
import modelengine.fitframework.util.TypeUtils;
import modelengine.jade.oms.util.parser.JsonParser;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Type;
import java.util.List;

/**
 * JSON 解析器实现类。
 *
 * @author 鲁为
 * @since 2024-11-18
 */
@Component
public class DefaultJsonParser implements JsonParser {
    private final ObjectSerializer serializer;

    /**
     * 用序列化器实例构造 {@link DefaultJsonParser}。
     *
     * @param serializer 表示序列化器的 {@link ObjectSerializer}。
     */
    public DefaultJsonParser(@Fit(alias = "json") ObjectSerializer serializer) {
        this.serializer = notNull(serializer, "The serializer cannot be null.");
    }

    @Override
    public <T> List<T> parseList(Resource resource, Class<T> meta) {
        try (InputStream in = resource.read()) {
            return this.serializer.deserialize(in, TypeUtils.parameterized(List.class, new Type[] {meta}));
        } catch (IOException e) {
            throw new IllegalStateException("Failed to close resource.", e);
        }
    }

    @Override
    public <T> T parse(Resource resource, Class<T> meta) {
        try (InputStream in = resource.read()) {
            return this.serializer.deserialize(in, meta);
        } catch (IOException e) {
            throw new IllegalStateException("Failed to close resource.", e);
        }
    }
}
