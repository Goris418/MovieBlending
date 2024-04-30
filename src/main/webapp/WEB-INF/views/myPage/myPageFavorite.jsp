<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>즐겨찾기 페이지</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/myPage.css" />
<script src="https://kit.fontawesome.com/87f959d9dc.js"></script>
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
</head>
<body>
    <jsp:include
        page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />
    <main>
        <div class="left">
            <h1 class="myTitle">마이페이지</h1>
            <a class="myMenu" href="/myPage">사용자 정보<i
                class="fa-regular fa-greater-than"></i></a><br> <a class="myMenu"
                href="/myPage/Review">작성한 리뷰<i
                class="fa-regular fa-greater-than"></i></a><br> <a class="myMenu"
                href="/myPage/Favorite" style="text-decoration: underline;">즐겨찾기<i
                class="fa-regular fa-greater-than"></i></a>
        </div>
        <span class=mTitle><h1 class="mText">
                즐겨찾기 <i class="fa-solid fa-star"></i>
            </h1></span>
        <hr>
        <c:forEach var="favorite" items="${favorites}">
            <div class="favoriteBox">
                <c:if test="${not empty favorite.imgUrl}">
                    <img class="favoriteImg clickable" src="${favorite.imgUrl}"
                        width="200px"
                        onclick="window.location.href='/movie/movieDetail?movieCd='+'${favorite.movieCd}'">
                    <br>
                </c:if>
                <c:if test="${empty favorite.imgUrl}">
                    <img class="favoriteImg clickable"
                        src="${pageContext.request.contextPath}/resources/images/movies/subPoster.png"
                        width="200px"
                        onclick="window.location.href='/movie/movieDetail?movieCd='+'${favorite.movieCd}'">
                    <br>
                </c:if>
                <div class="favoriteStarBox"></div>
                <span class="favoriteMovieName">${favorite.movieNm}</span><br>
            </div>
        </c:forEach>
    </main>
    <aside>
        <a class="arrow-up" title="back to top"
            onclick="window.scrollTo(0,0);"> <i class="fa-solid fa-arrow-up"></i></a>
    </aside>
</body>
</html>