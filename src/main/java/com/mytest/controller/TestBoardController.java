package com.mytest.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.mytest.pagination.Pagination;
import com.mytest.service.BoardService;
import com.mytest.vo.BoardVO;
import com.mytest.vo.UserVO;

@Controller
@RequestMapping("/board")
public class TestBoardController {
	
	@Autowired
	BoardService boardService;
	Boolean isPgnInit = false;
	BoardVO boardDetail = new BoardVO();

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String goBoardPage(Model model, @RequestParam(defaultValue = "1") int page) {
		int totalBoardCnt = boardService.getAllBoardCnt();

		Pagination pagination = new Pagination(totalBoardCnt, page);
		System.out.println(pagination.toString());

		List<BoardVO> boardList = boardService.getBoardList(pagination.getStartIndex());

		model.addAttribute("boardList", boardList);
		model.addAttribute("pagination", pagination);
		return "board";
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String goBoardDetail(Model model, HttpServletRequest request) {
		boardDetail = boardService.getBoardDetail(Integer.parseInt(request.getParameter("id")));
		if (request.getSession().getAttribute("loginUserInfo") != null) {
			String loginUserId = ((UserVO)request.getSession().getAttribute("loginUserInfo")).getUserId();
			model.addAttribute("loginUserId", loginUserId);
		}
		model.addAttribute("boardDetail", boardDetail);
		model.addAttribute("newLine", "\n");
		return "board_detail";
	}

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String goBoardModify(Model model, HttpServletRequest request) {
		if (request.getSession().getAttribute("loginUserInfo") != null) {
			if (request.getParameter("id") != null) {
				String loginUserId = ((UserVO)request.getSession().getAttribute("loginUserInfo")).getUserId();
				model.addAttribute("loginUserId", loginUserId);
				model.addAttribute("boardDetail", boardDetail);
			} else {
				boardDetail = null;
				model.addAttribute("boardDetail", boardDetail);
			}
			return "board_write";
		} else {
			model.addAttribute("msg", "로그인 후 이용가능합니다!");
			model.addAttribute("url", "/user/login");
			return "alert";
		}

	}

	@ResponseBody
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String boardWrite(@RequestParam Map<String, Object> params, HttpServletRequest request) {
		Gson gson = new Gson();
		System.out.println(request.getSession().getAttribute("loginUserInfo"));
		
		UserVO test = (UserVO)request.getSession().getAttribute("loginUserInfo");
		boardService.writeBoard(params, test.getName(), test.getUserId());
		return gson.toJson(params);
	}

	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String boardUpdate(@RequestParam Map<String, Object> params) {
		Gson gson = new Gson();
		boardService.updateBoard(params);
		return gson.toJson(params);
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String boardDelete(HttpServletRequest request) {
		boardService.delteBoard(Integer.parseInt(request.getParameter("id")));
		return "redirect:/board";
	}
}
