package com.sennet.bizcommon.commondcode;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDcodeDao{
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

	// 리스트조회
	public List<CommonDcodeVo>  searchListCommonDcode(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("searchListCommonDcode", condition);
    }
	// 상세조회
	public CommonDcodeVo findOneCommonDcode(Map<String,Object> condition )
    {
       return  this.sqlSession.selectOne("findOneCommonDcode", condition);
    }
	// 등록/수정
	public int  saveCommonDcode(CommonDcodeVo vo )
    {
       return  this.sqlSession.insert("saveCommonDcode", vo);
    }
	// 삭제
	public int  deleteCommonDcode(CommonDcodeVo vo )
    {
       return  this.sqlSession.delete("deleteCommonDcode", vo);
    }
}	