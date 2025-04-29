/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 许可证详情。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LicenseInfo {
    /**
     * 系统安装日期，数据库存时间戳，给前台也返回时间戳。
     */
    private long installTime;

    /**
     * 许可证导入时间。
     */
    private long importTime;

    /**
     * 维保日期。
     */
    private String snsDeadline;

    /**
     * 许可证信息列表。
     */
    private List<LicenseInfoEx> sboms;

    /**
     * 许可证类型。
     */
    private String licenseType;

    /**
     * 许可证截止日期。
     */
    private String deadline;

    /**
     * 是否正式的许可证。
     */
    private boolean isFormal;

    /**
     * 许可证的存储核数。
     */
    private int storageCores;

    /**
     * 已经使用的存储核数。
     */
    private int usedStorageCores;

    /**
     * 许可证的 CPU 核数。
     */
    private int computeCores;

    /**
     * 已经使用的 CPU 核数。
     */
    private int usedComputeCores;

    /**
     * 许可证的 vCPU 核数。
     */
    private int virtualComputeCores;

    /**
     * 已经使用的 vCPU 核数。
     */
    private int usedVirtualComputeCores;

    /**
     * status 许可证状态。
     * 0没有导入 1已经正常上传但是未激活 2已经激活 3已经注销。
     */
    private String status;

    /**
     * 许可证数据。
     */
    private LicenseFileData fileData;

    /**
     * 许可证号。
     */
    private List<LicenseData> licenseData;

    /**
     * 提示信息。
     */
    private List<LicenseNoticeData> licenseNoticeData;

    /**
     * 有效期。
     */
    private Vaildpriods vaildpriods;
}
