/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 许可证产品信息。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LicenseProductInfo {
    /**
     * 唯一标识。
     */
    private Integer id;

    /**
     * 产品名称。
     */
    private String productName;

    /**
     * 产品版本。
     */
    private String productVersion;

    /**
     * 产品密钥。
     */
    private String productKeyInfo;

    /**
     * 产品项名称。
     */
    private String productBbomItemName;

    /**
     * 过期告警提醒时间。
     */
    private Integer alarmBeforeExpire = 30;

    /**
     * 试用期时间。
     */
    private Integer trialPeriod = 90;
}
