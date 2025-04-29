/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.processor;

import modelengine.fitframework.resource.Resource;
import modelengine.jade.oms.service.access.meta.menu.MenuRegisterInfo;
import modelengine.jade.oms.service.access.meta.permission.AuthorityInfo;
import modelengine.jade.oms.service.access.meta.role.RoleRegisterVo;

import java.util.List;

/**
 * rbac 注册处理器。
 *
 * @author 鲁为
 * @since 2024-11-18
 */
public interface RegisterProcessor {
    /**
     * 配置文件解析为对应元数据列表。
     *
     * @param resource 表示配置文件资源的 {@link Resource}。
     * @param meta 表示元数据类的 {@link Class}{@code <}{@link T}{@code >}。
     * @return 类型转换后的元数据列表的 {@link List}{@code <}{@link T}{@code >}。
     */
    <T> List<T> parse(Resource resource, Class<T> meta);

    /**
     * 菜单注册。
     *
     * @param metaList 表示待注册的菜单元数据列表的 {@link List}{@code <}{@link MenuRegisterInfo}{@code >}。
     */
    void registerMenu(List<MenuRegisterInfo> metaList);

    /**
     * 角色注册。
     *
     * @param metaList 表示待注册的角色元数据列表的 {@link List}{@code <}{@link RoleRegisterVo}{@code >}。
     */
    void registerRole(List<RoleRegisterVo> metaList);

    /**
     * 权限注册。
     *
     * @param metaList 表示待注册的权限元数据列表的 {@link List}{@code <}{@link AuthorityInfo}{@code >}。
     */
    void registerPermission(List<AuthorityInfo> metaList);
}
