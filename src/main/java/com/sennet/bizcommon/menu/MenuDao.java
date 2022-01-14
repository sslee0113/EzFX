package com.sennet.bizcommon.menu;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MenuDao{
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

	// 리스트조회
	public List<MenuVo>  searchListMenu(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("searchListMenu", condition);
    }
	// Pk
	public MenuVo  findOneMenu(String menuId )
    {
       return  this.sqlSession.selectOne("findOneMenu", menuId);
    }
	// 등록/수정
	public int  saveMenu(MenuVo vo )
    {
       return  this.sqlSession.insert("saveMenu", vo);
    }
	// 삭제
	public int  deleteMenu(String menuId)
    {
       return  this.sqlSession.delete("deleteMenu", menuId);
    }
}	