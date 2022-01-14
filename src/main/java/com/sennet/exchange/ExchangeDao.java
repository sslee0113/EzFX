package com.sennet.exchange;

import java.util.List;
import java.util.Map;


import org.apache.ibatis.session.SqlSession;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ExchangeDao{
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

	public List<ExchangeVo>  searchListExchange(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("searchListExchange", condition);
    }
	public ExchangeVo  findOneExchange(String refNo)
    {
       return  this.sqlSession.selectOne("findOneExchange", refNo);
    }
	public int saveExchange(ExchangeVo vo )
    {
       return  this.sqlSession.insert("saveExchange", vo);
    }
	public int getExchangeSeq()
    {
       return  this.sqlSession.selectOne("exchangeSeq");
    }
}
