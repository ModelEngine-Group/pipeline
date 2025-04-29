/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.feignclient.impl;

import modelengine.fit.http.protocol.HttpRequestMethod;
import modelengine.fitframework.annotation.Component;
import modelengine.jade.oms.OmsClient;
import modelengine.jade.oms.certificate.management.dto.CertTypeRegisterReq;
import modelengine.jade.oms.certificate.management.feignclient.CertMgmtClient;
import modelengine.jade.oms.entity.PartitionedEntity;
import modelengine.jade.oms.response.ResultVo;
import modelengine.jade.oms.util.Constants;

/**
 * OMS 证书注册相关接口。
 *
 * @author 邱晓霞
 * @since 2024-11-29
 */
@Component
public class DefaultCertMgmtClient implements CertMgmtClient {
    private static final String CHECK_CERTIFICATE_IS_EXIST_URL = "/framework/v1/certificate/action/check/internal";
    private static final String CERTIFICATE_TYPE_REGISTER_URL =
            "/framework/v1/certificate/action/register/type/internal";
    private static final String CERTIFICATE_REGISTER_URL = "/framework/v1/certificate/action/import/om";

    private final OmsClient client;

    /**
     * 构造方法。
     *
     * @param client 表示证书管理客户端的 {@link OmsClient}。
     */
    public DefaultCertMgmtClient(OmsClient client) {
        this.client = client;
    }

    @Override
    public ResultVo<Boolean> checkCertIsExist(String alias) {
        return client.executeText(Constants.OMS_FRAMEWORK_NAME,
                HttpRequestMethod.POST,
                CHECK_CERTIFICATE_IS_EXIST_URL,
                alias,
                Boolean.class);
    }

    @Override
    public ResultVo<Boolean> registerCertificateType(CertTypeRegisterReq certTypeRegisterReq) {
        return client.executeJson(Constants.OMS_FRAMEWORK_NAME,
                HttpRequestMethod.POST,
                CERTIFICATE_TYPE_REGISTER_URL,
                certTypeRegisterReq,
                Boolean.class);
    }

    @Override
    public ResultVo<Boolean> importCertificateOm(PartitionedEntity partitionedEntity) {
        return client.upload(Constants.OMS_FRAMEWORK_NAME,
                HttpRequestMethod.POST,
                CERTIFICATE_REGISTER_URL,
                partitionedEntity,
                Boolean.class);
    }
}
