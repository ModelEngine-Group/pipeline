/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.service.impl;

import modelengine.fit.http.entity.FileEntity;
import modelengine.fit.security.Decryptor;
import modelengine.fit.security.Encryptor;
import modelengine.fitframework.annotation.Component;
import modelengine.fitframework.log.Logger;
import modelengine.fitframework.validation.Validated;
import modelengine.jade.common.exception.ModelEngineException;
import modelengine.jade.oms.certificate.management.constants.Constant;
import modelengine.jade.oms.certificate.management.dto.CertTypeRegisterReq;
import modelengine.jade.oms.certificate.management.dto.CertUploadReq;
import modelengine.jade.oms.certificate.management.enums.CertCategoryEnum;
import modelengine.jade.oms.certificate.management.enums.CertEncType;
import modelengine.jade.oms.certificate.management.enums.CertRegisterMode;
import modelengine.jade.oms.certificate.management.enums.CertServiceNameEnum;
import modelengine.jade.oms.certificate.management.enums.CertTypeEnum;
import modelengine.jade.oms.certificate.management.feignclient.CertMgmtClient;
import modelengine.jade.oms.certificate.management.service.CertMgmtService;
import modelengine.jade.oms.certificate.management.utils.CertFileUtils;
import modelengine.jade.oms.certificate.management.utils.ClearSensitiveDataUtil;
import modelengine.jade.oms.code.OmsRetCode;
import modelengine.jade.oms.entity.NamedEntity;
import modelengine.jade.oms.entity.PartitionedEntity;
import modelengine.jade.oms.entity.TextEntity;
import modelengine.jade.oms.response.ResultVo;

import org.apache.commons.io.FileUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * 证书管理服务接口实现。
 *
 * @author 邱晓霞
 * @since 2024-11-27
 */
@Component
public class CertMgmtServiceImpl implements CertMgmtService {
    private static final Logger LOG = Logger.get(CertMgmtServiceImpl.class);
    private static final String CERTIFICATE_PATH = "/cert/internal/global/identity/global.crt";
    private static final String CA_CERTIFICATE_PATH = "/cert/internal/global/trust/ca.crt";
    private static final String CERTIFICATE_KEY_PATH = "/cert/internal/global/identity/global.key";
    private static final String PSW_PATH = "/cert/internal/global/identity/pwd.txt";
    private static final String CALLBACK_URL = "https://app-engine-builder/v1/cert-mgmt/update";
    private static final String CERT_CNF_SEPARATOR = "=";
    private static final String CERT_INTERNAL_PATH = "/cert/internal";
    private static final String CERT_ALIAS_PREFIX = "me_";
    private static final String OMS_CERT_ALIAS_SUFFIX = "_cert";

    private final Encryptor encryptor;
    private final Decryptor decryptor;
    private final CertMgmtClient certMgmtClient;

    public CertMgmtServiceImpl(Encryptor encryptor, Decryptor decryptor, CertMgmtClient certMgmtClient) {
        this.encryptor = encryptor;
        this.decryptor = decryptor;
        this.certMgmtClient = certMgmtClient;
    }

    @Override
    public Boolean registerCertificateType(String alias, CertEncType encType, CertRegisterMode certRegMode,
                                           String url) {
        LOG.info("start register {} cert.", alias);
        try {
            CertTypeRegisterReq registerReq = new CertTypeRegisterReq(alias,
                    encType.getCertEncType(),
                    certRegMode.getCertRegisterMode(),
                    CALLBACK_URL);
            ResultVo<Boolean> isTypeRegSuccess = this.certMgmtClient.registerCertificateType(registerReq);
            if (isTypeRegSuccess != null && Objects.equals(isTypeRegSuccess.getCode(), Constant.OMS_SUCCESS_CODE)) {
                LOG.info("success to register cert type {}", registerReq.getAlias());
                return true;
            }
            LOG.warn("Fail to register cert type {}", alias);
        } catch (Exception e) {
            LOG.error("Fail to register cert type {}", alias);
        }
        return false;
    }

