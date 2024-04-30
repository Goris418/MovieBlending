<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap"
	rel="stylesheet" />
</head>
<body>
	<!-- Header-->
	<header class="header">
		<div class="header1">
			<div class="header__logo">
				<img class="header__logo__img"
					src="${pageContext.request.contextPath}/resources/images/favicon.ico"
					alt="logo" />
				<h1 class="header__logo__title">
					<a href="/boxOffice">Movie Blending</a>
				</h1>
			</div>

			<!-- 상단 우측 nav바 -->
			<c:if test="${user == null }">
				<nav>
					<ul class="header__menu">
						<!-- 로그인 안 되어있을 때 -->
						<li><a class="header__menu__item" href="/login">로그인</a></li>
						<li><a class="header__menu__item" href="/join">회원가입</a></li>
					</ul>
				</nav>
			</c:if>
			<c:if test="${user != null }">
				<nav>
					<ul class="header__menu">
						<!-- 로그인 되어있을 때 -->
						<li><a class="header__menu__item">${user.userID}님 환영합니다!</a></li>
						<li><a class="header__menu__item" href="/myPage">마이페이지</a></li>
						<li><a class="header__menu__item" href="/logout">로그아웃</a></li>
					</ul>
				</nav>
			</c:if>
		</div>

		<!-- 하단 header -->
		<div class="header2">
			<nav>
				<ul class="header__menu">
					<li><a class="header__menu__item" href="/boxOffice">박스오피스</a></li>
					<li><a class="header__menu__item" href="/movieSearch">영화조회</a></li>
					<li><a class="header__menu__item" href="/board/listPage?num=1">영화Talk</a></li>
				</ul>
			</nav>
			<div class="header__search">
				<input name="search" type="text" placeholder="찾고 있는 영화가 있나요?"
					size="60" />
				<button class="header__search__button" type="submit">검색</button>
			</div>
		</div>
	</header>
	
</body>
</html>