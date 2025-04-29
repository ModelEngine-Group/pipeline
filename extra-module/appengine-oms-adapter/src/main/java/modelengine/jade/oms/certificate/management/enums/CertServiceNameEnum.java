/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 证书所属服务。
 *
 * @author 邱晓霞
 * @since 2024-11-27
 */
@AllArgsConstructor
@Getter
public enum CertServiceNameEnum {
    INTERNAL("global"),
    NGINX("nginx");

    private final String subPath;
}
