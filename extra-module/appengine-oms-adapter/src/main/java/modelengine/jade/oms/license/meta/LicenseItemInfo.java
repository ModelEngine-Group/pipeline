/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 许可证产品控制项信息。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LicenseItemInfo {
    /**
     * 类型，有Trial、Formal。
     */
    private String type;

    /**
     * 产品控制项名称。
     */
    private String itemName;

    /**
     * 控制项单位。
     */
    private String unit;

    /**
     * 使用数量。
     */
    private Integer amount;

    /**
     * 总量。
     */
    private Integer total;
}
