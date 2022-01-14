package com.sennet.bizcommon.zipcode;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ZipcodeDao {

	@Autowired
	private SqlSession sqlSession;
	  
	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}
	// page list 조회
	public List<ZipcodeVo> searchListZipcodePageable(Map<String,Object> condition )
    {
		return this.sqlSession.selectList("searchListZipcodePageable", condition);
    }
	// page list 조회
	public List<ZipcodeVo> searchListZipcodePopupPageable(Map<String,Object> condition )
	{
		return this.sqlSession.selectList("searchListZipcodePopupPageable", condition);
	}
	
}
