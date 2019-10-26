<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/7cc56f1dc7.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/7cc56f1dc7.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Lobster&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used.css">
<title>중고상점  - HUMAN24</title>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<jsp:include page="header.jsp" flush="true" />
	<div id="wrap">
		<h1 id="title">중고상점</h1>
		<div id="wrapping">
			<a href="/main/board?board_index=3&nowPage=1">
				<div id="buyDiv">
					<p class="cont">
						중고책<br>구매하기
					</p>
				</div>
			</a> <a href="/main/board?board_index=4&nowPage=1">
				<div id="sellDiv">
					<p class="cont">
						중고책<br>판매하기
					</p>
				</div>
			</a>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>