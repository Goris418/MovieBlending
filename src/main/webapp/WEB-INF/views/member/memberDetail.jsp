<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- SEO -->
    <title>유저 상세 페이지</title>
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/87f959d9dc.js" crossorigin="anonymous"></script>
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/memberDetail.css" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</head>

<body>
    <% 
    String userID = null; 
    if (session.getAttribute("userID") != null) { 
        userID = (String) session.getAttribute("userID"); 
    } 
    %>
    <!-- Header -->
    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

    <main>
        <div class="main">
            <div class="userProfile">
                <div class="main-info">
                    <div class="profile-header">
                        <div>프로필 정보</div>
                    </div>
                    <div class="profile-main-info">
                        <img src="${pageContext.request.contextPath}/resources/images/profile.jpg">
                        <div class="profile-main-info-box">
                            <div class="person-info">
                                <span>닉네임 : <b>${member.userNickname}(${member.userID})</b></span>
                                <span>생성 일자 : <b><fmt:formatDate value="${member.regDate}" pattern="yyyy년 MM월 dd일 (E)" /></b></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="user-writeReview">
                    <div class="user-Review-header">
                        <div>작성한 관람평</div>
                    </div>
                    <ul class="movies">
                        <c:forEach var="review" items="${memberReviews}">
                            <li class="movie">
                                <div class="movie_name">${review.movieNm}</div>
                                <div class="star-rating">
                                    <!-- <i class="fa-solid fa-star"></i> -->
                                </div>
                                <a href="/movie/movieDetail?movieCd=${review.movieCd}" target="_blank">
                                    <c:if test="${not empty review.imgUrl}">
                                        <img src="${review.imgUrl}" alt="movie1" class="movie__img" />
                                    </c:if>
                                    <c:if test="${empty review.imgUrl}">
                                        <img src="${pageContext.request.contextPath}/resources/images/movies/subPoster.png" alt="movie1" class="movie__img" />
                                    </c:if>
                                    <div class="movie__metadata">
                                        <h3 class="movie__title">${review.movieNm}</h3>
                                        <p>개봉 일자 : ${review.openDt}</p>
                                        <div class="review_box">
                                            <div class="movie__review">
                                                <div class="review">${review.content}</div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />
</body>
</html>
