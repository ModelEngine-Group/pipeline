/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.util.parse.impl;

import modelengine.fitframework.resource.Resource;
import modelengine.fitframework.serialization.ObjectSerializer;
import modelengine.fitframework.util.TypeUtils;
import modelengine.jade.oms.service.access.meta.role.RoleI18nInfo;
import modelengine.jade.oms.util.parser.support.DefaultJsonParser;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Type;
import java.util.Collections;
import java.util.List;

/**
 * {@link DefaultJsonParser} 的单元测试类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 JsonParserImpl")
@ExtendWith(MockitoExtension.class)
public class DefaultJsonParserTest {
    @Mock
    private ObjectSerializer serializer;

    @Mock
    private Resource resource;

    private DefaultJsonParser parser;

    @BeforeEach
    void setup() {
        this.parser = new DefaultJsonParser(this.serializer);
        InputStream inputStream = this.mockResource();
        try {
            Mockito.when(this.resource.read()).thenReturn(inputStream);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        Mockito.when(this.serializer.deserialize(inputStream,
                TypeUtils.parameterized(List.class, new Type[] {RoleI18nInfo.class}))).thenReturn(this.mockRoleI18n());
    }

    private InputStream mockResource() {
        String mockRoleI18n =
                " [{\"code\":\"app.developer.name\",\n\"language\":\"en_us\",\n\"content\":\"App development "
                        + "engineer\"\n}]";
        byte[] data = mockRoleI18n.getBytes();
        return new ByteArrayInputStream(data);
    }

    private List<RoleI18nInfo> mockRoleI18n() {
        RoleI18nInfo roleI18nInfo = new RoleI18nInfo();
        roleI18nInfo.setCode("app.developer.name");
        return Collections.singletonList(roleI18nInfo);
    }

    @Test
    @DisplayName("测试解析应该成功。")
    void shouldSuccessWhenParseRoleI18n() {
        List<RoleI18nInfo> infoList = this.parser.parseList(this.resource, RoleI18nInfo.class);
        Assertions.assertEquals(infoList.size(), 1);
        Assertions.assertEquals(infoList.get(0).getCode(), "app.developer.name");
    }
}
