package movie;

import javax.servlet.ServletContext;
import utils.JDBConnect;

public class Movie_kobisDAO extends JDBConnect{	
	public Movie_kobisDAO(ServletContext application) {
		super(application);		
	}

	// 박스오피스 조회할 때마다 kobis 테이블에 해당되는 데이터 삽입
	public int insertKobisData(Movie_kobis kobis) {
		int rs = 0;
		String sql = "INSERT INTO MOVIE_KOBIS (movieCd, movieNm, openDt) "
				+ "VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE movieCd=?"; //이미 있는 데이터는 무시
		try {				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, kobis.getMovieCd());
			pstmt.setString(2, kobis.getMovieNm());
			pstmt.setString(3, kobis.getOpenDt());
			pstmt.setString(4, kobis.getMovieCd());
			rs = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}

}