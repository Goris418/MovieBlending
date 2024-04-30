package com.movie.domain;

import lombok.Data;

@Data
public class Movie {
	private String movieCd;
	private String movieNm;
	private String titleEng;
	private String openDt;
	private String genre;
	private String posterUrl;
	private String prodYear;
	private String directorNm;
	private String actorNm;
	private String company;
	private String rating;
	private String vodUrl;
	private String vodClass;
	private String rate;
	private Integer rank;
	//===================================
	private String rankOldAndNew;
	private String audiCnt;
	private String audiAcc;
	private String state;
	private String showRange;
}
