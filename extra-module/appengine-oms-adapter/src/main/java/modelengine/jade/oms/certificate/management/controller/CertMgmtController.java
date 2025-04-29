/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.controller;

import static modelengine.jade.oms.certificate.management.dto.CertUploadReq.convert;

import modelengine.fit.http.annotation.PostMapping;
import modelengine.fit.http.annotation.RequestMapping;
import modelengine.fit.http.entity.PartitionedEntity;
import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.log.Logger;
import modelengine.jade.oms.certificate.management.constants.Constant;
import modelengine.jade.oms.certificate.management.dto.CertUploadReq;
import modelengine.jade.oms.certificate.management.service.CertMgmtService;
import modelengine.jade.oms.response.ResultVo;

/**
 * 证书管理控制器。
 *
 * @author 邱晓霞
 * @since 2024-11-27
 */
@Component
@RequestMapping("/v1/cert-mgmt")
public class CertMgmtController {
    private static final Logger LOG = Logger.get(CertMgmtController.class);

    private final CertMgmtService certMgmtService;

    public CertMgmtController(CertMgmtService certMgmtService) {
        this.certMgmtService = certMgmtService;
    }

    /**
     * 更新证书文件。
     * <p>
     * 仅作为 OMS 证书上传的回调接口用>
     * </p>
     *
     * @param partitionedEntity 表示证书上传请求表单的 {@link PartitionedEntity}。
     * @return 证书别名。
     */
    @PostMapping(path = "/update")
    public ResultVo<Boolean> updateCertificate(PartitionedEntity partitionedEntity) {
        LOG.info("Received the OMS callback.");
        try {
            CertUploadReq certUploadReq = convert(partitionedEntity);
            String alias = certMgmtService.updateCertificate(certUploadReq);
            ResultVo<Boolean> resultVo = new ResultVo<>(Constant.OMS_SUCCESS_CODE, "success to update cert", true);
            LOG.info("success to update cert {}", alias);
            return resultVo;
        } catch (Exception e) {
            LOG.error("Failed to update cert.", e);
        }
        return new ResultVo<>(Constant.OMS_ERROR_CODE, "Failed to update cert.", false);
    }
}
