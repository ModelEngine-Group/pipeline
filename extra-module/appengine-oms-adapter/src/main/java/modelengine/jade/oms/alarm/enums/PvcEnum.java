/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.alarm.enums;

import lombok.Getter;

import java.util.Arrays;

/**
 * PVC 名称和阈值枚举。
 *
 * @author 何嘉斌
 * @since 2024-12-06
 */
@Getter
public enum PvcEnum {
    RUNTIME_PVC("/var/store/tools", "app-builder-runtime-pvc", "0x03000101", 85),
    LOG_APP_PVC("/log-app", "log-app-pvc", "0x03000102", 80),
    DB_PVC("/var/jade-db", "new-jade-db-pvc", "0x03000103", 80),
    INVALID_PVC("invalid", "invalid", "invalid", null);

    private final String path;
    private final String name;
    private final String id;
    private final Integer threshold;

    PvcEnum(String path, String name, String id, Integer threshold) {
        this.path = path;
        this.name = name;
        this.id = id;
        this.threshold = threshold;
    }

    /**
     * 通过挂载路径获取对应的枚举值。
     *
     * @param path 表示 pvc 挂载路径的 {@link String}。
     * @return 表示对应的枚举 {@link PvcEnum}。
     */
    public static PvcEnum getByPath(String path) {
        return Arrays.stream(values())
                .filter(value -> value.getPath().equals(path))
                .findFirst()
                .orElse(INVALID_PVC);
    }
}