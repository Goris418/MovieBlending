<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/myPage.css" />
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
    function closeWindow(reviewID) {
        var content = document.querySelector('textarea[name="description"]').value;
        var rate = document.querySelector('input[type="text"]').value;
        console.log('함수 호출', content);
        $.ajax({
            url : '/modifyReview',
            type : 'GET',
            data : {
                content : content,
                rate : rate,
                reviewID : reviewID
            // 요청에 value 값 추가
            },
            success : function(response) {
                // 요청이 성공하면 수행할 작업
                console.log('GET 요청 성공');      
            },
            error : function(xhr, status, error) {
                // 요청이 실패하면 수행할 작업
                console.error('GET 요청 실패:', status, error);
            }
        });
        
        setTimeout(function() {
            window.opener.location.reload();
            window.close();
        }, 500);
        
    }
</script>
</head>
<body>
    <div class="subHeader"></div>
    <div class="sub">
        <span class="title">리뷰 수정</span>
        <div class="reviewSubBox">
            <c:if test="${not empty review.imgUrl}">
                <img class="posterImgSub" src="${review.imgUrl}">
                <br>
            </c:if>
            <c:if test="${empty review.imgUrl}">
                <img class="posterImgSub" src="${pageContext.request.contextPath}/resources/images/movies/subPoster.png">
                <br>
            </c:if>
            
            <span class="movieNameSub">${review.movieNm}</span><br> <span
                class="star">⭐</span> <span class="movieRate"><input
                type="text" class="rate" value="${review.rate}">/ 10.0</span><br>
            <span class="reviewDes"></span>
        </div>
        <textarea name="description" cols="60" rows="10">${review.content}</textarea>
        <input class="update" type="submit"
            onclick="closeWindow(${review.reviewID})" value="내용 수정">
    </div>
</body>
</html>