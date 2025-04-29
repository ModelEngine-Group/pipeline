/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.manager;

import modelengine.jade.oms.license.meta.LicenseInfo;
import modelengine.jade.oms.license.meta.LicenseProductRegisterRequest;
import modelengine.jade.oms.response.ResultVo;

/**
 * 许可证处理客户端。
 *
 * @author 李金绪
 * @since 2024-12-04
 */
public interface LicenseClient {
    /**
     * 获取许可证信息。
     *
     * @return 表示许可证信息的 {@link LicenseInfo}。
     */
    ResultVo<LicenseInfo> getLicenseInfo();

    /**
     * 获取许可证是否有效。
     *
     * @return 表示许可证是否有效的 {@code boolean}。
     */
    boolean isLicenseValid();

    /**
     * 注册默认产品信息。
     */
    void registerProductInfo();

    /**
     * 注册产品信息。
     *
     * @param request 表示注册产品信息的请求的  {@link LicenseProductRegisterRequest}。
     */
    void registerProductInfo(LicenseProductRegisterRequest request);
}
