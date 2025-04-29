/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.dto;

import modelengine.fit.http.entity.FileEntity;
import modelengine.fit.http.entity.NamedEntity;
import modelengine.fit.http.entity.PartitionedEntity;
import modelengine.fitframework.log.Logger;

import modelengine.jade.common.exception.ModelEngineException;
import modelengine.jade.oms.certificate.management.constants.Constant;
import modelengine.jade.oms.certificate.management.convertor.NamedEntityToRequestParamConvertor;
import modelengine.jade.oms.code.OmsRetCode;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.apache.commons.io.FilenameUtils;

import java.util.HashMap;

/**
 * 证书上传请求体。
 *
 * @author 邱晓霞
 * @since 2024-11-27
 */
@Getter
@Setter
@NoArgsConstructor
public class CertUploadReq {
    /**
     * 将 PartitionedEntity 转换成 CertUploadReq 的转换器集合。
     */
    public static final HashMap<String, NamedEntityToRequestParamConvertor> CONVERTOR_MAP = new HashMap<>(8);

    private static final Logger LOG = Logger.get(CertUploadReq.class);

    static {
        CONVERTOR_MAP.put(Constant.ALIAS, ConvertorEnum.CONVERT_TO_ALIAS.getConvertor());
        CONVERTOR_MAP.put(Constant.CERT, ConvertorEnum.CONVERT_TO_CERT.getConvertor());
        CONVERTOR_MAP.put(Constant.CACERT, ConvertorEnum.CONVERT_TO_CA_CERT.getConvertor());
        CONVERTOR_MAP.put(Constant.PRIVATE_KEY, ConvertorEnum.CONVERT_TO_PRIVATE_KEY.getConvertor());
        CONVERTOR_MAP.put(Constant.PASSWORD, ConvertorEnum.CONVERT_TO_PASSWORD.getConvertor());
    }

    /**
     * 证书别名。
     */
    private String alias;

    /**
     * 国际/国密签名证书、服务端证书三合一; 签名证书。
     */
    private FileEntity cert;

    /**
     * 签名 ca 证书。
     */
    private FileEntity caCert;

    /**
     * 签名证书私钥。
     */
    private FileEntity privateKey;

    /**
     * 私钥密码。
     */
    private String password;

    /**
     * 请求参数转换器。
     */
    @AllArgsConstructor
    @Getter
    enum ConvertorEnum {
        CONVERT_TO_ALIAS((requestParam, namedEntity) -> requestParam.setAlias(namedEntity.asText().content())),
        CONVERT_TO_CERT((requestParam, namedEntity) -> {
            FileEntity fileEntity = namedEntity.asFile();
            validateExtension(fileEntity.filename(), Constant.CERT_EXTENSION);
            requestParam.setCert(fileEntity);
        }),
        CONVERT_TO_CA_CERT((requestParam, namedEntity) -> {
            FileEntity fileEntity = namedEntity.asFile();
            validateExtension(fileEntity.filename(), Constant.CERT_EXTENSION);
            requestParam.setCaCert(fileEntity);
        }),
        CONVERT_TO_PRIVATE_KEY((requestParam, namedEntity) -> {
            FileEntity fileEntity = namedEntity.asFile();
            validateExtension(fileEntity.filename(), Constant.PRIVATE_KEY_EXTENSION);
            requestParam.setPrivateKey(fileEntity);
        }),
        CONVERT_TO_PASSWORD((requestParam, namedEntity) -> requestParam.setPassword(namedEntity.asText().content()));

        /**
         * 对应类型证书保存的子目录名。
         */
        private final NamedEntityToRequestParamConvertor convertor;
    }

    /**
     * 将 partitionedEntity 转换为 CertUploadReq。
     *
     * @param partitionedEntity 表示分块的消息体数据的 {@link PartitionedEntity}。
     * @return 表示证书上传请求参数的 {@link CertUploadReq}。
     */
    public static CertUploadReq convert(PartitionedEntity partitionedEntity) {
        CertUploadReq certUploadReq = new CertUploadReq();
        for (NamedEntity namedEntity : partitionedEntity.entities()) {
            if (CONVERTOR_MAP.containsKey(namedEntity.name())) {
                CONVERTOR_MAP.get(namedEntity.name()).convert(certUploadReq, namedEntity);
            }
        }
        return certUploadReq;
    }

    /**
     * 校验文件扩展名。
     *
     * @param filename 表示文件名的 {@link String}。
     * @param validExtension 表示预期的文件扩展名的 {@link String}。
     */
    public static void validateExtension(String filename, String validExtension) {
        String extension = FilenameUtils.getExtension(filename);
        if (!validExtension.equals(extension)) {
            LOG.error("Unsupported file extension {}", extension);
            throw new ModelEngineException(OmsRetCode.UNSUPPORTED_FILE_TYPE);
        }
    }
}
