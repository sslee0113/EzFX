package com.sennet.bizcommon.frgnexchrate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sennet.accounting.GlDetailVo;

@Repository
public class FrgnExchRateDao {
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}
	
	// 리스트조회
	public List<FrgnExchRateVo> searchListFrgnExchRate(Map<String,Object> condition )
    {
       return this.sqlSession.selectList("searchListFrgnExchRate", condition);
    }
	// Pk
	public FrgnExchRateVo findOneFrgnExchRate(FrgnExchRateVo paramVo)
    {
       return this.sqlSession.selectOne("findOneFrgnExchRate", paramVo);
    }
	
	public FrgnExchRateVo readMaxFrgnExchRateVo(Map<String,Object> map)
    {
       return this.sqlSession.selectOne("readMaxFrgnExchRateVo", map);
    }
    public int getNextSeqFrgnExchRate(String valDate)
    {
       return this.sqlSession.selectOne("getNextSeqFrgnExchRate", valDate);
    }
    
    public FrgnExchRateVo findTop1ByValDateAndCurrCode(Map<String, Object> map){
	    return this.sqlSession.selectOne("findTop1ByValDateAndCurrCode", map);
    }
	
	// 등록/수정/삭제
	public int saveFrgnExchRate(FrgnExchRateVo vo)
    {
       return this.sqlSession.insert("saveFrgnExchRate", vo);
    }
}