<%@page import="com.movie.domain.Review"%>
<%@page import="com.movie.domain.Movie"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/movieDetail.css" />

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<title>영화 상세 정보 페이지</title>
<script src="https://kit.fontawesome.com/87f959d9dc.js"
	crossorigin="anonymous"></script>

</head>
<body>

	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<!-- 메인 -->
	<section class="main">

		<div class="mProfile">
			<!-- 영화 포스터 출력 -->
			<div class="mPoster">
				<c:if test="${movie.posterUrl != null} }">
					<img src="${movie.posterUrl}" alt="포스터 이미지" />
				</c:if>
			</div>
			<!-- 영화 상세 정보 출력 -->
			<div class=mProfile-detail>
				<div class="head-section">
					<div class="head-section1">
						${movie.movieNm}
						<c:if test="${not empty user.userID}">
							<i class="fa-solid fa-star" id="btn-favorite"></i>
						</c:if>
					</div>
					<div class="head-section2">
						<div>
							${movie.titleEng}<span>ㆍ</span> ${movie.prodYear}
						</div>
					</div>
				</div>
				<div class="main-section">
					<dl>
						<dt>감독</dt>
						<dd>${movie.directorNm}</dd>
						<dt>등급</dt>
						<dd>${movie.rating}</dd>
						<dt>제작사</dt>
						<dd>${movie.company}</dd>
						<dt>장르</dt>
						<dd>${movie.genre}</dd>
						<dt>출연</dt>
						<dd>${movie.actorNm},,그외</dd>
						<dt>평점</dt>
						<dd class="vote-average">
							<span class="popover-trigger">⭐&nbsp;${avgRate}
							</span>
						</dd>
					</dl>
				</div>
			</div>
		</div>

		<div class="mTrailer">
			<h2>트레일러</h2>
			<div class="trailer">
				<div class="video-container">
					<p>${movie.vodClass}</p>
					<c:if
						test="${movie != null && movie.getVodUrl() != null && !movie.getVodUrl().isEmpty()}">
						<iframe src="${movie.vodUrl}" alt="${movie.movieNm}"
							title="${movie.vodClass}" frameborder="0" allowfullscreen="true"
							allow="fullscreen; autoplay; encrypted-media" muted="false"
							autoplay="0"></iframe>
					</c:if>


				</div>

			</div>
		</div>
		<div class="mReview">
			<div class="head-review">
				<h2>실관람평</h2>
				<div class="writeReview">
					<p class="d-inline-flex gap-1">
						<button class="btn btn-primary" type="button"
							data-bs-toggle="collapse" data-bs-target="#collapseExample"
							aria-expanded="false" aria-controls="collapseExample">
							<i class="fa-solid fa-pen-to-square"></i>&nbsp;&nbsp;관람평 쓰기
						</button>
					</p>
				</div>
			</div>
			<div class="mainReview">
				<!-- 관람평 작성 폼 -->
				<div class="collapse" id="collapseExample">
					<div class="card card-body">
						<div class="reviewform">
							<form method="post" name="reviewForm"
								action="${pageContext.request.contextPath}/movie/writeReview">

								<input type="hidden" name="movieCd" value="${movie.movieCd}">
								<input type="hidden" name="movieNm" value="${movie.movieNm}">
								<input type="hidden" name="imgUrl" value="${movie.posterUrl}">
								<input type="hidden" name="userNickname"
									value="${user.userNickname}">

								<!-- 사용자 프로필 -->
								<div class="userProfile">
									<a class="user_profile"
										href="/member/memberDetail?userNickname=${user.userNickname}">
										<i class="fa-regular fa-user"> </i>
									</a>
									<!-- 로그인한 유저의 경우 -->
									<c:if test="${not empty user.userID}">
										<div>
											<a
												href="/member/memberDetail?userNickname=${user.userNickname}">${user.userNickname}</a>
										</div>
									</c:if>
									<!-- 비로그인한 유저의 경우 -->
									<c:if test="${empty user.userID}">
										<div>비 로그인 사용자</div>
									</c:if>
									<!-- 평점 입력 -->
									<div>
										⭐&nbsp;<input type="text" id="rate" name="rate"
											style="width: 70px">/10.0
									</div>
								</div>
								<!-- 관람평 입력 -->
								<div class="userReview">
									<textarea class="form-control" id="exampleFormControlTextarea1"
										name="content" rows="3"></textarea>
									<div class="rbox">

										<span class="count"><strong id="charCount">0/255자</strong></span>
										<!-- 로그인한 유저의 경우 -->
										<c:if test="${not empty user.userID}">
											<button type="submit" class="btn btn-primary" id="regBtn">
												<span>작성완료!</span>
											</button>
										</c:if>
										<!-- 비로그인한 유저의 경우 -->
										<c:if test="${empty user.userID}">
											<button type="button" class="btn btn-primary" id="regBtn1">
												<span>작성완료!</span>
											</button>
										</c:if>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- 사용자 리뷰 출력 -->

				<c:forEach var="item" items="${reviews}">
					<div class="reviewform">
						<div class="userProfile">
							<a class="user_profile"
								href="/member/memberDetail?userNickname=${item.userNickname}">
								<i class="fa-regular fa-user"> </i>
							</a>
							<div>
								<a href="/member/memberDetail?userNickname=${item.userNickname}">
									${item.userNickname}</a>
							</div>
							<div>⭐&nbsp;${item.rate}/10.0</div>
						</div>
						<div class="userReview">
							<div>${item.content}</div>
						</div>
					</div>
				</c:forEach>

			</div>
		</div>
	</section>
	<aside>
		<a class="arrow-up" title="back to top"
			onclick="window.scrollTo(0,0);"> <i class="fa-solid fa-arrow-up"></i></a>
	</aside>
	<!-- Footer -->
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />

	<!-- jQuery Script -->
	<script>
		$(document).ready(function() {
			
			var vodUrl = "${movie.vodUrl}";
			var posterUrl = "${movie.posterUrl}";
			
			/* 로그인 하지 않고 관람평을 작성했을 경우 */
			$('#regBtn1').on('click', function(event) {
				event.preventDefault();
				alert('비 로그인 사용자입니다.\n로그인 후 이용해 주세요.');
				window.location.reload();
			});
			
			/* 평점에 숫자가 아니거나 0~10사이의 숫자가 아닌경우 */
			$('form[name="reviewForm"]').submit(function() {
				var rate = parseFloat($('#rate').val());
				if (isNaN(rate) || rate < 0 || rate > 10) {
					alert('평점은 0에서 10까지의 숫자로 입력해주세요.');
					return false;
				}
				return true;
			});
			
			$("#exampleFormControlTextarea1").keyup(function(e) {
			    var content = $(this).val();
			    var contentLength = content.length;
			    $("#charCount").text("(" + contentLength + " / 255자)");
			    if (contentLength > 255) {
			        alert("최대 255자까지 입력 가능합니다.");
			        $(this).val(content.substring(0, 255));
			        $('#charCount').text("(255 / 최대 255자)");
			    }
			});
			
			$(document).ready(function() {
			    $('#btn-favorite').on('click', function(event) {
			        event.preventDefault();

			        if ($(this).hasClass('clicked')) {
			            
			            $(this).removeClass('clicked');
			            deleteFromFavorites();
			        } else {
			            
			            $(this).addClass('clicked');
			            saveToFavorites();
			        }
			    });
			    
			    if (!vodUrl) {
		            // 대체 비디오 출력
		            let iframeHtml = '<iframe src="${pageContext.request.contextPath}/resources/images/movies/subTrailer1.mp4" alt="${movie.movieNm}" title="${movie.vodClass}" frameborder="0" allowfullscreen="true" allow="fullscreen; autoplay; encrypted-media" muted="false" autoplay="0"></iframe>';
		            // 비디오를 출력할 HTML 요소에 추가
		            $(".video-container").append(iframeHtml);
		        }
			    
			    if (!posterUrl) {
			        // 대체 이미지 출력
			        let imgHtml = '<img src="${pageContext.request.contextPath}/resources/images/movies/subPoster.png" alt="대체 포스터 이미지">';
			        // 이미지를 출력할 HTML 요소에 추가
			        $(".mPoster").append(imgHtml);
			    } else {
			        // 실제 포스터 출력
			        let imgHtml = '<img src="' + posterUrl + '" alt="${movie.movieNm}" class="mPosterImage">';
			        // 포스터를 출력할 HTML 요소에 추가
			        $(".mPoster").append(imgHtml);
			    }
			});

			function saveToFavorites() {
			    
			    $('#btn-favorite').addClass('active');

			    $.ajax({
			        type: 'POST',
			        url: '${pageContext.request.contextPath}/movie/insertFavorite',
			        data: {
			            movieCd: '${movie.movieCd}',
			            userID: '${user.userID}',
			            movieNm: '${movie.movieNm}',
			            rate: '${avgRate}',
			            imgUrl: '${movie.posterUrl}'
			        },
			        success: function(response) {
			            alert('즐겨찾기에 추가되었습니다.');
			        },
			        error: function(xhr, status, error) {
			            alert('Error occurred while adding to favorites.');
			        }
			    });
			}

			function deleteFromFavorites() {
			    
			    $('#btn-favorite').removeClass('active');

			    $.ajax({
			        type: 'POST',
			        url: '${pageContext.request.contextPath}/movie/deleteFavorite',
			        data: {
			            movieCd: '${movie.movieCd}',
			            userID: '${user.userID}'
			        },
			        success: function(response) {
			            alert('즐겨찾기에서 삭제되었습니다.');
			        },
			        error: function(xhr, status, error) {
			            alert('Error occurred while deleting from favorites.');
			        }
			    });
			}

		}); 
		
		</script>
</body>
</html>
