/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 许可证提示信息。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LicenseNoticeData {
    /**
     * 提示信息唯一标识。
     */
    private String id;

    /**
     * 提示信息描述。
     */
    private String noticeInfo;
}
