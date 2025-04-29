/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.menu;

import modelengine.fitframework.annotation.Property;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 菜单配置信息。
 *
 * @author 杭潇
 * @since 2024-11-09
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MenuRegisterInfo {
    /**
     * 菜单 ID
     */
    private String menuId;

    /**
     * 父菜单 ID
     */
    private String parentMenuId;

    /**
     * 菜单名
     */
    @Property(name = "menuName")
    private String menuNameCode;

    /**
     * 菜单对应的 URL
     */
    private String url;

    /**
     * 菜单对应的图标 URL
     */
    private String iconUrl;

    /**
     * 英文国际化
     */
    private String en;

    /**
     * 中文国际化
     */
    private String zh;

    /**
     * 是否显示
     */
    private boolean enable;

    /**
     * 角色场景列表
     */
    @Property(name = "roleScenMap")
    private List<RoleSceneInfo> roleSceneMap;

    /**
     * 菜单排序，同一个父级菜单下的子菜单 weight 值越大越在后面。
     */
    private int weight;
}
