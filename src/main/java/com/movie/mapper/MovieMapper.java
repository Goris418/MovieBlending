package com.movie.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.movie.domain.Movie;

//Mapper는 기존 MovieDAO 클래스의 역할 대체

@Mapper
public interface MovieMapper {
	// 1. 박스오피스 데이터만 테이블에 1차 저장(movieCd, movieNm, openDt)
	@Insert("INSERT INTO MOVIE (movieCd, movieNm, openDt)"
			+ "VALUES (#{movieCd}, #{movieNm}, #{openDt})"
			+ "ON DUPLICATE KEY UPDATE movieCd=VALUES(movieCd), movieNm=VALUES(movieNm)")
	public int insertBoxOfficeKobisData(Movie movie);
	
	// 2. 포스터 URL만 따로 테이블에 2차 저장
	@Update("UPDATE MOVIE SET posterUrl=#{movie.posterUrl}"
			+ "WHERE movieCd=#{movieCd}")
	public int updatePosterUrl(@Param("movie") Movie movie
			, @Param("movieCd") String movieCd);
	
	// 3. KMDB API에 해당되는 상세정보 데이터를 db에 3차 저장
	@Update("UPDATE MOVIE SET titleEng=#{movie.titleEng}, genre=#{movie.genre},"
			+ "prodYear=#{movie.prodYear}, directorNm=#{movie.directorNm}, actorNm=#{movie.actorNm},"
			+ "company=#{movie.company}, rating=#{movie.rating}, vodUrl=#{movie.vodUrl}, vodClass=#{movie.vodClass}"
			+ "WHERE movieNm=#{movieNm} AND openDt=#{openDt}")
	public int updateKmdbData(@Param("movie") Movie movie
			, @Param("movieNm") String movieNm, @Param("openDt") String openDt);
}