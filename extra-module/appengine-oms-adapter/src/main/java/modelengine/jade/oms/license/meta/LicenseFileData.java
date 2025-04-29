/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import modelengine.fitframework.annotation.Property;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 许可证文件。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LicenseFileData {
    /**
     * 业务模式。
     */
    private String businessModel;

    /**
     * 国家。
     */
    private String country;

    /**
     * 创建者。
     */
    private String creator;

    /**
     * 自定义。
     */
    private String custom;

    /**
     * 办事处。
     */
    private String office;

    /**
     * 硬件序列号。
     */
    private String esn;

    /**
     * 许可证文件版本。
     */
    @Property(name = "licenseNO")
    private String licenseNo;

    /**
     * 软件版本。
     */
    private String softwareId;

    /**
     * 到期时间。
     */
    private String createTime;
}
