/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.license.handler;


import static modelengine.fit.jober.aipp.common.exception.AippErrCode.INVALID_LICENSE;
import static modelengine.fitframework.inspection.Validation.notNull;

import modelengine.fit.jober.aipp.common.exception.AippException;
import modelengine.fit.jober.aipp.events.AppCreatingEvent;
import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.event.EventHandler;
import modelengine.jade.oms.license.manager.LicenseClient;

/**
 * 许可证事件的处理器。
 *
 * @author 李金绪
 * @since 2024-12-05
 */
@Component
public class AppCreateEventHandler implements EventHandler<AppCreatingEvent> {
    private final LicenseClient licenseClient;

    /**
     * 构造函数。
     *
     * @param licenseClient 表示许可证客户端的 {@link LicenseClient}。
     */
    public AppCreateEventHandler(LicenseClient licenseClient) {
        this.licenseClient = notNull(licenseClient, "The license client cannot be null.");
    }

    @Override
    public void handleEvent(AppCreatingEvent event) {
        if (!this.licenseClient.isLicenseValid()) {
            throw new AippException(INVALID_LICENSE);
        }
    }
}
