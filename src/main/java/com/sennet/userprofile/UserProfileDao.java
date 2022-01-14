package com.sennet.userprofile;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserProfileDao{
	@Autowired
	private SqlSession sqlSession;
	  
    public UserProfileVo findOneUserProfile(String userName){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userName", userName);
	    return this.sqlSession.selectOne("findOneUserProfile", map);
    }
    public UserProfileVo findOneUserProfile(Long accountSeq){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("accountSeq", accountSeq);
	    return this.sqlSession.selectOne("findOneUserProfile", map);
    }
    public List<UserProfileVo> searchListUserProfile(String userName,String role){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userName", userName);
		map.put("role", role);
	    return this.sqlSession.selectList("searchListUserProfile", map);
    }
    public int saveUserProfile(UserProfileVo vo){
	   return this.sqlSession.insert("saveUserProfile", vo);
    }
    public int updateBadCount(UserProfileVo vo){
	   return this.sqlSession.update("updateBadCount", vo);
    }
    public int getNextSeq(){
	   return this.sqlSession.selectOne("getNextSeq");
    }
    public int deleteUserProfile(Long accountSeq){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("accountSeq", accountSeq);
	    return this.sqlSession.delete("deleteUserProfile", map);
    }
}
