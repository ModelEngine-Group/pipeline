/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.role;

import java.util.List;

/**
 * 角色 Vo 类。
 *
 * @author 鲁为
 * @since 2024-11-19
 */
public class RoleRegisterVo {
    /**
     * 角色信息
     */
    private List<RoleRegisterInfo> roleRegisterInfos;

    /**
     * 角色名称和描述的国际化信息列表
     */
    private List<RoleI18nInfo> roleI18nInfos;

    /**
     * 获取角色信息。
     *
     * @return 表示角色信息的 {@link List}{@code <}{@link RoleRegisterInfo}{@code >}。
     */
    public List<RoleRegisterInfo> getRoleRegisterInfos() {
        return roleRegisterInfos;
    }

    /**
     * 设置角色信息。
     *
     * @param roleRegisterInfos 表示角色信息的 {@link List}{@code <}{@link RoleRegisterInfo}{@code >}。
     */
    public void setRoleRegisterInfos(List<RoleRegisterInfo> roleRegisterInfos) {
        this.roleRegisterInfos = roleRegisterInfos;
    }

    /**
     * 获取角色名称和描述的国际化信息列表。
     *
     * @return 表示角色名称和描述的国际化信息列表的 {@link List}{@code <}{@link RoleI18nInfo}{@code >}。
     */
    public List<RoleI18nInfo> getRoleI18nInfos() {
        return roleI18nInfos;
    }

    /**
     * 设置角色名称和描述的国际化信息列表。
     *
     * @param roleI18nInfos 表示角色名称和描述的国际化信息列表的 {@link List}{@code <}{@link RoleI18nInfo}{@code >}。
     */
    public void setRoleI18nInfos(List<RoleI18nInfo> roleI18nInfos) {
        this.roleI18nInfos = roleI18nInfos;
    }
}
