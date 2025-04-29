/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.service.access.meta.menu;

import modelengine.fitframework.annotation.Property;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 角色名和场景 ID。
 *
 * @author 杭潇
 * @since 2023-12-14
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class RoleSceneInfo {
    /**
     * 菜单 ID。
     */
    private String menuId;

    /**
     * 角色名称。
     */
    private String roleName;

    /**
     * 场景 ID。
     * 订正 OMS 接口属性拼写错误。
     */
    @Property(name = "scenId")
    private String sceneId;
}
