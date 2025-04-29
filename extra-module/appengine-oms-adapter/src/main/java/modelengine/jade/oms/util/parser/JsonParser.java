/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.util.parser;

import modelengine.fitframework.resource.Resource;

import java.util.List;

/**
 * JSON 解析器接口类。
 *
 * @author 鲁为
 * @since 2024-11-18
 */
public interface JsonParser {
    /**
     * 反序列化资源中的 JSON 文件为元数据列表。
     *
     * @param resource 表示资源文件的 {@link Resource}。
     * @param meta 表示元数据的类型的 {@link Class}{@code <}{@link T}{@code >}。
     * @return 泛型元数据列表的 {@link List}{@code <}{@link T}{@code >}。
     */
    <T> List<T> parseList(Resource resource, Class<T> meta);

    /**
     * 反序列化 JSON 文件为元数据。
     *
     * @param resource 表示资源文件的 {@link Resource}。
     * @param meta 表示元数据的类型的 {@link Class}{@code <}{@link T}{@code >}。
     * @return 泛型元数据的 {@link T}。
     */
    <T> T parse(Resource resource, Class<T> meta);
}
