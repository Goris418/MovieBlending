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
<title>내가 작성한 리뷰 페이지</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/myPage.css" />
<script src="https://kit.fontawesome.com/87f959d9dc.js"></script>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
    crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
    crossorigin="anonymous"></script>
<script>
    var newWindow = null;
    function openNewWindow() {
        if (newWindow && !newWindow.closed) {
            newWindow.focus(); // 이미 열린 새 창을 포커스합니다.
        } else {
            newWindow = window.open("myPageReviewSub.jsp", "",
                    "width=600,height=800");
        }
    }
    
    function openNewWindow(id) {
        console.log('함수 호출', id);
        var newWindow = window.open("", "", "width=600,height=800");
        newWindow.location.href = "/myPage/ReviewSub?reviewID=" + id;
    }
    
    function sendGetRequest(image) {
        var value = image.getAttribute('value'); // 이미지의 value 속성 가져오기
        // AJAX를 사용하여 GET 요청 보내기
        $.ajax({
            url : '/deleteReview',
            type : 'GET',
            data : {
                reviewID : value
            // 요청에 value 값 추가
            },
            success : function(response) {
                // 요청이 성공하면 수행할 작업
                console.log('GET 요청 성공');
                document.location.href = document.location.href;
            },
            error : function(xhr, status, error) {
                // 요청이 실패하면 수행할 작업
                console.error('GET 요청 실패:', status, error);
            }
        });
    }
</script>
</head>
<body>
    <jsp:include
        page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />
    <main>
        <div class="left">
            <h1 class="myTitle">마이페이지</h1>
            <a class="myMenu" href="/myPage">사용자 정보<i
                class="fa-regular fa-greater-than"></i></a><br> <a class="myMenu"
                href="/myPage/Review" style="text-decoration: underline;">작성한 리뷰<i
                class="fa-regular fa-greater-than"></i></a><br> <a class="myMenu"
                href="/myPage/Favorite">즐겨찾기<i
                class="fa-regular fa-greater-than"></i></a>
        </div>
        <span class=mTitle><h1 class="mText">작성한 리뷰</h1></span>
        <hr>
        <c:forEach var="review" items="${reviews}">
            <div class="reviewBox">
                <c:if test="${not empty review.imgUrl}">
                    <img class="posterImg clickable" src="${review.imgUrl}"
                        width="200px"
                        onclick="window.location.href='/movie/movieDetail?movieCd='+'${review.movieCd}'">
                </c:if>
                <c:if test="${empty review.imgUrl}">
                    <img class="posterImg clickable" src="${pageContext.request.contextPath}/resources/images/movies/subPoster.png"
                        width="200px"
                        onclick="window.location.href='/movie/movieDetail?movieCd='+'${review.movieCd}'">
                </c:if>
                <img class="xmark"
                    src="${pageContext.request.contextPath}/resources/images/xmark@2x.png"
                    value="${review.reviewID}" onclick="sendGetRequest(this)"> <input
                    class="reviewUpdate" type="submit"
                    onclick="openNewWindow(${review.reviewID})" value="내용 수정">
                <span class="movieName">${review.movieNm}</span><br>
                <div class="starBox">
                    <span class="star">⭐</span> <span class="movieRate">&nbsp;${review.rate}
                        / 10.0</span><br>
                </div>
                <span class="reviewDes">${review.content}</span>
            </div>
        </c:forEach>
    </main>
    <aside>
        <a class="arrow-up" title="back to top"
            onclick="window.scrollTo(0,0);"> <i class="fa-solid fa-arrow-up"></i></a>
    </aside>
</body>
</html>