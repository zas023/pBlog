package com.copasso.blog.dao.custom;

import com.copasso.blog.model.vo.MenuCustom;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuMapperCustom {
    //获得菜单列表
    public List<MenuCustom> listMenu(@Param(value = "status") Integer status) throws Exception;
}
