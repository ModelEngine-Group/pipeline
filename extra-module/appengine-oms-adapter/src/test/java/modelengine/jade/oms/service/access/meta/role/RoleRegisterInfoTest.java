/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.role;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * {@link RoleRegisterInfo} 的单元测试类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 RoleRegisterInfo")
public class RoleRegisterInfoTest {
    @Test
    @DisplayName("测试构造成功")
    void shouldSuccessWhenConstructRoleRegisterInfo() {
        RoleRegisterInfo roleRegisterInfo = new RoleRegisterInfo();
        roleRegisterInfo.setRoleName("ApplicationDeveloper");
        roleRegisterInfo.setNameCode("app.developer.name");
        roleRegisterInfo.setDescription("app.developer.description");
        roleRegisterInfo.setCreatable(true);
        roleRegisterInfo.setSupportLoginType(1);
        Assertions.assertEquals(roleRegisterInfo.getRoleName(), "ApplicationDeveloper");
        Assertions.assertEquals(roleRegisterInfo.getNameCode(), "app.developer.name");
        Assertions.assertEquals(roleRegisterInfo.getDescription(), "app.developer.description");
        Assertions.assertTrue(roleRegisterInfo.isCreatable());
        Assertions.assertEquals(roleRegisterInfo.getSupportLoginType(), 1);
    }
}
