/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.response;

import modelengine.jade.oms.response.ResultVo;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * {@link ResultVo} 的单元测试类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 ResultVo")
public class ResultVoTest {
    @Test
    @DisplayName("测试空参成功")
    void shouldSuccessWhenConstructWithoutInput() {
        ResultVo resultVo = new ResultVo();
        Assertions.assertEquals("0", resultVo.getCode());
    }
}
