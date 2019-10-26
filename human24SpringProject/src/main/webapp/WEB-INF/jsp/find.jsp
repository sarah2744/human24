<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/7cc56f1dc7.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/7cc56f1dc7.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Lobster&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/find.css">
<title>아이디 / 비밀번호 찾기</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div id="wrap">
		<h1 id="title">아이디 / 비밀번호 찾기</h1>
		<div id="wrapping">
			<a href="#" id="findId">
				<div id="buyDiv">
					<p class="cont">
						<i class="fas fa-user"></i> <br> 아이디 찾기
					</p>
				</div>
			</a> <a href="#" id="findPwd">
				<div id="sellDiv">
					<p class="cont">
						<i class="fas fa-key"></i> <br> 비밀번호 찾기
					</p>
				</div>
			</a>
		</div>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script type="text/javascript">
$(function(){
	$("#findId").click(function(){
		var popupX = (window.screen.width/2)-(200/2)-200;
		var popupY= (window.screen.height/2)-(300/2)-100;
		window.open('/main/findId', '아이디 찾기', 'width=600, height=400, menubar=no, status=no, scrollbars=no, toolbar=no, left=' + popupX + ' ,top=' + popupY);  
	})
	$("#findPwd").click(function(){
		var popupX = (window.screen.width/2)-(200/2)-300;
		var popupY= (window.screen.height/2)-(300/2)-150;
		window.open('/main/findPwd', '비밀번호 찾기', 'width=800, height=450, menubar=no, status=no, scrollbars=no, toolbar=no, left=' + popupX + ' ,top=' + popupY);  
	})
})
</script>
</html>