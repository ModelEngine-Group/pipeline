/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 证书注册类型。
 *
 * @author 邱晓霞
 * @since 2024-11-29
 */
@AllArgsConstructor
@Getter
public enum CertRegisterMode {
    /**
     * 普通类型。
     */
    GENERAL("type_general"),

    /**
     * 需要秘钥。
     */
    NEED_KEY("type_need_key"),

    /**
     * 需要秘钥密码。
     */
    NEED_PWD("type_need_pwd"),

    /**
     * CA。
     */
    CA("type_ca"),

    /**
     * 国密。
     */
    SM("type_sm"),

    /**
     * 需要客户端。
     */
    NEED_CLIENT("type_need_client");

    private final String certRegisterMode;
}
