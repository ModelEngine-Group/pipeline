/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.menu;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Collections;

/**
 * {@link MenuRegisterInfo} 的单元测试类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 MenuRegisterInfo")
public class MenuRegisterInfoTest {
    @Test
    @DisplayName("测试构造成功")
    void shouldSuccessWhenConstructMenuRegisterInfo() {
        MenuRegisterInfo menuRegisterInfo = new MenuRegisterInfo();
        menuRegisterInfo.setMenuId("App Enablement");
        menuRegisterInfo.setParentMenuId("parenMenuId");
        menuRegisterInfo.setMenuNameCode("ModelEngine_appEngine");
        menuRegisterInfo.setUrl("url");
        menuRegisterInfo.setIconUrl("icon");
        menuRegisterInfo.setEn("App Enablement");
        menuRegisterInfo.setZh("应用使能");
        menuRegisterInfo.setWeight(4);
        menuRegisterInfo.setEnable(true);
        menuRegisterInfo.setRoleSceneMap(Collections.emptyList());
        Assertions.assertEquals(menuRegisterInfo.getMenuId(), "App Enablement");
        Assertions.assertEquals(menuRegisterInfo.getParentMenuId(), "parenMenuId");
        Assertions.assertEquals(menuRegisterInfo.getMenuNameCode(), "ModelEngine_appEngine");
        Assertions.assertEquals(menuRegisterInfo.getUrl(), "url");
        Assertions.assertEquals(menuRegisterInfo.getIconUrl(), "icon");
        Assertions.assertEquals(menuRegisterInfo.getEn(), "App Enablement");
        Assertions.assertEquals(menuRegisterInfo.getZh(), "应用使能");
        Assertions.assertEquals(menuRegisterInfo.getWeight(), 4);
        Assertions.assertTrue(menuRegisterInfo.isEnable());
        Assertions.assertTrue(menuRegisterInfo.getRoleSceneMap().isEmpty());

    }
}
