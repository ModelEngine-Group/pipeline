/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.code;

import modelengine.jade.common.code.RetCode;

/**
 * OMS 相关错误码。
 *
 * @author 邱晓霞
 * @since 2024-12-13
 */
public enum OmsRetCode implements RetCode {
    FAIL_TO_SAVE_CERT(130909002, "Failed to save the certificate."),
    FAIL_TO_SAVE_TRUST_CONFIG_FILE(130909003, "Failed to save the trust configuration file."),
    UNSUPPORTED_FILE_TYPE(130909004, "The file type is not supported.");

    private final int code;
    private final String msg;

    OmsRetCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    @Override
    public int getCode() {
        return this.code;
    }

    @Override
    public String getMsg() {
        return this.msg;
    }
}
