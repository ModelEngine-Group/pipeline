/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.constants;

/**
 * 常量类。
 *
 * @author 邱晓霞
 * @since 2024-11-28
 */
public final class Constant {
    /**
     * 证书别名。
     */
    public static final String ALIAS = "alias";

    /**
     * 证书。
     */
    public static final String CERT = "cert";

    /**
     * ca 证书。
     */
    public static final String CACERT = "caCert";

    /**
     * 证书私钥。
     */
    public static final String PRIVATE_KEY = "privateKey";

    /**
     * 私钥密码。
     */
    public static final String PASSWORD = "password";

    /**
     * 成功码。
     */
    public static final String OMS_SUCCESS_CODE = "0";

    /**
     * 错误码。
     */
    public static final String OMS_ERROR_CODE = "1";

    /**
     * 证书文件扩展名。
     */
    public static final String CERT_EXTENSION = "crt";

    /**
     * 私钥文件扩展名。
     */
    public static final String PRIVATE_KEY_EXTENSION = "key";

    private Constant() {
    }
}