/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 证书所属类别：身份证书、信任证书、吊销列表。
 *
 * @author 邱晓霞
 * @since 2024-11-27
 */
@AllArgsConstructor
@Getter
public enum CertCategoryEnum {
    IDENTITY("identity", "identity.cnf"),
    TRUST("trust", "trust.cnf"),
    CRL("crl", "crl.cnf");

    /**
     * 对应类型证书保存的子目录名。
     */
    private final String folderName;

    /**
     * 对应类型证书配置文件名。
     */
    private final String configFileName;
}
