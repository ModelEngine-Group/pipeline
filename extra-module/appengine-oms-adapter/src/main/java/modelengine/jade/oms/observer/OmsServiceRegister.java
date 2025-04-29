/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.observer;

import static modelengine.fitframework.inspection.Validation.notNull;
import static modelengine.fitframework.util.ObjectUtils.cast;
import static modelengine.jade.oms.util.ResourceUtils.resolve;

import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.annotation.Value;
import modelengine.fitframework.log.Logger;
import modelengine.fitframework.plugin.Plugin;
import modelengine.fitframework.resource.ResourceResolver;
import modelengine.fitframework.runtime.FitRuntime;
import modelengine.fitframework.runtime.FitRuntimeStartedObserver;
import modelengine.jade.oms.certificate.management.service.CertMgmtService;
import modelengine.jade.oms.license.manager.LicenseClient;
import modelengine.jade.oms.service.access.meta.menu.MenuRegisterInfo;
import modelengine.jade.oms.service.access.meta.permission.AuthorityInfo;
import modelengine.jade.oms.service.access.meta.role.RoleI18nInfo;
import modelengine.jade.oms.service.access.meta.role.RoleRegisterInfo;
import modelengine.jade.oms.service.access.meta.role.RoleRegisterVo;
import modelengine.jade.oms.service.access.processor.RegisterProcessor;

import java.util.Arrays;
import java.util.List;

/**
 * 解析资源注册 OMS 服务类。
 *
 * @author 鲁为
 * @since 2024-11-18
 */
@Component
public class OmsServiceRegister implements FitRuntimeStartedObserver {
    private static final Logger LOG = Logger.get(OmsServiceRegister.class);
    private static final String MENU_RESOURCE = "menu/preset_menu_data.json";
    private static final String ROLE_RESOURCE = "role/preset_role.json";
    private static final String ROLE_I18N_RESOURCE = "role/preset_role_i18n.json";
    private static final String COMMUNITY_MENU_RESOURCE = "community/menu/preset_menu_data.json";
    private static final String COMMUNITY_ROLE_RESOURCE = "community/role/preset_role.json";
    private static final String COMMUNITY_ROLE_I18N_RESOURCE = "community/role/preset_role_i18n.json";
    private static final List<String> AUTHORITY_RESOURCES = Arrays.asList("api/common.json",
            "api/rest-service-aipp.json",
            "api/rest-service-appBuilder.json",
            "api/rest-service-store.json",
            "api/rest-service-eval.json",
            "api/rest-service-metrics.json",
            "api/rest-service-northApi.json");
    private static final List<String> COMMUNITY_AUTHORITY_RESOURCES = Arrays.asList("community/api/common.json",
            "community/api/rest-service-aipp.json",
            "community/api/rest-service-appBuilder.json",
            "community/api/rest-service-store.json",
            "community/api/rest-service-eval.json",
            "community/api/rest-service-metrics.json",
            "community/api/rest-service-northApi.json");

    private final Plugin plugin;
    private final RegisterProcessor registerProcessor;
    private final LicenseClient licenseClient;
    private final CertMgmtService certMgmtService;
    private final Boolean initCert;

    /**
     * 用插件实例和注册处理器实例构造 {@link OmsServiceRegister} 实例。
     *
     * @param plugin 表示插件类的 {@link Plugin}。
     * @param registerProcessor 表示注册处理器的 {@link RegisterProcessor}。
     * @param licenseClient 表示许可证客户端的 {@link LicenseClient}。
     * @param certMgmtService
     */
    public OmsServiceRegister(Plugin plugin, RegisterProcessor registerProcessor, LicenseClient licenseClient,
            CertMgmtService certMgmtService, @Value("${certMgmt.enable}") Boolean initCert) {
        this.plugin = notNull(plugin, "The plugin cannot be null.");
        this.registerProcessor = notNull(registerProcessor, "The register processor cannot be null.");
        this.licenseClient = notNull(licenseClient, "The license client cannot be null.");
        this.certMgmtService = certMgmtService;
        this.initCert = (initCert != null) && initCert;
    }

    @Override
    public void onRuntimeStarted(FitRuntime runtime) {
        this.registerLicense();
        this.registerRbac();
        if (this.initCert) {
            LOG.info("Start to initialize the cert.");
            this.certMgmtService.registerCertToOms();
        }
    }

    private void registerLicense() {
        this.licenseClient.registerProductInfo();
    }

    private void registerRbac() {
        ResourceResolver resourceResolver = this.plugin.resolverOfResources();
        this.registerProcessor.registerMenu(this.parseMenuInfo(resourceResolver,
                System.getenv("COMMUNITY") == null ? MENU_RESOURCE : COMMUNITY_MENU_RESOURCE));
        RoleRegisterVo roleRegisterVo = new RoleRegisterVo();
        roleRegisterVo.setRoleRegisterInfos(this.parseRoleInfo(resourceResolver,
                System.getenv("COMMUNITY") == null ? ROLE_RESOURCE : COMMUNITY_ROLE_RESOURCE));
        roleRegisterVo.setRoleI18nInfos(this.parseRoleI18nInfo(resourceResolver,
                System.getenv("COMMUNITY") == null ? ROLE_I18N_RESOURCE : COMMUNITY_ROLE_I18N_RESOURCE));
        this.registerProcessor.registerRole(Arrays.asList(roleRegisterVo));
        if (System.getenv("COMMUNITY") == null) {
            for (String metaName : AUTHORITY_RESOURCES) {
                this.registerProcessor.registerPermission(this.parseAuthorityInfo(resourceResolver, metaName));
            }
        } else {
            for (String metaName : COMMUNITY_AUTHORITY_RESOURCES) {
                this.registerProcessor.registerPermission(this.parseAuthorityInfo(resourceResolver, metaName));
            }
        }
    }

    private List<MenuRegisterInfo> parseMenuInfo(ResourceResolver resourceResolver, String metaName) {
        return cast(this.registerProcessor.parse(resolve(resourceResolver, metaName), MenuRegisterInfo.class));
    }

    private List<RoleRegisterInfo> parseRoleInfo(ResourceResolver resourceResolver, String metaName) {
        return cast(this.registerProcessor.parse(resolve(resourceResolver, metaName), RoleRegisterInfo.class));
    }

    private List<RoleI18nInfo> parseRoleI18nInfo(ResourceResolver resourceResolver, String metaName) {
        return cast(this.registerProcessor.parse(resolve(resourceResolver, metaName), RoleI18nInfo.class));
    }

    private List<AuthorityInfo> parseAuthorityInfo(ResourceResolver resourceResolver, String metaName) {
        return cast(this.registerProcessor.parse(resolve(resourceResolver, metaName), AuthorityInfo.class));
    }
}
