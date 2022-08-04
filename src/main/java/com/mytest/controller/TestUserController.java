package com.mytest.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.mytest.service.BoardService;
import com.mytest.service.UserService;
import com.mytest.vo.UserVO;

@Controller
@RequestMapping("/user")
public class TestUserController {
	@Autowired
	UserService userService;
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String goLoginPage(HttpServletRequest req) {
		if(req.getSession().getAttribute("loginUserInfo") != null) {
			return "redirect:/board";
		}else {
			return "user_login";
		}
		
		
	}
	
	@ResponseBody
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String userLogin(@RequestParam Map<String, Object> params, HttpServletRequest req, Model model) {
		Gson gson = new Gson();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		UserVO loginUser = userService.userLogin(params.get("userId").toString());
		Map<String, Object> res = new HashMap<String, Object>();
		
		if(loginUser != null) {
			if(encoder.matches(params.get("password").toString(), loginUser.getPassword())) {
				req.getSession().setAttribute("loginUserInfo", loginUser);
				res.put("loginUserInfo", loginUser);
			}
		}
		
		return gson.toJson(res);
	}
	
	
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(Model model, HttpServletRequest req) {
		if(req.getSession().getAttribute("loginUserInfo") != null) {
			req.getSession().removeAttribute("loginUserInfo");
			return  "redirect:" + req.getHeader("Referer");
		}else {
			model.addAttribute("msg", "로그인 상태가 아닙니다.");
			model.addAttribute("url", "/user/login");
			return "alert";
		}
		
		
	}
	
	
	@RequestMapping(value="/regist", method = RequestMethod.GET)
	public String goRegistPage() {
		return "user_regist";
	}
	
	@ResponseBody
	@RequestMapping(value="/regist", method = RequestMethod.POST)
	public String userRegist(@RequestParam Map<String, Object> params) {
		Gson gson = new Gson();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePassword = encoder.encode(params.get("password").toString());
		UserVO registUser = new UserVO();
		
		registUser.setUserId(params.get("userId").toString());
		registUser.setPassword(securePassword);
		registUser.setName(params.get("name").toString());
		registUser.setAge(Integer.parseInt(params.get("age").toString()));
		registUser.setPhone(params.get("phone").toString());
		registUser.setAddress(params.get("address").toString());
		registUser.setEmail(params.get("email").toString());
		
		userService.registUser(registUser);
		
		return gson.toJson(params);
	}
	
	
}
