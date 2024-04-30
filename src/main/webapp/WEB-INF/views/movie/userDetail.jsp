<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/header.css">

<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- SEO -->
<title>유저 상세 페이지</title>


<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/87f959d9dc.js"
	crossorigin="anonymous"></script>
<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/userDetail.css" />
<!-- JavaScript -->
<script src="src/main.js" defer></script>
</head>

<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<!-- Header-->
	<jsp:include page="${application.contextPath}/header.jsp" />

	<main>
		<div class="main">
			<div class="userProfile">
				<div class="main-info">
					<div class="profile-header">
						<div>프로필 정보</div>
					</div>
					<div class="profile-main-info">
						<img src="${pageContext.request.contextPath}/images/profile.jpg">
						<div class="profile-main-info-box">
							<div class="person-info">
								닉네임 : <b>지나가던 관람객</b>
							</div>
						</div>
					</div>
				</div>
				<div class="user-writeReview">
					<div class="user-Review-header">
						<div>작성한 관람평</div>
					</div>
					<ul class="movies">
						<li class="movie">
							<div class="movie_name">듄 : 파트2</div>
							<div class="star-rating">
		<!-- 						<div class="star"><i class="fa-regular fa-star"></i></div> -->
								<input type="radio" class="star" value="1" />
							</div> <a href="#" target="_blank"> <img
								src="${pageContext.request.contextPath}/images/movies/dune.png" alt="movie1" class="movie__img" />
								<div class="movie__metadata">
									<h3 class="movie__title">듄 : 파트2</h3>
									<p>개봉 : 2024.02.28</p>
									<div class="review_box">
										<div class="movie__review">
											<div class="review">1편보다는 볼거리도 많고 액션도 많아져서 좋았습니다! 러브라인이
												꼬여가고 신적존재감이 너무 많이 부각되는점은 아쉽네요. 웅장한 한스짐머의 OST!!! 최곱니다^^</div>
										</div>
									</div>

								</div>
						</a>
						</li>
						<li class="movie">
							<div class="movie_name">파묘</div>
							<div class="star-rating">
								<input type="radio" class="star" value="1" />
							</div> <a href="#" target="_blank"> <img
								src="${pageContext.request.contextPath}/images/movies/pamyo.png" alt="movie2" class="movie__img" />
								<div class="movie__metadata">
									<h3 class="movie__title">파묘</h3>
									<p>개봉 : 2024.02.22</p>
									<div class="review_box">
										<div class="movie__review">
											<div class="review">배우들의 연기가 한 층 더 몰입하게 만들어줬던 영화</div>
										</div>
									</div>
								</div>
						</a>
						</li>
						<li class="movie">
							<div class="movie_name">댓글부대</div>
							<div class="star-rating">
								<input type="radio" class="star" value="1" />
							</div> <a href="#" target="_blank"> <img
								src="${pageContext.request.contextPath}/images/movies/comment.png" alt="movie3"
								class="movie__img" />
								<div class="movie__metadata">
									<h3 class="movie__title">댓글부대</h3>
									<p>개봉 : 2024.03.27</p>
									<div class="review_box">
										<div class="movie__review">
											<div class="review">댓글부대 배우들이 연기를 잘해요 시의성도 있고요</div>
										</div>
									</div>
								</div>
						</a>
						</li>
						<li class="movie">
							<div class="movie_name">고질라x콩 뉴파이어</div>
							<div class="star-rating">
								<input type="radio" class="star" value="1" />
							</div> <a href="#" target="_blank"> <img
								src="${pageContext.request.contextPath}/images/movies/gozilla.png" alt="movie4"
								class="movie__img" />
								<div class="movie__metadata">
									<h3 class="movie__title">고질라 X 콩-뉴 엠파이어</h3>
									<p>개봉 : 2024.03.27</p>
									<div class="review_box">
										<div class="movie__review">
											<div class="review">할로우 어스에 가보고 싶다는 생각이 들고 콩이 의리있네요.
												고질라와의 오해를 풀어주는 ** 멋짐.</div>
										</div>
									</div>
								</div>
						</a>
						</li>
						<li class="movie">
							<div class="movie_name">패스트 라이브즈</div>
							<div class="star-rating">
								<input type="radio" class="star" value="1" />
							</div> <a href="#" target="_blank"> <img
								src="${pageContext.request.contextPath}/images/movies/past.jpg" alt="movie5" class="movie__img" />
								<div class="movie__metadata">
									<h3 class="movie__title">패스트 라이브즈</h3>
									<p>개봉 : 2024.03.06</p>
									<div class="review_box">
										<div class="movie__review">
											<div class="review">서로 간의 사정으로 중단했던 인연의 끝을 보기 위한 여정…?
												익숙한 소재면서도 시선의 신선함이 약간 가미되어 새로워보이는 것도 있지만, 그래서 약간은 아쉬운 점도 보이는
												듯.</div>
										</div>
									</div>
								</div>
						</a>
						</li>
						<li class="movie">
							<div class="movie_name">윙카</div>
							<div class="star-rating">
								<input type="radio" class="star" value="1" />
							</div> <a href="#" target="_blank"> <img
								src="${pageContext.request.contextPath}/images/movies/wonka.jpg" alt="movie6" class="movie__img" />
								<div class="movie__metadata">
									<h3 class="movie__title">윙카</h3>
									<p>개봉 : 2024.01.31</p>
									<div class="review_box">
										<div class="movie__review">
											<div class="review">너~~~무 너~~~무 재밌게봤어요. 아이들도 어른들도 재밌는
												영화네요 볼거리도 많고 지루할틈이 없고~카메오배우들 보는 재미~ 휴그랜트보는 재미~~티모시 보는 재미
												오랜만에 집중해서 내내 웃으면서 봤어요 굿굿</div>
										</div>
									</div>
								</div>
						</a>
						</li>
						<li class="movie">
							<div class="movie_name">탐정 말로</div>
							<div class="star-rating">
								<input type="radio" class="star" value="1" />
							</div> <a href="#" target="_blank"> <img
								src="${pageContext.request.contextPath}/images/movies/marlowe.jpg" alt="movie7"
								class="movie__img" />
								<div class="movie__metadata">
									<h3 class="movie__title">탐정 말로</h3>
									<p>개봉 : 2024.03.21</p>
									<div class="review_box">
										<div class="movie__review">
											<div class="review">배우는 좋았지만… 그게 다였던 영화 집중하려했지만 지루함을
												견뎌내기 힘들었습니다</div>
										</div>
									</div>
								</div>
						</a>
						</li>
						<li class="movie">
							<div class="movie_name">극장판 스파이 패밀리 코드-화이트</div>
							<div class="star-rating">
								<input type="radio" class="star" value="1" />
							</div> <a href="#" target="_blank"> <img
								src="${pageContext.request.contextPath}/images/movies/spy.jpg" alt="movie8" class="movie__img" />
								<div class="movie__metadata">
									<h3 class="movie__title">극장판 스파이 패밀리 코드-화이트</h3>
									<p>개봉 : 2024.03.20</p>
									<div class="review_box">
										<div class="movie__review">
											<div class="review">우리 엄마아빠가 이렇게 허당일 리 없어!</div>
											<p></p>
										</div>
									</div>
								</div>
						</a>
						</li>


					</ul>
				</div>
			</div>


		</div>
	</main>

	<!-- Footer -->
	<jsp:include page="${application.contextPath}/footer.jsp" />

</body>

</html>