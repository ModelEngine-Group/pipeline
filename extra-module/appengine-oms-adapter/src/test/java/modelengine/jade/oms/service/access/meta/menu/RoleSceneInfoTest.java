/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.menu;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * {@link RoleSceneInfo} 的单元测试类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 RoleSceneInfo")
public class RoleSceneInfoTest {
    @Test
    @DisplayName("测试构造成功")
    void shouldSuccessWhenConstructRoleSceneInfo() {
        RoleSceneInfo roleSceneInfo = new RoleSceneInfo();
        roleSceneInfo.setMenuId("App Enablement");
        roleSceneInfo.setRoleName("DataDeveloper");
        roleSceneInfo.setSceneId("4");
        Assertions.assertEquals(roleSceneInfo.getMenuId(), "App Enablement");
        Assertions.assertEquals(roleSceneInfo.getRoleName(), "DataDeveloper");
        Assertions.assertEquals(roleSceneInfo.getSceneId(), "4");
    }
}
