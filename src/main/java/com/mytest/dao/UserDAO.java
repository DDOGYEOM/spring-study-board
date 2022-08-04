package com.mytest.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mytest.vo.UserVO;

@Repository
public class UserDAO {

	@Autowired
	private SqlSession SqlSession;

	public int getTestValue() {
		return SqlSession.selectOne("test.mappers.testMapper.userCount");
	}
	
	public UserVO userLogin(String userId) {
		return SqlSession.selectOne("test.mappers.testMapper.userLogin", userId);
	}
	
	public int registUser(UserVO userInfo) {
		return SqlSession.insert("test.mappers.testMapper.userRegist", userInfo);
	}
	
}
