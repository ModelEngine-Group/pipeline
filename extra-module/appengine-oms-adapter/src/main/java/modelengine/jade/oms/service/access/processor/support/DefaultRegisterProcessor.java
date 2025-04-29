/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.processor.support;

import static modelengine.jade.oms.util.Constants.OMS_FRAMEWORK_NAME;

import modelengine.fit.http.protocol.HttpRequestMethod;
import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.resource.Resource;
import modelengine.jade.oms.OmsClient;
import modelengine.jade.oms.service.access.meta.menu.MenuInfo;
import modelengine.jade.oms.service.access.meta.menu.MenuRegisterInfo;
import modelengine.jade.oms.service.access.meta.permission.AuthorityInfo;
import modelengine.jade.oms.service.access.meta.role.RoleRegisterVo;
import modelengine.jade.oms.service.access.processor.RegisterProcessor;
import modelengine.jade.oms.util.parser.JsonParser;

import java.util.List;

/**
 * rbac 注册处理器的实现类。
 *
 * @author 鲁为
 * @since 2024-11-18
 */
@Component
public class DefaultRegisterProcessor implements RegisterProcessor {
    private static final String URI_REGISTER_ROLE = "/framework/v1/iam/roles/batch/register/internal";
    private static final String URI_REGISTER_PERMISSION = "/framework/v1/iam/permission/batch/register/internal";
    private static final String URI_REGISTER_MENU = "/framework/v1/customize/menu/register/internal";

    private final JsonParser parser;
    private final OmsClient omsClient;

    /**
     * 用 JSON 解析器的实例构造 {@link DefaultRegisterProcessor}。
     *
     * @param omsClient 表示 OMS 客户端的 {@link OmsClient}。
     * @param parser 表示 JSON 解析器的 {@link JsonParser}。
     */
    public DefaultRegisterProcessor(OmsClient omsClient, JsonParser parser) {
        this.omsClient = omsClient;
        this.parser = parser;
    }

    @Override
    public <T> List<T> parse(Resource resource, Class<T> meta) {
        return this.parser.parseList(resource, meta);
    }

    @Override
    public void registerMenu(List<MenuRegisterInfo> metaList) {
        for (MenuRegisterInfo menuRegisterInfo : metaList) {
            this.omsClient.executeJson(OMS_FRAMEWORK_NAME,
                    HttpRequestMethod.POST,
                    URI_REGISTER_MENU,
                    menuRegisterInfo,
                    MenuInfo.class);
        }
    }

    @Override
    public void registerRole(List<RoleRegisterVo> metaList) {
        for (RoleRegisterVo roleRegisterVo : metaList) {
            this.omsClient.executeJson(OMS_FRAMEWORK_NAME,
                    HttpRequestMethod.POST,
                    URI_REGISTER_ROLE,
                    roleRegisterVo,
                    String.class);
        }
    }

    @Override
    public void registerPermission(List<AuthorityInfo> metaList) {
        this.omsClient.executeJson(OMS_FRAMEWORK_NAME,
                HttpRequestMethod.POST,
                URI_REGISTER_PERMISSION,
                metaList,
                String.class);
    }
}
