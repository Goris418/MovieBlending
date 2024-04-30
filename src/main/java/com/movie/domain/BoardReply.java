package com.movie.domain;

import java.util.Date;

import lombok.Data;

//VO
@Data
public class BoardReply {
	private int replyID;
	private int boardID;
	private String writer;
	private String content;
	private Date regDate;
}
