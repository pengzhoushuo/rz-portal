package com.xxx.portal.data.gen.dao;

import com.xxx.portal.data.gen.model.OrgInfo;
import com.xxx.portal.data.gen.model.OrgInfoExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

public interface OrgInfoMapper {
    int countByExample(OrgInfoExample example);

    int deleteByExample(OrgInfoExample example);

    int deleteByPrimaryKey(Long id);

    int insert(OrgInfo record);

    int insertSelective(OrgInfo record);

    List<OrgInfo> selectByExampleWithRowbounds(OrgInfoExample example, RowBounds rowBounds);

    List<OrgInfo> selectByExample(OrgInfoExample example);

    OrgInfo selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") OrgInfo record, @Param("example") OrgInfoExample example);

    int updateByExample(@Param("record") OrgInfo record, @Param("example") OrgInfoExample example);

    int updateByPrimaryKeySelective(OrgInfo record);

    int updateByPrimaryKey(OrgInfo record);
}