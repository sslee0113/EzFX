package com.sennet.bizcommon.commoncode;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommonCodeDao{
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

	// 리스트조회
	public List<CommonCodeVo>  searchListCommonCode(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("searchListCommonCode", condition);
    }
	// Pk
	public CommonCodeVo  findOneCommonCode(String gcode )
    {
       return  this.sqlSession.selectOne("findOneCommonCode", gcode);
    }
	// 등록/수정/삭제
	public int  saveCommonCode(CommonCodeVo vo )
    {
       return  this.sqlSession.insert("saveCommonCode", vo);
    }
}	