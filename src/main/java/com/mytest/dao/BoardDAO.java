package com.mytest.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mytest.vo.BoardVO;

@Repository
public class BoardDAO {
	@Autowired
	private SqlSession SqlSession;
	
	public List<BoardVO> getBoardList(int page) {
		return SqlSession.selectList("test.mappers.boardMapper.boardAll", page);
	}
	
	public BoardVO getBoardDetail(@Param(value = "boardId") int id) {
		return SqlSession.selectOne("test.mappers.boardMapper.boardDetail", id);
	}
	
	public int writeBoard(Map<String, Object> writeData) {
		return SqlSession.insert("test.mappers.boardMapper.boardWrite", writeData);
	}

	public int updateBoard(Map<String, Object> updateInfo) {
		return SqlSession.update("test.mappers.boardMapper.boardModify", updateInfo);
	}
	
	public int delteBoard(@Param(value = "boardId") int id) {
		return SqlSession.delete("test.mappers.boardMapper.boardDelete", id);
	}

	public int getAllBoardCnt() {
		return SqlSession.selectOne("test.mappers.boardMapper.boardCount");
		
	}
}
