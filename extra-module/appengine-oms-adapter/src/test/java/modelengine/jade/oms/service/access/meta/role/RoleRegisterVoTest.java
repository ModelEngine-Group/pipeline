/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.role;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Collections;

/**
 * {@link RoleRegisterVo} 的单元测试类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 RoleRegisterVo")
public class RoleRegisterVoTest {
    @Test
    @DisplayName("测试构造成功")
    void shouldSuccessWhenConstructRoleRegisterVo() {
        RoleRegisterVo roleRegisterVo = new RoleRegisterVo();
        roleRegisterVo.setRoleRegisterInfos(Collections.emptyList());
        roleRegisterVo.setRoleI18nInfos(Collections.emptyList());
        Assertions.assertEquals(roleRegisterVo.getRoleRegisterInfos().size(), 0);
        Assertions.assertEquals(roleRegisterVo.getRoleI18nInfos().size(), 0);
    }
}
