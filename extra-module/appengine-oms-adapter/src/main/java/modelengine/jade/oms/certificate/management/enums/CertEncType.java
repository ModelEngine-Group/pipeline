/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 证书加密类型。
 *
 * @author 邱晓霞
 * @since 2024-11-29
 */
@AllArgsConstructor
@Getter
public enum CertEncType {
    /**
     * 国际。
     */
    COMMON("common"),

    /**
     * 国密。
     */
    SM("sm");

    private final String certEncType;
}