/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 有效期。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Vaildpriods {
    /**
     * 版本。
     */
    private String licenseVersion;

    /**
     * 剩余天数。
     */
    private String reminDays;

    /**
     * 结束数据。
     */
    private long sasEndData;

    /**
     * 导入时间。
     */
    private long importTime;

    /**
     * 截止时间。
     */
    private long deadline;

    /**
     * 状态。
     */
    private String status;

    /**
     * 软件唯一标识。
     */
    private String softwareId;
}
