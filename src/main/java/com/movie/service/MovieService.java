
package com.movie.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movie.domain.Movie;
import com.movie.mapper.MovieMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//Service는 비즈니스 로직

@Log4j
@Service
public class MovieService {
	@Setter(onMethod_ = @Autowired)
	MovieMapper mapper;

	public int insertBoxOfficeKobisData(Movie movie) {
		log.info("insertBoxOfficeKobisData...");
		return mapper.insertBoxOfficeKobisData(movie);
	}

	public int updatePosterUrl(Movie movie, String movieCd) {
		log.info("updatePosterUrl...");
		return mapper.updatePosterUrl(movie, movieCd);
	}

	public int updateKmdbData(Movie movie, String movieNm, String openDt) {
		log.info("updateKmdbData...");
		return mapper.updateKmdbData(movie, movieNm, openDt);
	}

	// 박스 오피스 데이터 조회 1단계(진흥원 API)
	public List<Movie> fetchBoxOfficeData(String selectedDate, String type) throws IOException {
		StringBuilder urlBuilder = new StringBuilder("http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/");
		// 일별,주간,주말에 따른 파라미터 1차 구분
		urlBuilder.append(type.equals("daily") ? "searchDailyBoxOfficeList.json" : "searchWeeklyBoxOfficeList.json");
		urlBuilder.append("?key=f5eef3421c602c6cb7ea224104795888"); // 발급키
		// 일별,주간,주말에 따른 파라미터 2차 구분
		urlBuilder.append(type.equals("weekly") ? "&weekGb=0" : type.equals("weekend") ? "&weekGb=1" : "");
		urlBuilder.append("&targetDt=").append(selectedDate.replace("-", ""));

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		log.info("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		// log.info(sb.toString());

		return parseResponse(sb.toString(), type);
	}

	// 박스 오피스 데이터 조회 2단계(응답 전달받고 객체 생성)
	public List<Movie> parseResponse(String response, String type) {
		List<Movie> mList = new ArrayList<>();
		JSONObject jsonObject = new JSONObject(response);
		JSONArray jsonArray = null;
		String showRange = null;
		
		if (type.equals("daily")) {
			jsonArray = jsonObject.getJSONObject("boxOfficeResult").getJSONArray("dailyBoxOfficeList");
		} else if (type.equals("weekly") || type.equals("weekend")) {
			showRange = jsonObject.getJSONObject("boxOfficeResult").getString("showRange");
			jsonArray = jsonObject.getJSONObject("boxOfficeResult").getJSONArray("weeklyBoxOfficeList");
		}
		if (jsonArray != null) {
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject movieObj = jsonArray.getJSONObject(i);
				int rank = movieObj.getInt("rank");
				String movieCd = movieObj.getString("movieCd");
				String movieNm = movieObj.getString("movieNm");
				String openDt = movieObj.getString("openDt");
				// 숫자를 1000 단위로 끊어서 출력(가독성 향상)
				String audiCnt = String.format("%, d", Integer.parseInt(movieObj.getString("audiCnt")));
				String audiAcc = String.format("%, d", Integer.parseInt(movieObj.getString("audiAcc")));
				String rankOldAndNew = movieObj.getString("rankOldAndNew");
				if (rankOldAndNew.equals("OLD")) {
					rankOldAndNew = " ";
				}
				log.info("변경된 랭크값 : " + rankOldAndNew);
				// =============================================================
				Movie movie = new Movie();
				movie.setRank(rank);
				movie.setMovieCd(movieCd);
				movie.setMovieNm(movieNm);
				movie.setOpenDt(openDt);
				movie.setRankOldAndNew(rankOldAndNew);
				movie.setAudiCnt(audiCnt);
				movie.setAudiAcc(audiAcc);
				movie.setShowRange(showRange);
				// db 테이블에 저장(값이 1 나오면 저장 성공, 0 나오면 저장 실패)
				log.info("insertBoxOfficeKobisData 결과 : " + mapper.insertBoxOfficeKobisData(movie));

				// 진흥원 데이터로 검색해, 해당 영화에 일치되는 포스터 url 가져오기
				fetchMoviePoster(mList, rank, movieCd, movieNm, openDt, rankOldAndNew, audiCnt, audiAcc, showRange);
			}
		}
		return mList;
	}

