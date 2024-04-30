<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>로그인</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login.css" />
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script>


<script>
	
</script>
</head>
<body>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<div class="login-wrap">
		<div class="login-html">
			<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
			<label for="tab-1" class="tab" style="cursor: pointer">로그인</label> <input
				id="tab-2" type="radio" name="tab" class="sign-up"> <label
				for="tab-2" class="tab" style="cursor: pointer">회원가입</label>

			<!-- 로그인 -->
			<div class="login-form">
				<div class="sign-in-htm">
					<form method="post" action="/login">
						<div class="group">
							<label for="user" class="label">ID</label> <input id="userID"
								type="text" class="input" name="userID">
						</div>
						<div class="group">
							<label for="pass" class="label">Password</label> <input
								id="userPassword" type="password" class="input"
								data-type="password" name="userPassword">
						</div>
						<!-- 	<div class="group">
							<input id="check" type="checkbox" class="check" checked>
							<label for="check"><span class="icon"></span> 아이디 저장하기</label>
						</div> -->
						<div class="group">
							<input type="submit" class="button" value="Sign In"
								style="cursor: pointer">
						</div>
					</form>
					<div class="hr"></div>
					<div>
						<c:if test="${msg == false }">
							<p style="color: red;">로그인 실패! 아이디와 비밀번호를 확인해주세요!</p>
						</c:if>
					</div>
				</div>

				<!-- 회원가입 -->
				<div class="sign-up-htm">
					<form method="post" action="/join">
						<div class="group">
							<label for="id" class="label">UserID</label> <input id="userID2"
								type="text" class="input" name="userID">
						</div>
						<div class="group">
							<label for="pass" class="label">Password</label> <input
								id="userPassword2" type="password" class="input"
								data-type="password" name="userPassword">
						</div>
						<div class="group">
							<label for="username" class="label">Username</label> <input
								id="userName2" type="text" class="input" name="userName">
						</div>
						<div class="group">
							<label for="nickname" class="label">Nickname</label> <input
								id="userNickname2" type="text" class="input" name="userNickname">
						</div>
						<div class="group">
							<label for="email" class="label">Email</label> <input
								id="userEmail2" type="email" class="input" name="userEmail">
						</div>
						<div class="hr"></div>
						<div class="group">
							<input id="submit" type="submit" class="button" value="Sign Up"
								style="cursor: pointer">
						</div>
					</form>
					<div class="foot-lnk">
						<label for="tab-1" style="cursor: pointer">Already Member?</label>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />
	<script>
		$(document).ready(function() {
			$("#submit").on("click", function() {
				if ($("#userID2").val() == "") {
					alert("아이디를 입력해주세요.");
					$("#userID").focus();
					return false;
				}
				if ($("#userPassword2").val() == "") {
					alert("비밀번호를 입력해주세요.");
					$("#userPassword").focus();
					return false;
				}
				if ($("#userName2").val() == "") {
					alert("이름을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				if ($("#userNickname2").val() == "") {
					alert("닉네임을 입력해주세요.");
					$("#userNickname").focus();
					return false;
				}
				if ($("#userEmail2").val() == "") {
					alert("이메일을 입력해주세요.");
					$("#userEmail").focus();
					return false;
				}
			});

		})
	</script>

</body>
</html>