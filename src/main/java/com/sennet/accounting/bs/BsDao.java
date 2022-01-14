package com.sennet.accounting.bs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BsDao {

	@Autowired
	private SqlSession sqlSession;
	  
    public List<BsResponseVo> searchListBs(BsVo bsVo){
	   return this.sqlSession.selectList("searchListBs", bsVo);
    }
	  
    public List<BsResponseVo> findLastBs(BsVo bsVo){
	   return this.sqlSession.selectList("findLastBs", bsVo);
    }
    public List<BsResponseSumVo> findBsSumList(BsVo bsVo){
	   return this.sqlSession.selectList("findBsSumList", bsVo);
    }
    
    public BsVo findOneBs(String actgTrDt, String brno, String acsjCd, String currCd){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("actgTrDt", actgTrDt);
		map.put("brno", brno);
		map.put("acsjCd", acsjCd);
		map.put("currCd", currCd);
	   return this.sqlSession.selectOne("findOneBs", map);
    }
    public int insertBs(BsVo bsVo){
	   return this.sqlSession.insert("insertBs", bsVo);
    }
}
