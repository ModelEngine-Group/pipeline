/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.role;

import modelengine.fitframework.annotation.Property;

/**
 * 角色配置信息类。
 *
 * @author 鲁为
 * @since 2024-11-18
 */
public class RoleRegisterInfo {
    /**
     * 角色名
     */
    @Property(name = "name")
    private String roleName;

    /**
     * 角色名国际化 code 代码
     */
    private String nameCode;

    /**
     * 角色描述国际化 code
     */
    private String description;

    /**
     * 是否可以创建此类用户 0 不支持 1 支持
     */
    private boolean creatable;

    /**
     * 角色支持创建的账户登录类型, 0-未定义 1-人机 2-机机 3-人机和机机 4-内部登录
     * （以二进制具体位是否为1代表支持某类型，比如001表示人机，010表示机机，100表示内部，011表示人机和机机）
     */
    private Integer supportLoginType;

    /**
     * 获取角色名。
     *
     * @return 表示角色名的 {@link String}。
     */
    public String getRoleName() {
        return roleName;
    }

    /**
     * 设置角色名。
     *
     * @param roleName 表示角色名的 {@link String}。
     */
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    /**
     * 获取角色名国际化 code 代码。
     *
     * @return 表示角色名国际化 code 代码的 {@link String}。
     */
    public String getNameCode() {
        return nameCode;
    }

    /**
     * 设置角色名国际化 code 代码。
     *
     * @param nameCode 表示角色名国际化 code 代码的 {@link String}。
     */
    public void setNameCode(String nameCode) {
        this.nameCode = nameCode;
    }

    /**
     * 获取角色描述国际化 code。
     *
     * @return 表示角色描述国际化 code 的 {@link String}。
     */
    public String getDescription() {
        return description;
    }

    /**
     * 设置角色描述国际化 code。
     *
     * @param description 表示角色描述国际化 code 的 {@link String}。
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * 获取是否可以创建此类用户。
     *
     * @return 表示是否可以创建此类用户的 {@code boolean}。
     */
    public boolean isCreatable() {
        return creatable;
    }

    /**
     * 设置是否可以创建此类用户。
     *
     * @param creatable 表示是否可以创建此类用户的 {@code boolean}。
     */
    public void setCreatable(boolean creatable) {
        this.creatable = creatable;
    }

    /**
     * 获取角色支持创建的账户登录类型。
     *
     * @return 表示角色支持创建的账户登录类型的 {@link Integer}。
     */
    public Integer getSupportLoginType() {
        return supportLoginType;
    }

    /**
     * 设置角色支持创建的账户登录类型。
     *
     * @param supportLoginType 表示角色支持创建的账户登录类型的 {@link Integer}。
     */
    public void setSupportLoginType(Integer supportLoginType) {
        this.supportLoginType = supportLoginType;
    }
}
