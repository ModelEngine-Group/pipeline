/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.permission;

import modelengine.fitframework.annotation.Property;

import java.util.ArrayList;
import java.util.List;

/**
 * 权限配置信息类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
public class AuthorityInfo {
    /**
     * 资源描述
     */
    @Property(name = "Description")
    private String description;

    /**
     * 资源唯一标识
     */
    @Property(name = "ResourceKey")
    private String resourceKey;

    /**
     * 是否跳过权限检查
     */
    @Property(name = "SkipCheck")
    private boolean skipCheck;

    /**
     * 所需角色
     */
    @Property(name = "Roles")
    private List<String> roles = new ArrayList<>();

    /**
     * 获取资源描述。
     *
     * @return 表示资源描述的 {@link String}。
     */
    public String getDescription() {
        return description;
    }

    /**
     * 设置资源描述。
     *
     * @param description 表示资源描述的 {@link String}。
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * 获取资源唯一标识。
     *
     * @return 表示资源唯一标识的 {@link String}。
     */
    public String getResourceKey() {
        return resourceKey;
    }

    /**
     * 设置资源唯一标识。
     *
     * @param resourceKey 表示资源唯一标识的 {@link String}。
     */
    public void setResourceKey(String resourceKey) {
        this.resourceKey = resourceKey;
    }

    /**
     * 获取是否跳过权限检查。
     *
     * @return 表示是否跳过权限检查的 {@code boolean}。
     */
    public boolean isSkipCheck() {
        return skipCheck;
    }

    /**
     * 设置是否跳过权限检查。
     *
     * @param skipCheck 表示是否跳过权限检查的 {@code boolean}。
     */
    public void setSkipCheck(boolean skipCheck) {
        this.skipCheck = skipCheck;
    }

    /**
     * 获取所需角色。
     *
     * @return 表示所需角色的 {@link List}{@code <}{@link String}{@code >}。
     */
    public List<String> getRoles() {
        return roles;
    }

    /**
     * 设置所需角色。
     *
     * @param roles 表示所需角色的 {@link List}{@code <}{@link String}{@code >}。
     */
    public void setRoles(List<String> roles) {
        this.roles = roles;
    }
}
