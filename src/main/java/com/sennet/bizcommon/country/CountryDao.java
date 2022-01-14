package com.sennet.bizcommon.country;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CountryDao {
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}
	
	// 리스트조회
	public List<CountryVo> searchListCountry(Map<String,Object> condition )
    {
       return this.sqlSession.selectList("searchListCountry", condition);
    }
	public List<CountryVo> ctryCodeList(Map<String,Object> condition )
    {
       return this.sqlSession.selectList("ctryCodeList", condition);
    }
	// Pk
	public CountryVo findOneCountry(String ctryCode)
    {
       return this.sqlSession.selectOne("findOneCountry", ctryCode);
    }
	// 등록/수정/삭제
	public int saveCountry(CountryVo vo)
    {
       return this.sqlSession.insert("saveCountry", vo);
    }
}
