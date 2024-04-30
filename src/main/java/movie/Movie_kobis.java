package movie;

public class Movie_kobis {

	private String movieCd;
	private String movieNm;
	private String movieNmEn;
	private String openDt;
	private String genreNm;
	
	public Movie_kobis() {
		super();
	}
	
	public Movie_kobis(String movieCd, String movieNm, String movieNmEn, String openDt, String genreNm) {
		super();
		this.movieCd = movieCd;
		this.movieNm = movieNm;
		this.movieNmEn = movieNmEn;
		this.openDt = openDt;
		this.genreNm = genreNm;
	}
	public String getMovieCd() {
		return movieCd;
	}
	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}
	public String getMovieNm() {
		return movieNm;
	}
	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}
	public String getMovieNmEn() {
		return movieNmEn;
	}
	public void setMovieNmEn(String movieNmEn) {
		this.movieNmEn = movieNmEn;
	}
	public String getOpenDt() {
		return openDt;
	}
	public void setOpenDt(String openDt) {
		this.openDt = openDt;
	}
	public String getGenreNm() {
		return genreNm;
	}
	public void setGenreNm(String genreNm) {
		this.genreNm = genreNm;
	}
	
	
}