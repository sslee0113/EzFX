package com.sennet.bizcommon.customer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDao {
	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
	    this.sqlSession = sqlSession;
	}
	
	// 리스트조회
	public List<CustomerVo>  searchListCustomer(Map<String,Object> condition )
    {
       return  this.sqlSession.selectList("searchListCustomer", condition);
    }
	// Pk
	public CustomerVo  findOneCustomer(String cifNo)
    {
       return  this.sqlSession.selectOne("findOneCustomer", cifNo);
    }
	// 등록/수정/삭제
	public int saveCustomer(CustomerVo vo)
    {
       return  this.sqlSession.insert("saveCustomer", vo);
    }
}
