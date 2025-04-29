/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.meta;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 许可证。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LicenseData {
    /**
     * 唯一标识。
     */
    private String id;

    /**
     * 秘钥名字。
     */
    private String keyName;

    /**
     * 许可证数量。
     */
    private String limit;

    /**
     * 名字。
     */
    private String name;

    /**
     * 产品名称。
     */
    private String productName;

    /**
     * 产品版本号。
     */
    private String productVersion;

    /**
     * 资源总使用量。
     */
    private String resourseData;

    /**
     * 本站使用量。
     */
    private String clientResourseData;

    /**
     * 许可证资源名称。
     */
    private String dimensional;

    /**
     * 0:基本版本。
     * 1：高级版本。
     * -1：无license或者注销license。
     */
    private String type;
}
