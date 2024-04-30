package com.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.domain.Favorite;
import com.movie.domain.Movie;
import com.movie.domain.Review;
import com.movie.mapper.ReviewMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewService {
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper mapper;

	/* 관람평 db 저장 */
	public int write(Review review) {
		log.info("register...." + review);
		return mapper.write(review);
	}

	/* 상세페이지 관람평 출력 */
	public List<Review> getMovieReviews(String movieCD) {
		log.info("get.. ..." + movieCD);
		return mapper.getMovieReviews(movieCD);
	}
	
	/* 비회원 상세페이지 movie db 출력 */
	public Movie getMovieDetail(String movieCd) {
		log.info("get.. ..." + movieCd);
		return mapper.getMovieDetail(movieCd);
	}
	
	/* 회원 상세페이지 movie db 출력 */
	public Movie getUserMovieDetail(String movieCd) {
		log.info("get.. ..." + movieCd);
		return mapper.getMovieDetail(movieCd);
	}
	
	/*상세페이지 평균 평점 출력*/
	public double getAvgRate(String movieCd) {
		log.info("get.. ..." + movieCd);
		return mapper.getAvgRate(movieCd);
	}
	
	/* 즐겨찾기 추가 */
	public int insertFavorite(Favorite favorite) {
		log.info("get.. ..." + favorite);
		return mapper.insertFavorite(favorite);
	}
	
	/*즐겨찾기 업뎃*/
	public int getFavoriteUpdate(String userID, String movieCd) {
		log.info("get.. ..." + movieCd);
		return mapper.getFavoriteUpdate(userID,movieCd);
	}

	/* 즐겨찾기 값 가져오기 */
	public Favorite getFavorite(String userID, String movieCd) {
	    return mapper.getFavorite(userID,movieCd);
	}
	
	/* 즐겨찾기 삭제하기 */
	public int deleteFavorite(String userID, String movieCd) {
		log.info("get review service.. ..." + movieCd);
		log.info("get review service.. ..." + userID);
	    return mapper.deleteFavorite(userID,movieCd);
	}

}
