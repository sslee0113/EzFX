package com.sennet.accounting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GlMasterDao {

	@Autowired
	private SqlSession sqlSession;
	  
    public List<GlMasterVo> searchListGlMaster(String startDate,String endDate, String refNo ){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("refNo", refNo);
	    return this.sqlSession.selectList("searchListGlMaster", map);
    }
    public GlMasterVo findOneGlMaster(String actgTrDt,long actgTrSrno ){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("actgTrDt", actgTrDt);
		map.put("actgTrSrno", actgTrSrno);
	    return this.sqlSession.selectOne("findOneGlMaster", map);
    }
    public GlMasterVo findOneRefNoAndStatTcd(String refNo,String statTcd ){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("refNo", refNo);
		map.put("statTcd", statTcd);
	    return this.sqlSession.selectOne("findOneRefNoAndStatTcd", map);
    }
    public int saveGlMaster(GlMasterVo glMasterVo){
	   return this.sqlSession.insert("saveGlMaster", glMasterVo);
    }
    public GlMasterVo findTop1ByActgTrDtOrderByActgTrSrnoDesc(String actgTrDt){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("actgTrDt", actgTrDt);
	    return this.sqlSession.selectOne("findTop1ByActgTrDtOrderByActgTrSrnoDesc", map);
    }
}
