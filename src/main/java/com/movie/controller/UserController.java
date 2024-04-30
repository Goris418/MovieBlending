package com.movie.controller;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.movie.domain.User;
import com.movie.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Controller
@Log4j
@AllArgsConstructor
//@RequestMapping("/user/*") // 공통주소
public class UserController {
    private UserService service;
    // 회원가입 Get
    @GetMapping("/join")
    public String Join() {
        return "user/join";
    }
    // 회원가입 Post
    @PostMapping("/join")
    public String join(User user) { // body 값을 받을 DTO 필요
        log.info("join : " + user);
        service.join(user);
        return "redirect:/login";
    }
    // 로그인 Get
    @GetMapping("/login") 
    public String Login(HttpSession session) {
        User user = (User) session.getAttribute("user"); // 세션처리
        if (user != null) {
            return "redirect:/"; // 로그인 성공, 박스오피스 메인페이지로 이동
        }
        return "/user/login"; // 로그인 되지 않은 상태
    }
    // 로그인 Post
    @PostMapping("/login")
    public String login(User user, HttpServletRequest req, RedirectAttributes rttr) {
        log.info("Post login");
        HttpSession session = req.getSession();
        User login = service.login(user);
        
        if(login == null) {
            session.setAttribute("user", null);
            rttr.addFlashAttribute("msg", false);
            return "redirect:/login";
        } else {
            session.setAttribute("user",  login);
        }
    
        return "redirect:/";
    }
    @GetMapping("/logout") // 로그아웃
    public String logout(HttpSession session) {
        session.invalidate(); // 세션에 저장되어있는 값과 세션을 삭제
        return "redirect:/login"; // 로그인 페이지로 이동
    }
    
    // 회원 탈퇴 Get
    @GetMapping("/myPage/withdrawal")
    public String withdraw(HttpSession session) {
        log.info("get withdrawal");
        return "myPage/withdrawal";
    }
    
    // 회원 탈퇴 Post
    @PostMapping("/myPage/withdrawal")
    public String withdraw(User vo, HttpSession session, RedirectAttributes rttr) {
        log.info("PostMapping withdrawal");
        User user = (User) session.getAttribute("user"); // 세션에 있는 user를 가져와 user변수에 넣어줌
        String sessionPass = user.getUserPassword(); // 세션에 있는 비밀번호
        String voPass = vo.getUserPassword();   // 새로 들어오는 비밀번호 (회원탈퇴페이지)
        if (!(sessionPass.equals(voPass))) {
            rttr.addFlashAttribute("msg", false);
            return "redirect:/myPage/withdrawal";
        }
        service.withdrawal(vo);
        session.invalidate();
        rttr.addFlashAttribute("msg", "이용해주셔서 감사합니다.");
        return "redirect:/";
    }
    // 마이페이지
    @GetMapping("/myPage")
    public String myPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        log.info("user : " + user);
        model.addAttribute("user", service.getAccount(user));
        log.info("Enter myPage: success");
        return "myPage/myPage";
    }
    @GetMapping("/myPage/Review")
    public String Review(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        log.info("user : " + user);
        model.addAttribute("reviews", service.getMyReviews(user));
        log.info("Review: success");
        return "myPage/myPageReview";
    }
    @GetMapping("/myPage/Favorite")
    public String Favorite(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        log.info("user : " + user);
        model.addAttribute("favorites", service.getMyFavorites(user));
        log.info("Favorite: success");
        return "myPage/myPageFavorite";
    }
    // 마이페이지 리뷰 삭제
    @GetMapping("/deleteReview")
    public String deleteReview(Model model, Integer reviewID) {
        service.deleteReview(reviewID);
        return "redirect:/myPage/Review";
    }
    
	@GetMapping("/myPage/ReviewSub")
	public String ReviewSub(Model model, Integer reviewID) {
		log.info("Review: try");
		model.addAttribute("review", service.getMyReview(reviewID));
		log.info("Review: success" + reviewID);
		return "myPage/myPageReviewSub";
	}

	@GetMapping("/modifyReview")
	public void modifyReview(Model model, Integer reviewID, String content, Double rate) {
		Map<String,Object> map = new HashMap<String,Object>();
		log.info("modifyReview: try" + rate + content);
		map.put("reviewID", reviewID);
		map.put("content", content);
		map.put("rate", rate);
		service.modifyReview(map);
	}
}