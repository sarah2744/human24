<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/ac.css">
<meta charset="UTF-8">
<title>출석 체크 - HUMAN24</title>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">

	<jsp:include page="header.jsp" flush="true" />
	<!-- header include -->
	<input type="hidden" value="${attendDay}" id="ac_days">
	<input type="hidden" id="">
	<div id="container">
		<h1 id="title">출석체크</h1>
		<h3 id="todayMonth"></h3>
		<div id="acDiv">
			<p id="acDivLeftP">* 출석체크시 50포인트 적립</p>
			<p id="acDivRightP">
				<input type="button" value="출석하기" id="acBtn">
			</p>
		</div>
		<br>
		<table border=1 id="cc" class="table table-bordered">
			<tr>
				<th day="0">일요일</th>
				<th day="1">월요일</th>
				<th day="2">화요일</th>
				<th day="3">수요일</th>
				<th day="4">목요일</th>
				<th day="5">금요일</th>
				<th day="6">토요일</th>
			</tr>
			<tbody></tbody>
		</table>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
	<!-- footer include -->
</body>
<script>
	var today = new Date();
	var year = today.getFullYear();
	var mon = today.getMonth() + 1;
	$("#todayMonth").text(mon + "월");
	var day = (new Date("'" + year + "-" + mon + "-01" + "'").getDay()); // 오늘 날짜에 대해서 요일 구하기
	var lastDate = new Date(year, mon, "").getDate(); // 오늘 날짜에 대해서 해당 월에 대한 마지막 날짜 구하기
	var realtoday = today.getDate();

	var tr = true;
	var tmp = 0;
	var first = 0;
	var dayArr = []; // 결석 날짜 배열 선언
	var ac_days = $("#ac_days").val();
	var acDayArr = ac_days.split(","); // 출석 날짜 배열

	$(document).ready(function() {

		for (var i = 1; i <= realtoday; i++) { // dayArr에 오늘까지의 날짜 배열 담기
			dayArr.push(i);
		}
		for (var i = 0; i < dayArr.length; i++) { // dayArr에서 출석 날짜 배열 빼기 (= 결석 날짜 배열)
			for (var k = 0; k < acDayArr.length; k++) {
				if (dayArr[i] == acDayArr[k]) {
					dayArr.splice(i--, 1);
				}
			}
		}
		for (i = 1; i <= lastDate; i++) {
			if (tr) {
				$("#cc > tbody:last").append("<tr>");
				tr = false;
			}
			if (first == 0) {
				for (k = 0; k < day; k++) {
					$("#cc > tbody:last").append(
							"<td value = i></td>");
					tmp++;
				}
				first = 1;
			}
			$("#cc > tbody:last").append(
					"<td value = " + i + " class = 'check'>"
							+ i + "</td>")
			tmp++;
			if (tmp % 7 == 0) {
				$("#cc > tbody:last").append("</tr>");
				tr = true;
			}
		}
		
		if(loginYN()){
			if(acDayArr.length > 1 || acDayArr[0] == realtoday){
				for (var i = 0; i < acDayArr.length; i++) { // 출석 이미지 설정
					$("td[value=" + acDayArr[i] + "]").css({
						"background" : "url(${pageContext.request.contextPath}/resources/ac_ok.png)",
						"background-size" : "70px",
						"background-repeat" : "no-repeat",
						"background-position" : "80%"
					});
				}
				if(acDayArr[(acDayArr.length)-1] == realtoday){
					$("td[value=" + realtoday + "]").css("color","black");
				}
				
			}
			for (var i = 0; i < dayArr.length; i++) { // 결석 이미지 설정
				if (dayArr[i] == realtoday) break;
				$("td[value=" + dayArr[i] + "]").css({
					"background" : "url(${pageContext.request.contextPath}/resources/ac_no.png)",
					"background-size" : "70px",
					"background-repeat" : "no-repeat",
					"background-position" : "80%"
				});
			}
		}
		$("td[value=" + realtoday + "]").css({ // 오늘 날짜 배경색 설정
			"background-color" : "#3f48ccc0",
			"color" : "white"
		});
	})
	.on("click","#acBtn",function(){
		if(!loginYN()){
			goLogin();
			return false;
		}else if (acDayArr[(acDayArr.length) - 1] == realtoday){
			alert("이미 출석하셨습니다.");
			return false;
		}else {
			$.ajax({
				type : "post",
				datatType : 'text',
				url : "${pageContext.request.contextPath}/acAjax?userid="+userid,
				success : function(data) {
					alert("출석체크가 완료되었습니다.");
					location.reload();
				}
			})
		}
	})
</script>
</html>