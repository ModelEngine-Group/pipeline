/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.menu;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * {@link MenuInfo} 的单元测试。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 MenuInfo")
public class MenuInfoTest {
    @Test
    @DisplayName("测试构造成功")
    void shouldSuccessWhenConstructMenuInfo() {
        MenuInfo menuInfo = new MenuInfo();
        menuInfo.setId(1);
        menuInfo.setMenuId("App Enablement");
        menuInfo.setParentMenuId("parenMenuId");
        menuInfo.setMenuName("ModelEngine_appEngine");
        menuInfo.setUrl("url");
        menuInfo.setIcon("icon");
        menuInfo.setEn("App Enablement");
        menuInfo.setZh("应用使能");
        menuInfo.setEnable(true);
        Assertions.assertEquals(menuInfo.getMenuId(), "App Enablement");
        Assertions.assertEquals(menuInfo.getParentMenuId(), "parenMenuId");
        Assertions.assertEquals(menuInfo.getMenuName(), "ModelEngine_appEngine");
        Assertions.assertEquals(menuInfo.getUrl(), "url");
        Assertions.assertEquals(menuInfo.getIcon(), "icon");
        Assertions.assertEquals(menuInfo.getEn(), "App Enablement");
        Assertions.assertEquals(menuInfo.getZh(), "应用使能");
        Assertions.assertTrue(menuInfo.isEnable());
    }
}
