/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.convertor;

import modelengine.fit.http.entity.NamedEntity;
import modelengine.jade.oms.certificate.management.dto.CertUploadReq;

/**
 * 请求参数转换器。
 *
 * @author 邱晓霞
 * @since 2024-11-28
 */
@FunctionalInterface
public interface NamedEntityToRequestParamConvertor {
    /**
     * 将上传的参数转换为 CertUploadReq。
     *
     * @param certUploadReq 表示证书上传请求体的 {@link CertUploadReq}。
     * @param namedEntity 表示 {@link NamedEntity}。
     */
    void convert(CertUploadReq certUploadReq, NamedEntity namedEntity);
}