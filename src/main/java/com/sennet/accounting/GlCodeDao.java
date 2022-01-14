package com.sennet.accounting;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GlCodeDao{
	@Autowired
	private SqlSession sqlSession;
	  
    public GlCodeVo findOneGlCode(String acsjCd){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("acsjCd", acsjCd);
	    return this.sqlSession.selectOne("findOneGlCode", map);
    }
    public List<GlCodeVo> selectListGlCode(String acsjCd,String acsjNm){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("acsjCd", acsjCd);
		map.put("acsjNm", acsjNm);
	    return this.sqlSession.selectList("selectListGlCode", map);
    }
    public int saveGlCode(GlCodeVo GlCodeVo){
	   return this.sqlSession.insert("saveGlCode", GlCodeVo);
    }
}