    @Override
    public void uploadCertificateToOms(String alias, String certPath, String caCertPath, String privateKeyPath,
            String passwordPath) {
        List<NamedEntity> entityList = new ArrayList<>();
        try {
            entityList = generateNamedEntities(alias, certPath, caCertPath, privateKeyPath, passwordPath);
            ResultVo<Boolean> isUploadCertSuccess =
                    this.certMgmtClient.importCertificateOm(new PartitionedEntity(entityList));
            if (isUploadCertSuccess != null && Objects.equals(isUploadCertSuccess.getCode(),
                    Constant.OMS_SUCCESS_CODE)) {
                LOG.info("cert {} uploaded to oms", alias);
            } else {
                LOG.error("Failed to uploaded cert {} to oms", alias);
            }
        } catch (Exception e) {
            LOG.error("Failed to upload cert to OMS", e);
        } finally {
            entityList.forEach(namedEntity -> {
                try {
                    namedEntity.close();
                } catch (IOException e) {
                    LOG.error("Failed to close the input stream.", e);
                }
            });
        }
    }

    @Override
    public String updateCertificate(@Validated CertUploadReq certUploadReq) {
        try {
            updateCertInternalCert(certUploadReq);
        } finally {
            ClearSensitiveDataUtil.clearPlainSensitiveData(certUploadReq.getPassword());
        }
        return certUploadReq.getAlias();
    }

    /**
     * 在 OMS 注册证书。
     */
    public void registerCertToOms() {
        String globalCertAlias = CERT_ALIAS_PREFIX + CertServiceNameEnum.INTERNAL.getSubPath();
        if (!registerCertificateType(globalCertAlias, CertEncType.COMMON, CertRegisterMode.NEED_PWD, CALLBACK_URL)) {
            return;
        }
        if (!this.certMgmtClient.checkCertIsExist(globalCertAlias + OMS_CERT_ALIAS_SUFFIX).getData()) {
            uploadCertificateToOms(globalCertAlias,
                    CERTIFICATE_PATH,
                    CA_CERTIFICATE_PATH,
                    CERTIFICATE_KEY_PATH,
                    PSW_PATH);
        } else {
            LOG.info("{} cert already exist, skip upload.", globalCertAlias);
        }
    }

    private List<NamedEntity> generateNamedEntities(String alias, String certPath, String caCertPath,
            String privateKeyPath, String passwordPath) throws IOException {
        List<NamedEntity> namedEntities = new ArrayList<>();
        NamedEntity aliasEntity = new NamedEntity(Constant.ALIAS, new TextEntity(alias));
        NamedEntity certEntity = new NamedEntity(Constant.CERT, CertFileUtils.fileToFileEntity("global.crt", certPath));
        NamedEntity caCertEntity =
                new NamedEntity(Constant.CACERT, CertFileUtils.fileToFileEntity("ca.crt", caCertPath));
        NamedEntity privateKeyEntity =
                new NamedEntity(Constant.PRIVATE_KEY, CertFileUtils.fileToFileEntity("global.key", privateKeyPath));
        NamedEntity passwordEntity = new NamedEntity(Constant.PASSWORD,
                new TextEntity(this.decryptor.decrypt(CertFileUtils.readFileToOneLineString(passwordPath))));
        namedEntities.add(aliasEntity);
        namedEntities.add(certEntity);
        namedEntities.add(caCertEntity);
        namedEntities.add(privateKeyEntity);
        namedEntities.add(passwordEntity);
        return namedEntities;
    }

