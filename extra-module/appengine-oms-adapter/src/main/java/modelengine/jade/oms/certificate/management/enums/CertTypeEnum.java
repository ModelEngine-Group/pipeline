/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Collections;
import java.util.List;

/**
 * 证书类型。
 *
 * @author 邱晓霞
 * @since 2024-11-27
 */
@AllArgsConstructor
@Getter
public enum CertTypeEnum {
    /**
     * 公钥。
     */
    CERT(0, Collections.singletonList(".crt")),

    /**
     * 私钥。
     */
    KEY(1, Collections.singletonList(".key")),

    /**
     * 证书链。
     */
    CHAIN(2, Collections.singletonList(".crt")),

    /**
     * 吊销列表
     */
    CRL(3, Collections.singletonList(".crl"));

    private final int value;

    private final List<String> allowedExtension;
}
