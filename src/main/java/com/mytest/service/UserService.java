package com.mytest.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mytest.dao.UserDAO;
import com.mytest.vo.UserVO;

@Repository
public class UserService {
	@Autowired
	UserDAO userDAO;

	public int getTestValue() {
		return userDAO.getTestValue();
	}

	public int registUser(UserVO userInfo) {
		return userDAO.registUser(userInfo);
	}

	public UserVO userLogin(String userId) {
		UserVO loginUser = userDAO.userLogin(userId);

		return loginUser;

	}
}
