package com.movie.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.movie.domain.Review;
import com.movie.domain.User;
import com.movie.service.MemberService;
import com.movie.service.ReviewService;
import com.movie.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/member/*")
public class MemberController {
    private MemberService memberservice;
    private UserService userservice;
    private ReviewService reviewservice;
    
    @GetMapping("/memberDetail")
    public String getMemberDetail(Model model, HttpServletRequest request, HttpSession session) {

    	User user = (User) session.getAttribute("user");
    	
    	String movieCd = request.getParameter("movieCd");
		log.info("getMovieDetail : " + movieCd);
		
		/* 영화 정보 출력 */
		model.addAttribute("movie", reviewservice.getUserMovieDetail(movieCd));
    	
    	String userNickname = request.getParameter("userNickname");
        log.info("userNickname : " + userNickname);
        
		/* 사용자 정보를 가져오기 */
        model.addAttribute("member", memberservice.getMember(userNickname));
        
		/* 사용자의 리뷰 정보를 가져오기 */
        model.addAttribute("memberReviews", memberservice.getMemberReview(userNickname));
        


        // memberDetail 페이지로 이동
        return "/member/memberDetail"; 
    }

}