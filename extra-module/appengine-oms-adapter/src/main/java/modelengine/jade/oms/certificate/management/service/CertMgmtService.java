/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.service;

import modelengine.jade.oms.certificate.management.dto.CertUploadReq;
import modelengine.jade.oms.certificate.management.enums.CertEncType;
import modelengine.jade.oms.certificate.management.enums.CertRegisterMode;

/**
 * 证书管理服务接口类。
 *
 * @author 邱晓霞
 * @since 2024-11-27
 */
public interface CertMgmtService {
    /**
     * 证书管理上传内部服务证书的业务接口。
     *
     * @param certUploadReq 表示证书上传参数的 {@link CertUploadReq}。
     * @return 表示上传结果的 {@link String}。
     */

    String updateCertificate(CertUploadReq certUploadReq);

    /**
     * 注册证书类型到 OMS。
     *
     * @param alias 表示证书别名的 {@link String}。
     * @param encType 表示加密类型 {common, sm} 的 {@link CertEncType}。
     * @param certRegMode 表示证书模式的 {@link CertRegisterMode}。
     * @param url 表示回调 url 的 {@link String}。
     * @return 表示注册结果的 {@link Boolean}。
     */
    Boolean registerCertificateType(String alias, CertEncType encType, CertRegisterMode certRegMode, String url);

    /**
     * 导入证书到 OMS。
     *
     * @param alias 表示证书别名的 {@link String}。
     * @param certPath 表示证书路径的 {@link String}。
     * @param caCertPath 表示 ca 证书路径的 {@link String}。
     * @param privateKeyPath 表示密钥路径的 {@link String}。
     * @param passwordPath 表示密钥密码路径的 {@link String}。
     */
    void uploadCertificateToOms(String alias, String certPath, String caCertPath, String privateKeyPath,
            String passwordPath);

    /**
     * 导入证书到 OMS。
     */
    void registerCertToOms();
}
