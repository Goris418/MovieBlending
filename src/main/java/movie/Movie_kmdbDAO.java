package movie;

import javax.servlet.ServletContext;
import utils.JDBConnect;

public class Movie_kmdbDAO extends JDBConnect {
	public Movie_kmdbDAO(ServletContext application) {
		super(application);	
	}
	
	//박스오피스 조회할 때마다 kmdb에 해당되는 데이터 삽입
	public int insertKmdbData(Movie_kmdb kmdb) {
		int rs = 0;
		String sql = "INSERT INTO MOVIE_KMDB (title, releaseDate, posterUrl) "
				+ "VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE title=?, releaseDate=?";	//이미 있는 데이터는 무시
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, kmdb.getTitle());
			pstmt.setString(2, kmdb.getReleaseDate());
			pstmt.setString(3, kmdb.getPosterUrl());
			System.out.println("테이블에 담을 이미지 url: " + kmdb.getPosterUrl());
			pstmt.setString(4, kmdb.getTitle());
			pstmt.setString(5, kmdb.getReleaseDate());
			rs = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return rs;
	}
 }