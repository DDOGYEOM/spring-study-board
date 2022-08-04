package com.mytest.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mytest.dao.BoardDAO;
import com.mytest.vo.BoardVO;

@Repository
public class BoardService {
	@Autowired
	BoardDAO boardDAO;
	
	public int getAllBoardCnt() {
		return boardDAO.getAllBoardCnt();
	}
	
	public List<BoardVO> getBoardList(int page) {
		return boardDAO.getBoardList(page);
	}
	
	public BoardVO getBoardDetail(int id) {
		return boardDAO.getBoardDetail(id);
	}
	
	public void writeBoard(Map<String, Object> writeInfo, String userName, String userId) {
		Map<String,Object> writeData = new HashMap<String, Object>();
		writeData.put("writeInfo", writeInfo);
		writeData.put("userName", userName);
		writeData.put("userId", userId);
		boardDAO.writeBoard(writeData);
	}
	
	public void updateBoard(Map<String, Object> updateInfo) {
		boardDAO.updateBoard(updateInfo);
	}
	
	public void delteBoard(@Param(value = "boardId") int id) {
		 boardDAO.delteBoard(id);
	}
}
