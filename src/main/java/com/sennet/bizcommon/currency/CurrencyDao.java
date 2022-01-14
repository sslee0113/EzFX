package com.sennet.bizcommon.currency;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CurrencyDao {
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}
	
	// 리스트조회
	public List<CurrencyVo> searchListCurrency(Map<String,Object> condition )
    {
       return this.sqlSession.selectList("searchListCurrency", condition);
    }
	public List<CurrencyVo> currCodeList(Map<String,Object> condition )
    {
       return this.sqlSession.selectList("currCodeList", condition);
    }
	// Pk
	public CurrencyVo findOneCurrency(String currCode)
    {
       return this.sqlSession.selectOne("findOneCurrency", currCode);
    }
	// 등록/수정/삭제
	public int saveCurrency(CurrencyVo vo)
    {
       return this.sqlSession.insert("saveCurrency", vo);
    }
}
