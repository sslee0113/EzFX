package com.sennet.remittance;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RemittanceDao{
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

	public List<RemittanceVo>  searchListRemittance(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("searchListRemittance", condition);
    }
	public RemittanceVo  findOneRemittance(String refNo)
    {
       return  this.sqlSession.selectOne("findOneRemittance", refNo);
    }
	public int saveRemittance(RemittanceVo vo )
    {
       return  this.sqlSession.insert("saveRemittance", vo);
    }
	
	public int getRemittanceSeq()
    {
       return  this.sqlSession.selectOne("getRemittanceSeq");
    }
	public List<RemittanceTotalVo>  getRemittanceTotal(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("getRemittanceTotal", condition);
    }
}
