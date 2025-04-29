/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.observer;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

import modelengine.fitframework.plugin.Plugin;
import modelengine.fitframework.resource.Resource;
import modelengine.fitframework.resource.ResourceResolver;
import modelengine.fitframework.runtime.FitRuntime;
import modelengine.fitframework.serialization.ObjectSerializer;
import modelengine.fitframework.util.TypeUtils;
import modelengine.jade.oms.OmsClient;
import modelengine.jade.oms.certificate.management.service.CertMgmtService;
import modelengine.jade.oms.license.manager.LicenseClient;
import modelengine.jade.oms.license.manager.support.DefaultLicenseClient;
import modelengine.jade.oms.service.access.meta.menu.MenuRegisterInfo;
import modelengine.jade.oms.service.access.meta.permission.AuthorityInfo;
import modelengine.jade.oms.service.access.meta.role.RoleI18nInfo;
import modelengine.jade.oms.service.access.meta.role.RoleRegisterInfo;
import modelengine.jade.oms.service.access.processor.RegisterProcessor;
import modelengine.jade.oms.service.access.processor.support.DefaultRegisterProcessor;
import modelengine.jade.oms.util.parser.JsonParser;
import modelengine.jade.oms.util.parser.support.DefaultJsonParser;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.Collections;
import java.util.List;

/**
 * {@link OmsServiceRegister} 的测试类
 *
 * @author 鲁为
 * @since 2024-11-19
 */
@DisplayName("测试 OmsServiceRegister")
@ExtendWith(MockitoExtension.class)
public class OmsServiceRegisterTest {
    @Mock
    private Resource resource;

    @Mock
    private ResourceResolver resourceResolver;

    @Mock
    private JsonParser jsonParser;

    @Mock
    private ObjectSerializer serializer;

    @Mock
    private RegisterProcessor registerProcessor;

    @Mock
    private LicenseClient licenseClient;

    @Mock
    private Plugin plugin;

    @Mock
    private FitRuntime runtime;

    @Mock
    private CertMgmtService certMgmtService;


    private OmsServiceRegister omsServiceRegister;

    @BeforeEach
    void setup() {
        OmsClient omsClient = mock(OmsClient.class);
        this.jsonParser = new DefaultJsonParser(this.serializer);
        this.registerProcessor = new DefaultRegisterProcessor(omsClient, this.jsonParser);
        this.licenseClient = new DefaultLicenseClient(this.plugin, omsClient, this.jsonParser);
        this.omsServiceRegister = new OmsServiceRegister(this.plugin, this.registerProcessor, this.licenseClient,
                this.certMgmtService, false);
        Mockito.when(this.plugin.resolverOfResources()).thenReturn(this.resourceResolver);
        Resource[] resources = new Resource[1];
        resources[0] = this.resource;
        try {
            Mockito.when(this.resourceResolver.resolve(anyString())).thenReturn(resources);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        Mockito.when(this.registerProcessor.parse(this.resource, MenuRegisterInfo.class))
                .thenReturn(Collections.emptyList());
        Mockito.when(this.registerProcessor.parse(this.resource, RoleRegisterInfo.class))
                .thenReturn(Collections.emptyList());
        Mockito.when(this.registerProcessor.parse(this.resource, RoleI18nInfo.class))
                .thenReturn(Collections.emptyList());
        Mockito.when(this.registerProcessor.parse(this.resource, AuthorityInfo.class))
                .thenReturn(Collections.emptyList());
    }

    @Test
    @DisplayName("测试插件启动时，注册成功。")
    void shouldSuccessWhenStartPlugin() throws IOException {
        this.omsServiceRegister.onRuntimeStarted(this.runtime);
        verify(this.serializer).deserialize(this.resource.read(),
                TypeUtils.parameterized(List.class, new Type[] {MenuRegisterInfo.class}));
    }
}
