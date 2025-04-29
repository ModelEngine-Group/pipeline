/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.role;

import modelengine.fitframework.annotation.Property;

/**
 * 角色国际化配置信息类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
public class RoleI18nInfo {
    /**
     * 角色名
     */
    @Property(name = "name")
    private String name;

    /**
     * 角色关键字
     */
    @Property(name = "code")
    private String code;

    /**
     * 语言
     */
    @Property(name = "language")
    private String language;

    /**
     * 角色的描述内容
     */
    @Property(name = "content")
    private String content;

    /**
     * 获取角色名。
     *
     * @return 表示角色名的 {@link String}。
     */
    public String getName() {
        return name;
    }

    /**
     * 设置角色名。
     *
     * @param name 表示角色名的 {@link String}。
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取角色关键字。
     *
     * @return 表示角色关键字的 {@link String}。
     */
    public String getCode() {
        return code;
    }

    /**
     * 设置角色关键字。
     *
     * @param code 表示角色关键字的 {@link String}。
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * 获取语言。
     *
     * @return 表示语言的 {@link String}。
     */
    public String getLanguage() {
        return language;
    }

    /**
     * 设置语言。
     *
     * @param language 表示语言的 {@link String}。
     */
    public void setLanguage(String language) {
        this.language = language;
    }

    /**
     * 获取角色的描述内容。
     *
     * @return 表示角色的描述内容的 {@link String}。
     */
    public String getContent() {
        return content;
    }

    /**
     * 设置角色的描述内容。
     *
     * @param content 表示角色的描述内容的 {@link String}。
     */
    public void setContent(String content) {
        this.content = content;
    }
}
