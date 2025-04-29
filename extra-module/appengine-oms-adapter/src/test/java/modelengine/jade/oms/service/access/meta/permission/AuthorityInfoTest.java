/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.permission;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Arrays;

/**
 * {@link AuthorityInfo} 的单元测试类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 AuthorityInfo")
public class AuthorityInfoTest {
    @Test
    @DisplayName("测试构造成功")
    void shouldSuccessWhenConstructAuthorityInfo() {
        AuthorityInfo authorityInfo = new AuthorityInfo();
        authorityInfo.setDescription("获取知识库列表");
        authorityInfo.setResourceKey("GET /v1/api/([0-9a-f]{32})/knowledge/repos");
        authorityInfo.setSkipCheck(false);
        authorityInfo.setRoles(Arrays.asList("ApplicationDeveloper", "FullstackDeveloper", "SYS_ADMIN"));
        Assertions.assertEquals(authorityInfo.getDescription(), "获取知识库列表");
        Assertions.assertEquals(authorityInfo.getResourceKey(), "GET /v1/api/([0-9a-f]{32})/knowledge/repos");
        Assertions.assertFalse(authorityInfo.isSkipCheck());
        Assertions.assertEquals(authorityInfo.getRoles().size(), 3);
    }
}
