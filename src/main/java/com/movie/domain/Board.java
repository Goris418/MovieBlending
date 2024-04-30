package com.movie.domain;


/*import java.util.Date;*/

import lombok.Data;
// VO
@Data
public class Board {

	private Integer boardID;
	private String userID;
	private String boardTitle;
	private String boardContent;
	private String boardDate; // 데이터타입 Date에서 String으로 바꿈
	private Integer boardView; // hit
	private Integer boardLike;
}
