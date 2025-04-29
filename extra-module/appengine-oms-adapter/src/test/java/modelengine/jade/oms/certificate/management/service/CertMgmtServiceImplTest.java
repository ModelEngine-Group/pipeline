/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.service;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

import modelengine.fit.security.Decryptor;
import modelengine.fit.security.Encryptor;
import modelengine.fitframework.test.annotation.FitTestWithJunit;
import modelengine.fitframework.util.IoUtils;
import modelengine.jade.oms.certificate.management.feignclient.CertMgmtClient;
import modelengine.jade.oms.certificate.management.service.impl.CertMgmtServiceImpl;
import modelengine.jade.oms.certificate.management.utils.CertFileUtils;
import modelengine.jade.oms.entity.FileEntity;
import modelengine.jade.oms.response.ResultVo;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

import java.io.IOException;
import java.io.InputStream;

/**
 * CertMgmtServiceImpl 的测试用例。
 *
 * @author 邱晓霞
 * @since 2024-11-28
 */
@FitTestWithJunit
public class CertMgmtServiceImplTest {
    private CertMgmtServiceImpl certMgmtService;
    private InputStream inputStream;
    private MockedStatic<CertFileUtils> certFileUtilsMockedStatic;
    private MockedStatic<IoUtils> ioUtilsMockedStatic;

    private FileEntity certFileEntity;
    private FileEntity caCertFileEntity;
    private FileEntity privateKeyFileEntity;
    private CertMgmtClient certMgmtClient;
    private Encryptor encryptor;
    private Decryptor decryptor;

    @BeforeEach
    void setUp() {
        this.certMgmtClient = mock(CertMgmtClient.class);
        this.encryptor = mock(Encryptor.class);
        this.decryptor = mock(Decryptor.class);
        certMgmtService = new CertMgmtServiceImpl(this.encryptor, this.decryptor, certMgmtClient);
        inputStream = CertMgmtServiceImplTest.class.getResourceAsStream("/test.txt");
        certFileEntity = new FileEntity("global.crt", this.inputStream, 0);
        caCertFileEntity = new FileEntity("ca.crt", this.inputStream, 0);
        privateKeyFileEntity = new FileEntity("global.key", this.inputStream, 0);
        this.certFileUtilsMockedStatic = mockStatic(CertFileUtils.class);
        this.ioUtilsMockedStatic = mockStatic(IoUtils.class);
        this.certFileUtilsMockedStatic.when(() -> CertFileUtils.fileToFileEntity(eq("global.crt"), any()))
                .thenReturn(certFileEntity);
        this.certFileUtilsMockedStatic.when(() -> CertFileUtils.fileToFileEntity(eq("ca.crt"), any()))
                .thenReturn(caCertFileEntity);
        this.certFileUtilsMockedStatic.when(() -> CertFileUtils.fileToFileEntity(eq("global.key"), any()))
                .thenReturn(privateKeyFileEntity);
        this.certFileUtilsMockedStatic.when(() -> CertFileUtils.readFileToOneLineString("/certPersonal/global/identity/pwd"
                        + ".txt"))
                .thenReturn("psw");
        this.certFileUtilsMockedStatic.when(() -> IoUtils.content(CertMgmtServiceImpl.class.getClassLoader(),
                "/certPersonal/global/identity/pwd.txt")).thenReturn("psw");
        ResultVo<Boolean> isTypeRegSuccess = new ResultVo<>();
        isTypeRegSuccess.setData(true);
        isTypeRegSuccess.setCode("0");
        when(this.certMgmtClient.registerCertificateType(any())).thenReturn(isTypeRegSuccess);
    }

    @AfterEach
    void tearDown() throws IOException {
        this.certFileUtilsMockedStatic.close();
        this.ioUtilsMockedStatic.close();
        this.inputStream.close();
    }

    @Test
    @DisplayName("注册证书成功")
    void shouldOkWhenRegisterGlobalCertificate() {
        ResultVo<Boolean> isCertExist = new ResultVo<>();
        isCertExist.setData(false);
        isCertExist.setCode("0");
        when(this.certMgmtClient.checkCertIsExist(anyString())).thenReturn(isCertExist);
        this.certMgmtService.registerCertToOms();
        Mockito.verify(this.certMgmtClient, Mockito.times(1)).registerCertificateType(any());
        Mockito.verify(this.certMgmtClient, Mockito.times(1)).checkCertIsExist(anyString());
        Mockito.verify(this.certMgmtClient, Mockito.times(1)).importCertificateOm(any());
    }

    @Test
    @DisplayName("若注册证书已存在，则不需要再注册证书")
    void shouldReturnWhenCertificateIsExisted() {
        ResultVo<Boolean> isCertExist = new ResultVo<>();
        isCertExist.setData(true);
        isCertExist.setCode("0");
        when(this.certMgmtClient.checkCertIsExist(anyString())).thenReturn(isCertExist);
        this.certMgmtService.registerCertToOms();
        Mockito.verify(certMgmtClient, Mockito.times(0)).importCertificateOm(any());
    }
}