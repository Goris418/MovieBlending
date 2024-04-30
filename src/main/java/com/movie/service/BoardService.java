package com.movie.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.domain.Board;
import com.movie.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardService {
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;

	public List<Board> getList() {
		log.info("getList.............");
		return mapper.getList(); // 목록 조회 성공
	}

	public int count() {
		return mapper.count(); // 게시물 총 개수
	}
	
	public int searchCount(String searchType, String keyword) {
		return mapper.searchCount(searchType, keyword);
	}

	public List<Board> getListPage(int displayPost, int postNum, String searchType, String keyword) {
		return mapper.getListPage(displayPost, postNum, searchType, keyword);
	}

	public void write(Board board) {
		log.info("write.... " + board.getBoardID());
		mapper.insert(board); // 글 작성 성공
	}

	public Board read(Integer boardID) {
		log.info("get.... " + boardID);
		return mapper.read(boardID); // 글 조회 성공
	}

	public void modify(Board board) {
		log.info("modify.... " + board);
		mapper.update(board); // 글 수정 성공
	}

	public void delete(Integer boardID) {
		log.info("remove.... " + boardID);
		mapper.delete(boardID); // 글 삭제 성공
	}

	public void increaseView(Integer boardID) {
		log.info("increaseView..." + boardID);
		mapper.increaseView(boardID);
	}

	public void increaseLike(Integer boardID) {
		log.info("increaseLike..." + boardID);
		mapper.increaseLike(boardID);
	}

	// 게시판 목록 + 검색
	/*
	 * public List<Board> listPageSearch(String searchType, String keyword) {
	 * 
	 * 
	 * 
	 * HashMap<String, Object> data = new HashMap<String, Object>();
	 * data.put("searchType", searchType); data.put("keyword", keyword);
	 * 
	 * 
	 * 
	 * return mapper.listPageSearch(searchType, keyword); }
	 */
}