	// 포스터 URL 조회 전용(리턴값은 String)
	public void fetchMoviePoster(List<Movie> mList, int rank, String movieCd, String movieNm, String openDt,
			String rankOldAndNew, String audiCnt, String audiAcc, String showRange) {
		String posterUrl = null;
		try {
			// 한글이 들어있는 경우에 대비해, URLEncoder.encode 사용 필요
			String encodedMovieNm = URLEncoder.encode(movieNm, "UTF-8");

			StringBuilder urlBuilder = new StringBuilder(
					"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");
			urlBuilder.append("&ServiceKey=6CO85UB1I0DP2Y32897W").append("&title=").append(encodedMovieNm)
					.append("&releaseDts=").append(openDt); // .replace("-", "")

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			// System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			// System.out.println(sb.toString());
			// ==============================================================================
			JSONObject jsonObject = new JSONObject(sb.toString());
			JSONArray dataArray = jsonObject.getJSONArray("Data");
			JSONObject selectedObject = null;

			String title = "", releaseDate = "";
			String[] releaseDates;
			int num = 0;

			if (dataArray.length() > 0) {
				JSONObject dataObject = dataArray.getJSONObject(0);
				JSONArray resultArray = dataObject.getJSONArray("Result");

				// 동명의 다른 영화들까지 등장하는 경우, for문으로 내가 원하는 영화만 딱 골라서 거르기
				for (int i = 0; i < resultArray.length(); i++) {
					if (resultArray.length() > 0) {
						JSONObject movieObject = resultArray.getJSONObject(i);

						// movieNm과 일치하는 title 찾기
						// 위치는 Data->Result->title
						title = movieObject.getString("title").replaceAll("!HS|!HE", "").trim().replaceAll("\\s+", " ");
						log.info(i + "번째의 추출한 영화의 제목:" + title);
						if (title.equals(movieNm)) {
							num = i; // 정보가 일치하는 Row의 순서 반환
							log.info("추출한 영화의 제목과 순서: " + num + "번째의 " + title);
							break;
						}
					}
				}

				// 일치되는 영화 제목과 똑같은 위치의 JSONObject 재선언
				selectedObject = resultArray.getJSONObject(num);

				// openDt와 일치하는 releaseDate 찾기
				// 위치는 Data->Result->ratings->rating->releaseDate
				// 주의!! ratings는 [가 없고 {로만 둘러싸여, Array 생성이 불가능('[{' 둘다 있어야 Array 생성 가능)
				// 때문에 ratings는 Object만 선언하고 그다음 아랫층 rating로 이동
				JSONArray ratingArray = selectedObject.getJSONObject("ratings").getJSONArray("rating");
				for (int i = 0; i < ratingArray.length(); i++) {
					JSONObject ratingObject = ratingArray.getJSONObject(i); // rating 객체 가져오기
					releaseDate = ratingObject.getString("releaseDate");
					releaseDates = releaseDate.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					releaseDate = releaseDates[0];
					if (releaseDate.equals(openDt)) {
						log.info("추출한 영화의 개봉일:" + releaseDate);
						break;
					}
				}

				// 제목,개봉일 둘 다 일치한게 확인되면, 해당 위치의 posterUrl 추출
				String postersString = selectedObject.getString("posters");// '|'로 구분된 포스터 URL 문자열
				String[] posterUrls = postersString.split("\\|"); // '|'로 문자열 분할
				if (posterUrls.length > 0) {
					// 첫 번째 포스터 URL 가져오기
					posterUrl = posterUrls[0];
					log.info("포스터 URL: " + posterUrl);
				}

				// 올바른 포스터 이미지 URL과 해당 영화의 title과 releaseDate 값을 로그에 출력
				// log.info("가져온 영화 제목 비교: " + title + "|그리고|" + movieNm);
				// log.info("가져온 영화 개봉일자 비교: " + releaseDate+ "|그리고|" + openDt);
			}
			Movie movie = new Movie();
			movie.setRank(rank);
			movie.setMovieCd(movieCd);
			movie.setMovieNm(movieNm);
			movie.setOpenDt(openDt);
			movie.setPosterUrl(posterUrl);
			movie.setRankOldAndNew(rankOldAndNew);
			movie.setAudiCnt(audiCnt);
			movie.setAudiAcc(audiAcc);
			movie.setShowRange(showRange);
			log.info("updatePosterUrl 결과 : " // 포스터 url만 db에 저장
					+ mapper.updatePosterUrl(movie, movieCd));
			mList.add(movie);

			// KMDB 데이터들을 테이블에 저장
			// 여기다 선언해야지, KMDB API를 두번씩이나 조회할 필요가 없어짐
			saveMovieDetails(dataArray, movieNm, openDt, selectedObject);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 상세정보에 필요한 KMDB 데이터들을 테이블에 저장
	public void saveMovieDetails(JSONArray dataArray, String movieNm, String openDt, JSONObject selectedObject)
			throws IOException {
		try {
			String titleEng = "", genre = "", prodYear = "", directorNm = "", actorNmList = "", company = "",
					rating = "", vodUrl = "", vodClass = "";
			String[] titleEngs, genres, prodYears, directorNms, actorNms, companies, ratings, vodUrls, vodClasses;

			if (dataArray.length() > 0) {
				JSONObject dataObject = dataArray.getJSONObject(0);
				JSONArray resultArray = dataObject.getJSONArray("Result");

				if (resultArray.length() > 0) {

					// titleEng 값 가져오기
					// 위치는 Data->Result->titleEng
					titleEng = selectedObject.getString("titleEng");
					titleEngs = titleEng.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					titleEng = titleEngs[0];
					if (titleEng.equals(null)) {
						titleEng = "&nbsp;";
					}
					log.info("titleEng 값: " + titleEng);

					// genre 값 가져오기
					// 위치는 Data->Result->genre
					genre = selectedObject.getString("genre");
					genres = genre.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					genre = genres[0];
					if (genre.equals(null)) {
						genre = "&nbsp;";
					}
					log.info("genre 값: " + genre);

					// prodYear 값 가져오기
					// 위치는 Data->Result->prodYear
					prodYear = selectedObject.getString("prodYear");
					prodYears = prodYear.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					prodYear = prodYears[0];
					if (prodYear.equals(null)) {
						prodYear = "&nbsp;";
					}
					log.info("prodYear 값: " + prodYear);

					// directorNm 값 가져오기
					// 위치는 Data->Result->directors->director->directorNm
					// 주의!! directors는 [가 없고 {로만 둘러싸여, Array 생성이 불가능('[{' 둘다 있어야 Array 생성 가능)
					// 때문에 directors는 Object만 선언하고 그다음 아랫층 director로 이동
					JSONObject directorsObject = selectedObject.getJSONObject("directors");
					JSONArray directorArray = directorsObject.getJSONArray("director");
					if (directorArray.length() > 0) {
						JSONObject directorNmObject = directorArray.getJSONObject(0);
						directorNm = directorNmObject.getString("directorNm");
					}
					directorNms = directorNm.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					directorNm = directorNms[0];
					if (directorNm.equals(null)) {
						directorNm = "&nbsp;";
					}
					log.info("directorNm 값: " + directorNm);

					// actorNm 값 가져오기
					// 위치는 Data->Result->actors->actor->actorNm
					// 주의!! actors는 [가 없고 {로만 둘러싸여, Array 생성이 불가능('[{' 둘다 있어야 Array 생성 가능)
					// 때문에 actors는 Object만 선언하고 그다음 아랫층 director로 이동
					JSONObject actorsObject = selectedObject.getJSONObject("actors");
					JSONArray actorArray = actorsObject.getJSONArray("actor");
					if (actorArray.length() > 0) {
						for (int i = 0; i < actorArray.length(); i++) {
							JSONObject actorNmObject = actorArray.getJSONObject(i);
							String actorNm = actorNmObject.getString("actorNm");
							actorNms = actorNm.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
							actorNmList += actorNms[0]; // actorNm를 리스트에 추가
							if (i < actorArray.length() - 1) {
								actorNmList += ","; // 마지막 요소가 아니면 쉼표 추가
							}

							if (i >= 4) {
								break;
							}
						}
					}
					if (actorNmList.equals(null)) {
						actorNmList = " ";
					}
					log.info("actorNm 값: " + actorNmList);

					// company 값 가져오기
					// 위치는 Data->Result->company
					company = selectedObject.getString("company");
					companies = company.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					company = companies[0];
					if (company.equals(null)) {
						company = "&nbsp;";
					}
					log.info("company 값: " + company);

					// rating 값 가져오기
					// 위치는 Data->Result->rating
					rating = selectedObject.getString("rating");
					ratings = rating.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					rating = ratings[0];
					if (rating.equals(null)) {
						rating = "&nbsp;";
					}
					log.info("rating 값: " + rating);

					// vodUrl, vodClass 값 가져오기
					// 위치는 Data->Result->vods->vod->vodUrl(vodClass)
					// 주의!! vods는 [가 없고 {로만 둘러싸여, Array 생성이 불가능('[{' 둘다 있어야 Array 생성 가능)
					// 때문에 vods는 Object만 선언하고 그다음 아랫층 vod로 이동
					JSONObject vodsObject = selectedObject.getJSONObject("vods");
					JSONArray vodArray = vodsObject.getJSONArray("vod");
					if (vodArray.length() > 0) {
						JSONObject vodUrlObject = vodArray.getJSONObject(0);
						vodUrl = vodUrlObject.getString("vodUrl");
						JSONObject vodClassObject = vodArray.getJSONObject(0);
						vodClass = vodClassObject.getString("vodClass");
					}
					vodUrls = vodUrl.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					vodUrl = vodUrls[0];
					log.info("vodUrl 값: " + vodUrl);

					vodClasses = vodClass.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					vodClass = vodClasses[0];
					log.info("vodClass 값: " + vodClass);
				}
			}
			Movie movie = new Movie();
			movie.setTitleEng(titleEng);
			movie.setGenre(genre);
			movie.setProdYear(prodYear);
			movie.setDirectorNm(directorNm);
			movie.setActorNm(actorNmList);
			movie.setCompany(company);
			movie.setRating(rating);
			movie.setVodUrl(vodUrl);
			movie.setVodClass(vodClass);
			// db 테이블에 저장(값이 1 나오면 저장 성공, 0 나오면 저장 실패)
			log.info("updateKmdbData 결과 : " + mapper.updateKmdbData(movie, movieNm, openDt));
			System.out.println("=======================================================================");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ======================================================================================================

	// 검색어로 영화 조회
	public List<Movie> fetchSearchData(String inputText, String type) throws IOException {
		// 한글이 들어있는 경우에 대비해, URLEncoder.encode 사용 필요
		String encodedinputText = URLEncoder.encode(inputText, "UTF-8");

		// 진흥원의 영화목록 API(json) URL 활용
		StringBuilder urlBuilder = new StringBuilder(
				"http://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=f5eef3421c602c6cb7ea224104795888");

		if (type.equals("movieNm")) { // 영화 제목으로 검색한 경우,
			log.info("검색어는 영화제목: " + inputText);
			urlBuilder.append("&movieNm=").append(encodedinputText);
		}
		if (type.equals("directorNm")) { // 감독명으로 검색한 경우,
			log.info("검색어는 감독명: " + inputText);
			urlBuilder.append("&directorNm=").append(encodedinputText);
		}

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		log.info("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		// log.info(sb.toString());

		return parseSearchResponse(sb.toString());
	}

	public List<Movie> parseSearchResponse(String response) {
		List<Movie> sList = new ArrayList<>();
		JSONObject jsonObject = new JSONObject(response);
		JSONArray jsonArray = null;
		jsonArray = jsonObject.getJSONObject("movieListResult").getJSONArray("movieList");
		if (jsonArray != null) {
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject movieObj = jsonArray.getJSONObject(i);
				String movieCd = movieObj.getString("movieCd");
				String movieNm = movieObj.getString("movieNm");
				String openDt = movieObj.getString("openDt");
				String genreAlt = movieObj.getString("genreAlt");
				String directorNm = "";

				JSONArray directorsArray = movieObj.getJSONArray("directors");
				if (directorsArray.length() > 0) {
					JSONObject directorNmObject = directorsArray.getJSONObject(0);
					directorNm = directorNmObject.getString("peopleNm");
				}
				String[] directorNms = directorNm.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
				directorNm = directorNms[0];
				if (directorNm.equals(null)) {
					directorNm = " ";
				}
				// =============================================================
				Movie movie = new Movie();
				movie.setMovieCd(movieCd);
				movie.setMovieNm(movieNm);
				movie.setOpenDt(openDt);
				movie.setGenre(genreAlt);
				movie.setDirectorNm(directorNm);
				// db 테이블에 저장(값이 1 나오면 저장 성공, 0 나오면 저장 실패)
				log.info("insertBoxOfficeKobisData 결과 : " + mapper.insertBoxOfficeKobisData(movie));

				log.info("검색한 영화의 정보: " + movieNm + ", " + openDt + ", " + genreAlt + ", " + directorNm);

				// 진흥원 데이터로 검색해, 해당 영화에 일치되는 포스터 url 가져오기
				fetchSearchPoster(sList, movieCd, movieNm, openDt, genreAlt, directorNm);
			}
		}
		return sList;
	}

	// 검색 페이지에 포스터 출력 + db에 저장
	public void fetchSearchPoster(List<Movie> sList, String movieCd, String movieNm, String openDt, String genreAlt,
			String directorNm) {
		String posterUrl = null;
		try {
			// 한글이 들어있는 경우에 대비해, URLEncoder.encode 사용 필요
			String encodedMovieNm = URLEncoder.encode(movieNm, "UTF-8");

			// json으로 안하면 이미지 못가져옴
			StringBuilder urlBuilder = new StringBuilder(
					"http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2");
			urlBuilder.append("&ServiceKey=6CO85UB1I0DP2Y32897W").append("&title=").append(encodedMovieNm);

			// fetchSearchData의 검색 api에서 openDt가 null인 경우가 있음.
			// 만약 append에 null을 넣어버리면 JSONObject["Result"] not found 에러 발생!!
			if (openDt != null) {
				log.info("append할 openDt 값: " + openDt);
				urlBuilder.append("&releaseDts=").append(openDt);
			}

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			// System.out.println("Response code: " + conn.getResponseCode());
			BufferedReader rd;
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			// System.out.println(sb.toString());
			// ==============================================================================
			JSONObject jsonObject = new JSONObject(sb.toString());
			int totalCount = jsonObject.getInt("TotalCount");
			System.out.println("TotalCount: " + totalCount);
			if (totalCount == 0) {
				// TotalCount가 0이면 더 이상의 작업을 수행하지 않고 함수 종료
				log.info("TotalCount가 0이므로 더 이상의 작업을 수행하지 않습니다.");
				log.info("====================================================");
				return;
			}
			JSONArray dataArray = jsonObject.getJSONArray("Data");
			JSONObject selectedObject = null;

			String title = "", releaseDate = "";
			String[] releaseDates;
			int num = 0;

			log.info("JSONObject[\"Data\"] 존재여부" + dataArray);

			if (dataArray.length() > 0) {
				JSONObject dataObject = dataArray.getJSONObject(0);
				JSONArray resultArray = dataObject.getJSONArray("Result");

				// 동명의 다른 영화들까지 등장하는 경우, for문으로 내가 원하는 영화만 딱 꼽아서 해당 위치 추적
				for (int i = 0; i < resultArray.length(); i++) {
					if (resultArray.length() > 0) {
						JSONObject movieObject = resultArray.getJSONObject(i);

						// movieNm과 일치하는 title 찾기
						// 위치는 Data->Result->title
						title = movieObject.getString("title").replaceAll("!HS|!HE", "").trim().replaceAll("\\s+", " ");
						log.info(i + "번째의 추출한 영화의 제목:" + title);
						if (title.equals(movieNm)) {
							num = i; // 정보가 일치하는 Row의 순서 반환
							log.info("추출한 영화의 제목과 순서: " + num + "번째의 " + title);
							break;
						}
					}
				}

				// 일치되는 영화 제목과 똑같은 위치의 JSONObject 재선언
				selectedObject = resultArray.getJSONObject(num);

				// openDt와 일치하는 releaseDate 찾기
				// 위치는 Data->Result->ratings->rating->releaseDate
				// 주의!! ratings는 [가 없고 {로만 둘러싸여, Array 생성이 불가능('[{' 둘다 있어야 Array 생성 가능)
				// 때문에 ratings는 Object만 선언하고 그다음 아랫층 rating로 이동
				JSONArray ratingArray = selectedObject.getJSONObject("ratings").getJSONArray("rating");
				for (int i = 0; i < ratingArray.length(); i++) {
					JSONObject ratingObject = ratingArray.getJSONObject(i); // rating 객체 가져오기
					releaseDate = ratingObject.getString("releaseDate");
					releaseDates = releaseDate.split("\\|"); // <![CDATA[ ]]> 안에 들어있는 값만 쏙 가져오게 split하기
					releaseDate = releaseDates[0];
					if (releaseDate.equals(openDt)) {
						log.info("추출한 영화의 개봉일:" + releaseDate);
						break;
					}
				}

				// 제목,개봉일 둘 다 일치한게 확인되면, 해당 위치의 posterUrl 추출
				String postersString = selectedObject.getString("posters");// '|'로 구분된 포스터 URL 문자열
				String[] posterUrls = postersString.split("\\|"); // '|'로 문자열 분할
				if (posterUrls.length > 0) {
					// 첫 번째 포스터 URL 가져오기
					posterUrl = posterUrls[0];
					log.info("포스터 URL: " + posterUrl);
				}
				Movie movie = new Movie();
				movie.setMovieCd(movieCd);
				movie.setMovieNm(movieNm);
				movie.setOpenDt(openDt);
				movie.setPosterUrl(posterUrl);
				movie.setGenre(genreAlt);
				movie.setDirectorNm(directorNm);
				log.info("updatePosterUrl 결과 : " // 포스터 url만 db에 저장
						+ mapper.updatePosterUrl(movie, movieCd));
				sList.add(movie);

				// KMDB 데이터들을 테이블에 저장
				// 여기다 선언해야지, KMDB API를 두번씩이나 조회할 필요가 없어짐
				saveMovieDetails(dataArray, movieNm, openDt, selectedObject);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
