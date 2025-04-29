/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.utils;

import modelengine.fitframework.log.Logger;
import modelengine.fitframework.util.StringUtils;
import modelengine.jade.oms.certificate.management.service.impl.CertMgmtServiceImpl;

import java.lang.reflect.Field;
import java.util.Arrays;

/**
 * 敏感信息清理工具类。
 *
 * @author 邱晓霞
 * @since 2024-11-28
 */
public class ClearSensitiveDataUtil {
    private static final Logger LOG = Logger.get(CertMgmtServiceImpl.class);

    private ClearSensitiveDataUtil() {
    }

    /**
     * 清理敏感信息。
     *
     * @param plainSensitiveDataStr 表示待处理字符串的 {@link String}。
     */
    public static void clearPlainSensitiveData(String plainSensitiveDataStr) {
        if (StringUtils.isBlank(plainSensitiveDataStr)) {
            return;
        }
        Class<? extends String> clazz = plainSensitiveDataStr.getClass();
        try {
            Field field = clazz.getDeclaredField("value");
            field.setAccessible(true);
            Object object = field.get(plainSensitiveDataStr);
            if (object instanceof char[]) {
                clearPlainSensitiveData((char[]) object);
                return;
            }
            if (object instanceof byte[]) {
                clearPlainSensitiveData((byte[]) object);
            }
        } catch (IllegalAccessException | NoSuchFieldException var5) {
            LOG.error("Failed to clear sensitive information.");
        }
    }

    /**
     * 清理带有敏感信息的字节数组。
     *
     * @param plainSensitiveDataByteArr 表示带有敏感信息的字节数组的 {@code byte[]}。
     */
    public static void clearPlainSensitiveData(byte[] plainSensitiveDataByteArr) {
        byte tmp = 0;
        Arrays.fill(plainSensitiveDataByteArr, tmp);
    }

    /**
     * 清理敏感信息。
     *
     * @param plainSensitiveDataCharArr 表示字符数组的 {@code char[]}。
     */
    public static void clearPlainSensitiveData(char[] plainSensitiveDataCharArr) {
        Arrays.fill(plainSensitiveDataCharArr, Character.MIN_VALUE);
    }
}
