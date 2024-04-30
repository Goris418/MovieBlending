package com.movie.mapper;
import java.util.List;
import java.util.Map;

import com.movie.domain.Favorite;
import com.movie.domain.Review;
import com.movie.domain.User;

// DAO
public interface UserMapper {
	public String getDate();
	
	public User login(User user); // 로그인 
	public void join(User user);  // 회원가입
	public User getAccount(User user);	// 회원 정보
	public List<Review> getMyReviews(User user);	// 회원 영화 리뷰
	public List<Favorite> getMyFavorites(User user);	// 회원 영화 즐겨찾기
	public void withdrawal(User user); // 회원 탈퇴
	
	/* 리뷰 삭제 */
	public int deleteReview(int reviewID);
	public Review getMyReview(int reviewID);
	public void modifyReview(Map<String, Object> map);

}