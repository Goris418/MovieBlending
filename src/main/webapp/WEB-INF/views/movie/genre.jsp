<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박스오피스</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/boxOffice.css" />
<script src="https://kit.fontawesome.com/87f959d9dc.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<style type="text/css">
a, a:hover {
	color: white;
	text-decoration: none;
}
</style>

</head>
<body>
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/include/header.jsp" />

	<main>
		<div class="datepicker-container">
			<div class="datepicker-btn-group">
				<input type="text" id="datepicker" class="form-control"
					placeholder="날짜 선택">
			</div>
		</div>
		<div class="boxoffice">
			<div class="boxoffice_name">
				<ul>
					<li><a href="#" class="boxoffice-btn active" data-type="daily">일별
							박스오피스</a></li>
					<li><a href="#" class="boxoffice-btn" data-type="weekly">주간
							박스오피스</a></li>
					<li><a href="#" class="boxoffice-btn" data-type="weekend">주말
							박스오피스</a></li>
				</ul>
			</div>
			<div class="date_range"></div>
			<div class="boxoffice_movie">
				<c:forEach items="${mList}" var="item">
					<div class="card mb-3">
						<div class="card-header">
							<button class="bookmark-btn" data-bookmarked="false">&#9734;</button>
						</div>
						<div class="row g-0">
							<div class="col-md-12 text-center">
								<h5 class="card-title">${item.movieNm}</h5>
								<img src="${item.posterUrl}" class="card-img-top"
									alt="${item.movieNm} 이미지">
							</div>
						</div>
						<div class="card-body text-center">
							<p class="card-text">개봉일 : ${item.openDt}</p>
							<form id="movieForm" action="/movie/movieDetail" method="get">
								<input type="hidden" id="movieCd" name="movieCd"
									value="${item.movieCd}" />
								<button type="submit" id="movieButton" class="btn btn-primary">상세
									보기</button>
							</form>

						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>

	<!-- Footer -->
	<footer id="contact" class="section">
		<div class="max-container">
			<h2 class="title">세미 프로젝트 3팀</h2>
			<!-- <p class="description">세미 프로젝트 3팀</p> -->
			<ul class="contact__links">
				<li><a class="contact__link"
					href="https://www.instagram.com/netflixkr/" title="netflixkr link"
					target="_blank"> <i class="fa-brands fa-instagram"></i>
				</a></li>
				<li><a class="contact__link"
					href="https://www.instagram.com/disneypluskr/"
					title="disneypluskr link" target="_blank"> <i
						class="fa-brands fa-instagram"></i>
				</a></li>
			</ul>
			<p>©BlackLight - All rights reserved</p>
		</div>
	</footer>
	
	<script>
		$(document).ready(function() { //페이지 로드 후 실행될 함수     	
			let result = $(".boxoffice_movie");
			let dateRange = $(".date_range");
			let yesterdayDate;

			//어제의 날짜를 계산
			let d = new Date();
			d.setDate(d.getDate() - 1); //-1이면 하루전, +1이면 내일
			let year = d.getFullYear();
			let month = ('0' + (d.getMonth() + 1)).slice(-2);
			let day = ('0' + d.getDate()).slice(-2);
			yesterdayDate = year + "-" + month + "-" + day;

			//어제의 날짜를 datepicker에 표시
			$('#datepicker').val(yesterdayDate);

			//Datepicker 설정
			$('#datepicker').datepicker({
				format : 'yyyy-mm-dd',
				autoclose : true,
				todayHighlight : true,
			});

			//박스오피스 버튼 클릭 시 해당 타입의 데이터 조회
			$('.boxoffice_name ul li a').on('click', function() {
				fetchDataFlag = true; //데이터 조회 플래그를 true로 설정
				$('.boxoffice_name ul li a').removeClass('active');
				$(this).addClass('active');
				let type = $(this).data('type');
				let selectedDate = $('#datepicker').val(); //선택한 날짜 가져오기
				fetchData(selectedDate, type); //선택한 날짜와 타입을 fetchData 함수에 전달
			});

			//페이지 로드 시 자동으로 일별 박스오피스 버튼 클릭
			//이 함수 위치 바뀌면 절대 실행 X
			$('.boxoffice-btn[data-type="daily"]').click();

			//movieButton 버튼 클릭 이벤트 함수(상세보기)
			$("#movieButton").on('click', function() {
				document.getElementById('movieForm').submit();
			});

			//별 아이콘 클릭 시 색 채우기
			$('.bookmark-btn').click(function() {
				$(this).toggleClass('bookmarked'); //색상 클래스 토글
				let isBookmarked = $(this).hasClass('bookmarked'); //북마크 여부 확인
				$(this).attr('data-bookmarked', isBookmarked); //북마크 상태를 데이터 속성에 반영
			});
		});

		function fetchData(selDate) {
			// AJAX 요청 보내기
			$.ajax({
				url : 'http://localhost:9090/genre',
				type : 'GET',
				data : {
					searchText : selDate,
				},
				success : function(data) {
					showCard(data);
					console.log('AJAX 요청 성공 !!!');
				},
				error : function(xhr, status, error) {
					console.error('AJAX 요청 실패 ??? : ' + status + " " + error);
				}
			});
		}
	</script>

	<!-- 
	
	<script>
    $(document).ready(function () {
        let result = $(".boxoffice_movie");
        let dateRange = $(".date_range");

        // 박스오피스 버튼 클릭 시 해당 타입의 데이터 조회
        $('.boxoffice_name ul li a').on('click', function () {
            $('.boxoffice_name ul li a').removeClass('active');
            $(this).addClass('active');
            let type = $(this).data('type');
            let selectedDate = $('#datepicker').val(); // 선택한 날짜 가져오기
            fetchData(selectedDate, type); // 선택한 날짜와 타입을 fetchData 함수에 전달
        });    
        
        // 페이지 로드 시 자동으로 일별 박스오피스 버튼 클릭
        //이 함수 위치 바뀌면 절대 실행 X
        $('.boxoffice-btn[data-type="daily"]').click();

        //데이터 조회 함수
        function fetchData(selectedDate, type) {
            result.empty(); 	// 초기화 1.
            dateRange.empty();	// 초기화 2.
            let apiUrl;

		apiUrl= "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=7b796b1d850b70abfe1543c0d0fbe58b&movieNm=듄"
				
            $.ajax({
                url: apiUrl,
                method: "GET",
                success: function (data) {	//데이터 존재 시,
                	//조회한 데이터의 날짜 범위 출력(showRange)
                    if (data.movieListResult && data.movieListResult.source) {
                        dateRange.text(data.movieListResult.source);
                        processData(data, type); //데이터 카드 출력 함수
                    } else {
                    	result.text('해당 이름의 영화를 찾을 수 없습니다.');
                        dateRange.empty();
                    }
                },
            });
        }
        
     	//kmdb API에서 영화 포스터 가져오기
        function fetchMoviePoster(movieNm, openDt, cardElement) {
     		//XML 방식만 가능 (json 방식은 어째선지 포스터가 안나옴)
        	let kmdbApiUrl = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_xml2.jsp?collection=kmdb_new2&_type=json"
        					+"&ServiceKey=6CO85UB1I0DP2Y32897W"
        					+"&title=" + encodeURIComponent(movieNm)
        					+ "&releaseDts=" + openDt.split('-').join('');
            
            $.ajax({
                url: kmdbApiUrl,
                method: "GET",
                dataType: "xml",	//응답 데이터 형식을 XML로 지정
                success: function(data) {
                    let posters = $(data).find("posters").text();	//포스터 URL
                    let stillcuts = $(data).find("stills").text();	//스틸컷 URL(포스터 없는 경우,)

                 	//포스터 URL이 존재할 시,
                    if (posters) {
                        let posterUrl = posters.split("|")[0];			//1번째 포스터 url 가져오기
                        displayImage(posterUrl, movieNm, cardElement);	//포스터 화면에 출력(displayImage)
                    }
                    //포스터 URL이 없는 대신, 스틸컷 URL이 존재할 시
                    else if (!posters && stillcuts) {
                        let stillcutUrl = stillcuts.split("|")[0];			//1번째 포스터 url 가져오기
                        displayImage(stillcutUrl, movieNm, cardElement);	//포스터 화면에 출력(displayImage)
                    } else { 
                        console.error('영화 포스터 이미지 데이터가 존재하지 않습니다.');
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('영화 이미지를 가져오는 중 오류가 발생했습니다. 오류: ' + textStatus);
                }
            });
        }
     	
     	// 포스터(스틸컷) 화면 출력
     	//imageUrl: 카드에 표시할 이미지의 url
     	//altText: 이미지가 안나올 때 나오는 대체 텍스트
     	//cardElement: 이미지가 추가될 카드 요소
        function displayImage(imageUrl, altText, cardElement) {
     		//부트스트랩 카드 코드를 따와서 여기에다 포스터 화면 출력(class="card-img-top")
            let imageHtml = '<img src="' + imageUrl + '" class="card-img-top" alt="' + altText + ' 이미지">';
            $(cardElement).find('.card-title').after(imageHtml);
        }

        //데이터 출력 함수(카드에다 출력)
        function processData(data, type) {
            let boxOfficeList;
            
            //출력할 데이터(boxOfficeList)의 유형을 식별

                boxOfficeList = data.movieListResult.movieList;		//일별(daily)


            //-------------부트스트랩 카드 나열 함수----------------
            let cardCount = 0;
            $.each(boxOfficeList, function (index, item) {
             	let rank = item.prdtStatNm
            	let movieCd = item.movieCd;	//특정 영화 상세페이지로 이동할 때 필요한 파라미터
            	let movieNm = item.movieNm;
            	let openDt = item.openDt;
            	
                if (cardCount < 10) {
                    let cardHtml ='<div class="card mb-3">' +
                    '<div class="card-header">' +
                    '<span>'+ rank + '</span>' +
                    '<button class="bookmark-btn" data-bookmarked="false"&#9734;</button>' + 
                '</div>' + 
                '<div class="row g-0">' + 
                    '<div class="col-md-12">' +
                        '<div class="card-body text-center">' +
                            '<h5 class="card-title">' + movieNm + '</h5>' +
                            '<p class="card-text">개봉일 : ' + openDt + '</p>' + 
							//url에 파라미터를 전달
                            '<a href="movieDetail.jsp?movieCd=' + movieCd + '" class="btn btn-primary' + '">상세 보기</a>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                    result.append(cardHtml);
                    cardCount++;

                    let cardElement = result.find('.card').last();	//포스터가 들어갈 카드 순서 값 가져오기
                    fetchMoviePoster(movieNm, openDt, cardElement);	//영화 포스터 카드에 출력
                }
            });
        }
        
     	// 별 아이콘 클릭 시 색 채우기
        $('.bookmark-btn').click(function () {
            $(this).toggleClass('bookmarked'); // 색상 클래스 토글
            let isBookmarked = $(this).hasClass('bookmarked'); // 북마크 여부 확인
            $(this).attr('data-bookmarked', isBookmarked); // 북마크 상태를 데이터 속성에 반영
        });
    });
    </script> -->

</body>
</html>