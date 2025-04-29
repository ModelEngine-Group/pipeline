/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.menu;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 表示菜单信息。
 *
 * @author 杭潇
 * @since 2024-11-09
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MenuInfo {
    /**
     * ID
     */
    private int id;

    /**
     * 菜单 ID
     */
    private String menuId;

    /**
     * 父菜单 ID
     */
    private String parentMenuId;

    /**
     * 菜单名称
     */
    private String menuName;

    /**
     * 菜单地址
     */
    private String url;

    /**
     * 菜单图标地址
     */
    private String icon;

    /**
     * 菜单英文国际化
     */
    private String en;

    /**
     * 菜单中文国际化
     */
    private String zh;

    /**
     * 使能
     */
    private boolean enable;
}
