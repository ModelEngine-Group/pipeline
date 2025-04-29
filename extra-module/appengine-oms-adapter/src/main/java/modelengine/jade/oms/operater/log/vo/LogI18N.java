/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.operater.log.vo;

/**
 * 表示操作日志国际化的实体。
 *
 * @author 易文渊
 * @since 2024-11-20
 */
public class LogI18N {
    private String code;
    private String language;
    private String content;

    public LogI18N(String code, String language, String content) {
        this.code = code;
        this.language = language;
        this.content = content;
    }

    /**
     * 获取操作日志语言。
     *
     * @return 表示操作日志语言的 {@link String}。
     */
    public String getLanguage() {
        return language;
    }
}