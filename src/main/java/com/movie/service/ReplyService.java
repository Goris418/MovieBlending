package com.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.domain.Board;
import com.movie.domain.BoardReply;
import com.movie.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReplyService {
	@Setter(onMethod_ = { @Autowired })
	private ReplyMapper mapper;
	
	public List<BoardReply> replyList(int boardID) {
		log.info("replyList.............");
		return mapper.replyList(boardID); // 댓글 조회 
	}
	
	public void write(BoardReply reply) {

		mapper.write(reply); // 댓글 작성
	}
	
	public void modify(BoardReply reply) {
	
		mapper.modify(reply); // 댓글 수정 
	}

	public void delete(BoardReply reply) {

		mapper.delete(reply); // 댓글 삭제 
	}


}
