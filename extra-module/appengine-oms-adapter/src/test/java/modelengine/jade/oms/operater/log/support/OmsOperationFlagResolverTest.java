/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.support;

import static org.assertj.core.api.Assertions.assertThat;

import modelengine.fitframework.util.MapBuilder;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * 表示 {@link OmsOperationFlagResolver} 的测试集。
 *
 * @author 何嘉斌
 * @since 2024-11-26
 */
public class OmsOperationFlagResolverTest {
    private static OmsOperationFlagResolver resolver;

    @BeforeAll
    static void init() {
        resolver = new OmsOperationFlagResolver();
        resolver.init();
    }

    @Test
    @DisplayName("渲染 Flag 成功")
    public void shouldOkWhenResolveFlag() {
        assertThat(resolver.resolve("operation.appBuilderApp.publish.succeed.detail",
                MapBuilder.<String, String>get().put("name", "name1").put("version", "1.0.0").build())).isEqualTo(
                "name1;1.0.0");
    }
}