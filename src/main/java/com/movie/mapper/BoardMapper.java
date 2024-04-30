package com.movie.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.movie.domain.Board;

// DAO
public interface BoardMapper {
	
	public List<Board> getList();						// 게시판 목록
	public void insert(Board board);				// 게시글 작성
	public Board read(Integer boardID);			// 게시글 보기
	public void increaseView(Integer boardID); 	// 게시글 조회수 1 증가
	public void increaseLike(Integer boardID); 	// 게시글 조회수 1 증가
	public void delete(Integer boardID);			// 게시글 삭제
	public void update(Board board);				// 게시글 수정
	
	// 게시물 총 개수
	public int count(); 
	// 게시물 총 개수 + 검색 적용
	public int searchCount(@Param("searchType") String searchType, 
			@Param("keyword") String keyword);
	
	// 게시판 목록 + 페이징 처리 + 검색 기능
	public List<Board> getListPage(@Param("displayPost") int displayPost, 
			@Param("postNum") int postNum,
			@Param("searchType") String searchType,
			@Param("keyword") String keyword);


}