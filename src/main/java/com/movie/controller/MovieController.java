package com.movie.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.movie.domain.Movie;
import com.movie.service.MovieService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor 
/* @RequestMapping("/movie/*") */
public class MovieController {
	@Autowired
	private MovieService service;
	
	//박스오피스: 초기 페이지
	@GetMapping("/boxOffice")
    public String viewBoxOffice(@RequestParam(required = false) String selectedDate,
            @RequestParam(required = false) String type, Model model) {
		//맨 처음 페이지 로드할 때 파라미터 값이 둘다 null일 때 기본값 설정
        if (selectedDate == null && type == null) {
            selectedDate = getYesterdayDate();
            type = "daily";
        }
        log.info("전달받은 두 값: " + selectedDate + " 그리고 " + type);
        try {
            List<Movie> mList = service.fetchBoxOfficeData(selectedDate, type);
            model.addAttribute("mList", mList);	//프론트에 쓸 mList 세팅
            //log.info("mList 객체: " + mList);
        } catch (IOException e) {
            e.printStackTrace();	// 예외 처리
        }
        return "movie/boxOffice";
    }	

	//박스오피스: 버튼 누를 때마다 새로운 데이터 화면 페이지
	@GetMapping(value="/boxOffice1",
			produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<Movie>> viewBoxOffice1(@RequestParam(required = false) String selectedDate,
    		@RequestParam(required = false) String type, Model model) {

        log.info("boxoffice1으로 전달받은 두 값 : " + selectedDate + " 그리고 " + type);
        List<Movie> mList = null;
        try {
        	mList  = service.fetchBoxOfficeData(selectedDate, type);
            model.addAttribute("mList", mList);	//프론트에 쓸 mList 세팅
            log.info("mList 객체  boxoffice1: " + mList);
        } catch (IOException e) {
            e.printStackTrace();	// 예외 처리
        }
        return  new ResponseEntity<> (mList, HttpStatus.OK);
    }	
	
	//어제 날짜 가져오는 함수
	private String getYesterdayDate() {
		Calendar calendar = new GregorianCalendar();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		calendar.add(Calendar.DATE, -1);		
		String yesterDayDate = sdf.format(calendar.getTime());
		
		return yesterDayDate;
	}	
	
	//영화 검색: 초기 페이지
	@GetMapping("/movieSearch")
	public String viewSearch() {

		return "movie/movieSearch";
	}

	//영화 검색: 버튼 누를 때마다 새로운 데이터 화면 페이지
	@GetMapping(value="/movieSearch1",
			produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<Movie>> viewSearch1(@RequestParam(required = false) String inputText,
    		@RequestParam(required = false) String type, Model model) {
		
		log.info("movieSearch로 전달받은 값 : " + inputText + " 그리고 " + type);
		List<Movie> sList = null;
		try {
			sList = service.fetchSearchData(inputText, type);
            model.addAttribute("sList", sList);	//프론트에 쓸 mList 세팅
            log.info("sList 객체 movieSearch: " + sList);
        } catch (IOException e) {
            e.printStackTrace();	// 예외 처리
        }
        return new ResponseEntity<> (sList, HttpStatus.OK);
    }

}
