/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.role;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * {@link RoleI18nInfo} 的单元测试类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 RoleI18nInfo")
public class RoleI18nInfoTest {
    @Test
    @DisplayName("测试构造成功")
    void shouldSuccessWhenConstructRoleI18nInfo() {
        RoleI18nInfo roleI18nInfo = new RoleI18nInfo();
        roleI18nInfo.setName("app.developer.name");
        roleI18nInfo.setCode("code");
        roleI18nInfo.setLanguage("en_us");
        roleI18nInfo.setContent("App development engineer");
        Assertions.assertEquals(roleI18nInfo.getName(), "app.developer.name");
        Assertions.assertEquals(roleI18nInfo.getCode(), "code");
        Assertions.assertEquals(roleI18nInfo.getLanguage(), "en_us");
        Assertions.assertEquals(roleI18nInfo.getContent(), "App development engineer");
    }
}
