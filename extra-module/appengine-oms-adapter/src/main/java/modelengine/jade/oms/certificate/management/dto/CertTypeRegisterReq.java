/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 证书注册请求参数。
 *
 * @author 邱晓霞
 * @since 2024-11-29
 */
@AllArgsConstructor
@Getter
public class CertTypeRegisterReq {
    /**
     * 证书别名，唯一
     */
    private String alias;

    /**
     * 加密类型：国际/国密
     */
    private String encType;

    /**
     * 证书模式，不同模式的证书输入不同
     */
    private String certMode;

    /**
     * 回调时的url
     */
    private String url;
}
