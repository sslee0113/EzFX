package com.sennet.bizcommon.role;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDao{
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

	// 리스트조회
	public List<TrRoleVo>  searchListRole(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("searchListRole", condition);
    }
	// 등록/수정
	public int  saveRole(RoleVo vo )
    {
       return  this.sqlSession.insert("saveRole", vo);
    }
	// 삭제
	public int  deleteRole(String roleCd)
    {
       return  this.sqlSession.delete("deleteRole", roleCd);
    }
}	