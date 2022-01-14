package com.sennet.accounting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GlDetailDao {

	@Autowired
	private SqlSession sqlSession;
	  
    public GlDetailVo findOneGlDetail(String actgTrDt,long actgTrSrno,long actgTrSubSrno ){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("actgTrDt", actgTrDt);
		map.put("actgTrSrno", actgTrSrno);
		map.put("actgTrSubSrno", actgTrSubSrno);
	    return this.sqlSession.selectOne("findOneGlDetail", map);
    }
    public List<GlDetailVo> findByActgTrDtAndActgTrSrnoOrderByActgTrSubSrnoAsc(String actgTrDt,long actgTrSrno){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("actgTrDt", actgTrDt);
		map.put("actgTrSrno", actgTrSrno);
	    return this.sqlSession.selectList("findByActgTrDtAndActgTrSrnoOrderByActgTrSubSrnoAsc", map);
    }
    public int saveGlDetail(GlDetailVo GlDetailVo){
	   return this.sqlSession.insert("saveGlDetail", GlDetailVo);
    }
}
