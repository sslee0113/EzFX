package com.sennet.webaccesslog;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WebAccessLogDao{
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

	public int insertWebAccessLog(WebAccessLogVo vo )
    {
       return  this.sqlSession.insert("insertWebAccessLog", vo);
    }
}
