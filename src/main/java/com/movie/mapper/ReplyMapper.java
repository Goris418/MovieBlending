package com.movie.mapper;
import java.util.List;

import com.movie.domain.BoardReply;

// DAO
public interface ReplyMapper {
	// 댓글 조회
	public List<BoardReply> replyList(int boardID);

	// 댓글 작성
	public void write(BoardReply reply);

	// 댓글 수정
	public void modify(BoardReply reply);

	// 댓글 삭제
	public void delete(BoardReply reply);
}
