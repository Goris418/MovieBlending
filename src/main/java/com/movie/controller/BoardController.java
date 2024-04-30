package com.movie.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.movie.domain.Board;
import com.movie.domain.BoardReply;
import com.movie.domain.Page;
import com.movie.service.BoardService;
import com.movie.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor //
@RequestMapping("/board/*")
public class BoardController {
	private BoardService service;
	private ReplyService replyService;

	// 게시글 목록 조회
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("bList", service.getList());
	}

	// 게시글 목록 + 페이징 추가 + 검색
	@GetMapping("/listPage") 
	public void getListPage(Model model, @RequestParam(value="num") int num,
			@RequestParam(value = "searchType", required = false, defaultValue = "title") String searchType, 
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) { 
		
		Page page = new Page();
		
		page.setNum(num);
		//page.setCount(service.count());  
		page.setCount(service.searchCount(searchType, keyword));
		
		// 검색 타입과 검색어
		//page.setSearchTypeKeyword(searchType, keyword);
		page.setSearchType(searchType);
		page.setKeyword(keyword);
		
		List<Board> list = service.getListPage(page.getDisplayPost(), page.getPostNum(), searchType, keyword);

		model.addAttribute("bList", list);   
		model.addAttribute("page", page);	
		model.addAttribute("select", num);	// 현재 페이지
		
		//model.addAttribute("searchType", searchType);
		//model.addAttribute("keyword", keyword);
		
	}

	// 게시글 작성, 등록
	@PostMapping("/write")
	public String write(Board board, RedirectAttributes rttr) {
		log.info("write : " + board);
		service.write(board);
		rttr.addFlashAttribute("result", board.getBoardID());
		return "redirect:/board/listPage?num=1";
	}

	// 글쓰기 페이지로 이동
	@GetMapping("/write")
	public String write() {
		return "board/write";
	}

	// 게시글 조회
	@GetMapping("/read")
	public void read(@RequestParam("boardID") Integer boardID, Model model) {
		service.increaseView(boardID); // 게시글 조회 시 1 증가
		Board board = service.read(boardID);
		model.addAttribute("board", board);

		// 댓글 조회
		List<BoardReply> reply = replyService.replyList(boardID);
		model.addAttribute("reply", reply);
		
	}

	// 게시글 수정
	@GetMapping("/modify")
	public void modify(@RequestParam("boardID") Integer boardID, Model model) {
		Board board = service.read(boardID);
		model.addAttribute("board", board);
	}

	// 게시글 수정
	@PostMapping("/modify")
	public String modify(Board board, RedirectAttributes rttr) {
		// log.info("modify : " + board);
		service.modify(board);
		rttr.addFlashAttribute("result", "modify");
		return "redirect:/board/read?boardID=" + board.getBoardID();
	}

	// 게시글 삭제
	@GetMapping("/delete")
	public String remove(@RequestParam("boardID") Integer boardID, RedirectAttributes rttr) {
		// log.info("delete....... : " + boardID);
		service.delete(boardID);
		rttr.addFlashAttribute("result", "remove");
		return "redirect:/board/list";
	}

	/*
	 * // 게시글 목록 + 검색 추가
	 * 
	 * @GetMapping("/list") public void getListPage(Model model,
	 * 
	 * @RequestParam(value = "searchType", required = false, defaultValue = "title")
	 * String searchType,
	 * 
	 * @RequestParam(value = "keyword", required = false, defaultValue = "") String
	 * keyword) {
	 * 
	 * List<Board> list = service.listPageSearch(searchType, keyword);
	 * model.addAttribute("bList", list); }
	 */
}
