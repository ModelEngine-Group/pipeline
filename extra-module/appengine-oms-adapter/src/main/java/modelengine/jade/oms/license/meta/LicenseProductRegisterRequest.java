/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import modelengine.fitframework.annotation.Property;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 许可证产品控制项注册请求。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LicenseProductRegisterRequest extends LicenseProductInfo {
    /**
     * 控制项信息列表。
     */
    @Property(name = "items")
    private List<LicenseItemInfo> licenseItemInfoList;
}
