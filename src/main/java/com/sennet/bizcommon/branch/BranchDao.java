package com.sennet.bizcommon.branch;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BranchDao {
	
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}
	
	// 리스트조회
	public List<BranchVo> searchListBranch(Map<String,Object> condition )
    {
       return this.sqlSession.selectList("searchListBranch", condition);
    }
	// Pk
	public BranchVo findOneBranch(String brno)
    {
       return this.sqlSession.selectOne("findOneBranch", brno);
    }
	// 등록/수정/삭제
	public int saveBranch(BranchVo vo)
    {
       return this.sqlSession.insert("saveBranch", vo);
    }
	
}
