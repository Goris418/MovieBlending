<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
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

	<div class="wrapper">
		<main>
			<div class="left">
				<h1 class="myTitle">마이페이지</h1>
				<a class="myMenu" href="/myPage" style="text-decoration: underline;">사용자
					정보<i class="fa-regular fa-greater-than"></i>
				</a><br> <a class="myMenu" href="/myPage/Review">작성한 리뷰<i
					class="fa-regular fa-greater-than"></i></a><br> <a class="myMenu"
					href="/myPage/Favorite">즐겨찾기<i
					class="fa-regular fa-greater-than"></i></a>
			</div>

			<div class="login-wrap">
				<div class="login-html">
					<input id="tab-2" type="radio" name="tab" class="sign-up" checked>
					<label for="tab-2" class="tab" style="cursor: pointer">회원탈퇴</label>

					<div class="login-form">
						<!-- 회원탈퇴 -->
						<div class="sign-up-htm">
							<form method="post" role="form" autocomplete="off">
								<div class="group">
									<label for="id" class="label">UserID</label> <input id="id"
										type="text" class="input" name="userID" value="${user.userID}">
								</div>
								<div class="group">
									<label for="pass" class="label">Password</label> <input
										id="userPassword" type="password" class="input"
										data-type="password" name="userPassword">
								</div>
								<div class="group">
									<a href="/myPage" class="before">
									<button type="button" class="btn btn-success">이전으로</button>
									</a>
									<button type="submit" class="btn btn-danger" style="cursor: pointer">
										회원탈퇴
									</button>
								</div>
					
							</form>
							<div>
								<c:if test="${msg == false }">
									<p style="color: red;" align="center">입력한 비밀번호가 잘못 되었습니다!</p>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />
</head>
<script type="text/javascript">
	$(document).ready(function() {
		$("#submit").on("click", function() {
			if ($("#userPassword").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#userPassword").focus();
				return false;
			}
		});
	})
</script>

</body>
</html>