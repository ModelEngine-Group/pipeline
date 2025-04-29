/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.feignclient;

import modelengine.jade.oms.certificate.management.dto.CertTypeRegisterReq;
import modelengine.jade.oms.entity.PartitionedEntity;
import modelengine.jade.oms.response.ResultVo;

/**
 * OMS 证书注册相关接口。
 *
 * @author 邱晓霞
 * @since 2024-11-29
 */
public interface CertMgmtClient {
    /**
     * 注册证书类型到 OMS。
     *
     * @param certTypeRegisterReq 表示证书类型注册请求体的 {@link CertTypeRegisterReq}
     * @return 表示注册结果的 {@link ResultVo}{@code <}{@link Boolean}{@code >}。
     */
    ResultVo<Boolean> registerCertificateType(CertTypeRegisterReq certTypeRegisterReq);

    /**
     * 导入证书至 OMS。
     *
     * @param partitionedEntity 表示证书导入请求参数的 {@link PartitionedEntity}。
     * @return 表示注册结果的 {@link ResultVo}{@code <}{@link Boolean}{@code >}。
     */
    ResultVo<Boolean> importCertificateOm(PartitionedEntity partitionedEntity);

    /**
     * 检查证书是否存在。
     *
     * @param alias 表示证书别名的 {@link String}。
     * @return 表示证书是否存在的 {@link ResultVo}{@code <}{@link Boolean}{@code >}。
     */
    ResultVo<Boolean> checkCertIsExist(String alias);
}