package com.xxx.portal.data.gen.dao;

import com.xxx.portal.data.gen.model.RoleMenu;
import com.xxx.portal.data.gen.model.RoleMenuExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

public interface RoleMenuMapper {
    int countByExample(RoleMenuExample example);

    int deleteByExample(RoleMenuExample example);

    int deleteByPrimaryKey(Long id);

    int insert(RoleMenu record);

    int insertSelective(RoleMenu record);

    List<RoleMenu> selectByExampleWithRowbounds(RoleMenuExample example, RowBounds rowBounds);

    List<RoleMenu> selectByExample(RoleMenuExample example);

    RoleMenu selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") RoleMenu record, @Param("example") RoleMenuExample example);

    int updateByExample(@Param("record") RoleMenu record, @Param("example") RoleMenuExample example);

    int updateByPrimaryKeySelective(RoleMenu record);

    int updateByPrimaryKey(RoleMenu record);
}