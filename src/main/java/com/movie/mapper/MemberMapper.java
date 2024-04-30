package com.movie.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.movie.domain.Favorite;
import com.movie.domain.Review;
import com.movie.domain.User;

// DAO
public interface MemberMapper {
	
	/*즐겨찾기 값 가져오기*/
	public Favorite getFavoriteMovie(@Param("userID") String userID);

	public List<Review> getMemberReview(String userNickname);

	public User getMember(String userNickname);
}