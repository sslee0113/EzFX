package com.sennet.bizcommon.frgnexchratenotice;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FrgnExchRateNoticeDao {

	@Autowired
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}

    public List<FrgnExchRateNoticeVo> findByValDateOrderByCurrCodeAsc(FrgnExchRateNoticeVo paramVo) {
    	return this.sqlSession.selectList("findByValDateOrderByCurrCodeAsc", paramVo);
    }
    
}
