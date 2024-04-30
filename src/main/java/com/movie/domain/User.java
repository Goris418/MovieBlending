package com.movie.domain;

import java.util.Date;

import lombok.Data;

//DTO
@Data
public class User {
	private String userID;
	private String userPassword;
	private String userName;
	private String userNickname;
	private String userEmail;
	private Date regDate;
}