    private void updateCertInternalCert(CertUploadReq certUploadReq) {
        // 保存身份证书路径为/cert/internal/global/identity
        String identityTempPath = getTmpStorePath(CertCategoryEnum.IDENTITY);
        initTempDir(identityTempPath);
        saveCert(certUploadReq.getCert(),
                identityTempPath,
                CertServiceNameEnum.INTERNAL.getSubPath(),
                CertTypeEnum.CERT);
        LOG.info("global.crt saved");

        // global.key
        saveCert(certUploadReq.getPrivateKey(),
                identityTempPath,
                CertServiceNameEnum.INTERNAL.getSubPath(),
                CertTypeEnum.KEY);
        LOG.info("global.key saved");

        // 生成身份证书配置文件至临时目录
        // identity.cnf
        generateNewConfigFile(identityTempPath, certUploadReq);

        // 保存身份证书密码至临时目录
        CertFileUtils.saveStringToFile(encryptor.encrypt(certUploadReq.getPassword()), identityTempPath + "pwd.txt");

        // 保存信任 CA 证书路径为/cert/internal/global/trust
        String trustTempPath = getTmpStorePath(CertCategoryEnum.TRUST);
        initTempDir(trustTempPath);

        // ca.crt
        saveCert(certUploadReq.getCaCert(), trustTempPath, "ca", CertTypeEnum.CERT);
        LOG.info("ca.crt saved");

        // trust.cnf
        try {
            addTrustConfigFile(getTmpStorePath(CertCategoryEnum.TRUST), getRealStorePath(CertCategoryEnum.TRUST));
        } catch (IOException e) {
            throw new ModelEngineException(OmsRetCode.FAIL_TO_SAVE_TRUST_CONFIG_FILE, e);
        }

        // 用临时目录替换原目录
        CertFileUtils.renameDirAndFile(identityTempPath, getRealStorePath(CertCategoryEnum.IDENTITY));
        CertFileUtils.renameDirAndFile(trustTempPath, getRealStorePath(CertCategoryEnum.TRUST));
        LOG.info("internal cert update finished.");
    }

    private void saveCert(modelengine.fit.http.entity.FileEntity cert, String certPath, String filePrefix,
            CertTypeEnum certType) {
        String fileName = filePrefix + certType.getAllowedExtension().get(0);
        File certFile = new File(certPath + fileName);
        try (InputStream inputStream = cert.getInputStream()) {
            FileUtils.copyInputStreamToFile(inputStream, certFile);
            CertFileUtils.grantRwPermissionOnlyToOwner(certFile);
        } catch (FileNotFoundException e) {
            LOG.error("File not found. Failed to store cert");
            throw new ModelEngineException(OmsRetCode.FAIL_TO_SAVE_CERT, e);
        } catch (IOException e) {
            LOG.error("IO error. Failed to store cert");
            throw new ModelEngineException(OmsRetCode.FAIL_TO_SAVE_CERT, e);
        }
    }

    private void generateNewConfigFile(String path, CertUploadReq certUploadReq) {
        String configFile = path + CertCategoryEnum.IDENTITY.getConfigFileName();
        // 配置文件中需要记录证书保存完毕后的真实目录
        String configStr = getIdentityConfigLine(CertTypeEnum.CERT,
                certUploadReq.getCert(),
                getRealStorePath(CertCategoryEnum.IDENTITY)) + getIdentityConfigLine(CertTypeEnum.KEY,
                certUploadReq.getPrivateKey(),
                getRealStorePath(CertCategoryEnum.IDENTITY));
        CertFileUtils.saveStringToFile(configStr, configFile);
    }

    private static String getIdentityConfigLine(CertTypeEnum certType, FileEntity file, String realStorePath) {
        return certType.name() + CERT_CNF_SEPARATOR + realStorePath + file.filename() + System.lineSeparator();
    }

    private void addTrustConfigFile(String tempPath, String path) throws IOException {
        String configFile = tempPath + CertCategoryEnum.TRUST.getConfigFileName();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(configFile, true))) {
            writer.write(path + "ca.crt");
            writer.write(System.lineSeparator());
        }
    }

    private String getTmpStorePath(CertCategoryEnum categoryEnum) {
        return CERT_INTERNAL_PATH + File.separator + CertServiceNameEnum.INTERNAL.getSubPath() + File.separator
                + categoryEnum.getFolderName() + "_temp" + File.separator;
    }

    private String getRealStorePath(CertCategoryEnum categoryEnum) {
        return CERT_INTERNAL_PATH + File.separator + CertServiceNameEnum.INTERNAL.getSubPath() + File.separator
                + categoryEnum.getFolderName() + File.separator;
    }

    private void initTempDir(String path) {
        File tempDir = new File(path);
        if (tempDir.exists()) {
            CertFileUtils.removeDir(tempDir);
        }
        if (!tempDir.mkdirs()) {
            LOG.error("Failed to create dir.");
        }
    }
}