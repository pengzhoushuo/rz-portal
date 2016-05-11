package com.xxx.portal.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;

import com.xxx.portal.webframework.domain.PageResponse;

@Component
public class MyBatisDao extends SqlSessionTemplate{
	
	@Autowired
	public MyBatisDao(SqlSessionFactory sqlSessionFactory) {
		super(sqlSessionFactory);
	}
  
	public <T> List<T> select(String statement,Object object,Class<T> c){
		return	selectList(statement, object);
	}
	
	public Integer count(String statement, Object parameter){
		return super.selectOne(statement, parameter);
	}
	
	public <T> PageResponse<T> selectPage(String dataSqlStatement,String countSqlStatement,PageRequest pageRequest,Map<String,Object>parameter,Class<T> c){
		int offset=(pageRequest.getPageNumber()-1)*pageRequest.getPageSize();
		int limit=pageRequest.getPageSize();
		Integer total=selectOne(countSqlStatement,parameter);
		Map<String,Object> parameters = new HashMap<String,Object>();
	    if(parameter!=null){
		     parameters.putAll(parameter);	
		}
		parameters.put("offset", offset);
		parameters.put("limit", limit);
		List<T> rows = selectList(dataSqlStatement, parameters);
		PageResponse<T> result=new PageResponse<T>();
		result.setTotal(total);
		result.setCurrent(pageRequest.getPageNumber());
		result.setRowCount(limit);
		result.setRows(rows);
		return result;
	}
}
