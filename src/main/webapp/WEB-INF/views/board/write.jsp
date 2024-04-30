<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board.css" />
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
</head>
<body>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />


	<!-- 메인 -->
	<main>
		<section class="notice">
			<div class="page-title">
				<div class="container">
					<!-- <h1>영화Talk 상세페이지</h1> -->
				</div>
			</div>

			<div class="container">
				<div class=row>
					<form method="post" action="/board/write">
						<table class="table table-striped align-middle"
							style="text-align: center;" border: 1px solid #dddddd>
							<thead>
								<tr>
									<th colspan="2"
										style="background-color: #eeeeee; text-align: center;">게시판
										글쓰기</th>
							</thead>
							<tbody>
								<tr>
									<td><input type="hidden" name="boardID" value="${board.boardID}"></td>
								</tr>
								<tr>
									<td><input class="form-control" name="boardTitle"
										id="title" placeholder="제목" /></td>
								</tr>
								<tr>
									<td><input class="form-control" name="userID"
										id="writer" value="${user.userID}" readonly/></td>
								</tr>
								<tr>
									<td><textarea class="form-control" name="boardContent"
											id="content" placeholder="내용" style="height: 300px;"></textarea></td>
								</tr>
								<tr>
									<td colspan="2">
										<input type="submit" class="btn btn-primary" value="작성완료"><!--  onclick="boardWrite();" -->
										<input type="reset" class="btn btn-warning" value="다시 입력"> 
										<input type="button" class="btn btn-success" value="목록"
										onclick="location.href='/board/listPage?num=1';">
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</section>
	</main>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/footer.jsp" />

	<script>
	$(document).ready(
			function boardWrite() {
				var title = ${"#title"}.val();
				var content = ${"#content"}.val();
				
				$.ajax({
					type: "POST",
					url:"/board/write",
					data : {title : title, content : content},
					success : function(data) {
						if(data =="Y") {
							alert("글 등록이 완료되었습니다.");
							location.href="/board/list";
						}
					},
					error : function(data) {
						alert("글 등록을 실패했습니다.");
						console.log(data);
					}
				});
			}
	}); // document ready 끝
	

	</script>
</body>
</html>