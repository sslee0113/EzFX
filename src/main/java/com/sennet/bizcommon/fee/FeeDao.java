package com.sennet.bizcommon.fee;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FeeDao {
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}
	
	// 리스트조회
	public List<FeeVo> searchListFee(Map<String,Object> condition )
    {
       return this.sqlSession.selectList("searchListFee", condition);
    }
	public List<FeeVo> findByRmtKdcdAndNtcdAndCrcd(Map<String,Object> amtList)
	{
		return this.sqlSession.selectList("findByRmtKdcdAndNtcdAndCrcd", amtList);
	}
	public FeeVo findTop1ByOrderByFeeCdDesc(long feeCd)
    {
       return this.sqlSession.selectOne("findTop1ByOrderByFeeCdDesc", feeCd);
    }
	// Pk
	public FeeVo findOneFee(long feeCd)
    {
       return this.sqlSession.selectOne("findOneFee", feeCd);
    }
    public FeeVo getFeeForAmt(Map<String, Object> map){

	    return this.sqlSession.selectOne("getFeeForAmt", map);
    }
	// 등록/수정/삭제
	public int saveFee(FeeVo vo)
    {
       return this.sqlSession.insert("saveFee", vo);
    }
}

