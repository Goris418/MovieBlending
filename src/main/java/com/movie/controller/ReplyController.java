package com.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.movie.domain.BoardReply;
import com.movie.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor //
@RequestMapping("/reply/*")
public class ReplyController {
	private ReplyService service;
	
	// 댓글 조회 -> BoardController에 위치
	
	// 댓글 작성
	@PostMapping("/write")
		public String write(BoardReply reply) {
			service.write(reply);
			
			return "redirect:/board/read?boardID=" + reply.getBoardID();
	}
	
	// 댓글 삭제
	@GetMapping("/delete")
	public String remove(BoardReply reply) {
		
		service.delete(reply);
		return "redirect:/board/read?boardID=" + reply.getBoardID();
	}
	
	
	
	// 댓글 수정
	
}
