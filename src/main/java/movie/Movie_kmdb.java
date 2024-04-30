package movie;

public class Movie_kmdb {

	private String title;
	private String releaseDate;
	private String posterUrl;

	public Movie_kmdb() {
		super();
	}

	public Movie_kmdb(String title, String releaseDate, String posterUrl) {
		super();
		this.title = title;
		this.releaseDate = releaseDate;
		this.posterUrl = posterUrl;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getPosterUrl() {
		return posterUrl;
	}

	public void setPosterUrl(String posterUrl) {
		this.posterUrl = posterUrl;
	}

}