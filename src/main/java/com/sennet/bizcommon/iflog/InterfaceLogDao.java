package com.sennet.bizcommon.iflog;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Repository;

@Repository
public class InterfaceLogDao{
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

	// 리스트조회
	public List<InterfaceLogVo>  searchListZipcodePageable(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("searchListInterfaceLogPageable", condition);
    }
	// Pk
	public InterfaceLogVo  findOneInterfaceLog( Map<String,Object> condition)
    {
       return  this.sqlSession.selectOne("findOneInterfaceLog", condition);
    }
	// 등록/수정/삭제
	public int  saveInterfaceLog(InterfaceLogVo interfaceLogVo )
    {
       return  this.sqlSession.insert("saveInterfaceLog", interfaceLogVo);
    }
}	