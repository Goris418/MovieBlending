package com.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.domain.Review;
import com.movie.domain.User;
import com.movie.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberService {
	@Setter(onMethod_ = { @Autowired })
	private MemberMapper mapper;

	/* 즐겨찾기 값 가져오기 */
	public Object getFavoriteMovie(String userID) {
		return mapper.getFavoriteMovie(userID);
	}
	
	public List<Review> getMemberReview(String userNickname) {
		log.info("userNickname(ser).. ..." + userNickname);
	    return mapper.getMemberReview(userNickname);
	}
	
	public User getMember(String userNickname) {

		return mapper.getMember(userNickname);
	}
}