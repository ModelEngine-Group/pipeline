/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 许可证信息。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LicenseInfoEx {
    /**
     * 许可证名称。
     */
    private String name;

    /**
     * 许可证值。
     */
    private String value;

    /**
     * 总量。
     */
    private String total;

    /**
     * 使用量。
     */
    private String used;
}
