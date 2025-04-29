/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.util;

import modelengine.fitframework.resource.Resource;
import modelengine.fitframework.resource.ResourceResolver;
import modelengine.fitframework.util.StringUtils;

import java.io.IOException;

/**
 * 资源工具类。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
public class ResourceUtils {
    /**
     * 解析资源。
     *
     * @param resolver 表示资源解析器的 {@link ResourceResolver}。
     * @param sourceName 表示资源的名称的 {@link String}。
     * @return 返回解析后的资源的 {@link Resource}。
     * @throws IllegalStateException 解析过程发生输入输出异常时或资源列表为空时。
     */
    public static Resource resolve(ResourceResolver resolver, String sourceName) {
        try {
            Resource[] resources = resolver.resolve(sourceName);
            if (resources.length < 1) {
                throw new IllegalStateException(StringUtils.format("The resources cannot be empty. [name={0}]",
                        sourceName));
            }
            return resources[0];
        } catch (IOException e) {
            throw new IllegalStateException("Failed to resolve resource.", e);
        }
    }
}
