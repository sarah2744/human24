<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Human 24</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/weekDiscount.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<script src="https://kit.fontawesome.com/7cc56f1dc7.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<jsp:include page="header.jsp" flush="true" />
	<%String userid = (String) session.getAttribute("userid"); %>
	<aside>
		<div id="slideshow-container">
			<div class="mySlides fade">
				<div class="numbertext">1 / 3</div>
				<img src="${pageContext.request.contextPath}/resources/slide1.jpg">
			</div>

			<div class="mySlides fade">
				<div class="numbertext">2 / 3</div>
				<img src="${pageContext.request.contextPath}/resources/slide2.jpg" style="width: 100%">
			</div>

			<div class="mySlides fade">
				<div class="numbertext">3 / 3</div>
				<img src="${pageContext.request.contextPath}/resources/slide3.jpg" style="width: 100%">
			</div>
		</div>
		<br>
		<div id="loginform" >
			<form action="login" method="post" id="loginForm">
				<h1 id="loginText">Login</h1>
				<div class="input-container">
					<i class="fa fa-user icon"></i> <input class="input-field"
						type="text" placeholder="Username" id="loginId" name="usrnm">
				</div>
				<div class="input-container">
					<i class="fa fa-key icon"></i> <input class="input-field"
						type="password" placeholder="Password" name="psw" id="loginPwd">
				</div>
				<input type="button" value="human24로 로그인" id="btnLogin" class="btn">
				<div id="txtline">
					<a href="/main/join_check" id="btnJoin">회원가입</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; <a
						href="/main/find" id="btnIdPw">ID/PW찾기</a>
				</div>
				<a id="kakao-login-btn"></a> <a
					href="http://developers.kakao.com/logout"></a>
			</form>
		</div>
		<div id = "loginOk">
			<p id="hello"><span id="loginOkId"><%=userid%></span>님<br> 환영합니다!</p>
		</div>
		<input type = "hidden" id="loginyn" value=<%=userid %>>
	</aside>
	<div class="clear"></div>
	<section>
		<a href="best.jsp"><h1 id="besttext">BEST</h1></a>
		<table id="booktbl">
			<tr>
				<c:forEach items="${bookList}" var="dto" varStatus="status">
					<td>
						<div id="bookDiv" onclick="location.href='/main/detail?booknum=${dto.booknum}';">
							<div class="imgDiv">
								<img src="${pageContext.request.contextPath}/resources/${dto.booknum}.jpg">
							</div>
							<p class="bookTitle">${dto.booktitle}</p>
							<p>
								${dto.price} → <fmt:formatNumber value="${dto.price*dto.dis_per}" pattern="0"/>
								<br/>
								<span class="disPer">(<fmt:formatNumber value="${100-(dto.dis_per*100)}" pattern="0"/>% 할인)</span></br>
								<script>
								if(${100-(dto.dis_per*100)} == 30) document.write("<p style='color: tomato; margin-top: 5px;'>!!! 주말특가 !!!</p>")
								</script>
							</p>
							<p>판매지수 : ${dto.sales_cnt}</p>
							<p>
								<span class="blueStar gradeStar" id="gradeStar">
									<script>
										showStar(${dto.grade/dto.com_cnt})
									</script>	
								</span>
								<span class="grayStar gradeStar" id="gradeStar">
									<script>
									showGrayStar(${5-(dto.grade/dto.com_cnt)});
									</script>	
								</span>
							</p>
						</div>
					</td>
				</c:forEach>	
			</tr>
		</table>
	</section>		
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script type="text/javascript">
	var slideIndex = 0;
	showSlides();
	function showSlides() {
		var i;
		var slides = document.getElementsByClassName("mySlides");
		var dots = document.getElementsByClassName("dot");
		for (i = 0; i < slides.length; i++) {
			slides[i].style.display = "none";
		}
		slideIndex++;
		if (slideIndex > slides.length) {
			slideIndex = 1
		}
		for (i = 0; i < dots.length; i++) {
			dots[i].className = dots[i].className.replace(" active", "");
		}
		slides[slideIndex - 1].style.display = "block";
		setTimeout(showSlides, 3000);
	}
	
	$(function(){
		if($("#loginyn").val() != "null"){ // login 성공
			$("#loginform").css("display","none");
			$("#loginOk").css("display","block");
		}
		$("#btnLogin").click(function(){
	    	  $.ajax({
				url : "${pageContext.request.contextPath}/main/loginCheck?userId="+$('#loginId').val()+"&userPwd="+$('#loginPwd').val(),
				type : 'get',
				success : function(data) {
					if(data == 1){
				         $("#loginForm").submit();						
					}else{
						alert('로그인에 실패하였습니다')
						$('#loginPwd').val('');
					}
				}, error : function() {
					console.log("실패");
				}
			 })
	    })
		$("#loginPwd").keydown(function(key) {
			if (key.keyCode == 13) {
				$("#btnLogin").trigger("click");
	        }
		});	
	})
	

	//**************** 톰캣 연동 필요 JSP에서 처리할것***************

	//     //<![CDATA[
	//     // 사용할 앱의 JavaScript 키를 설정해 주세요.
	//     Kakao.init('2f4884f50c546bc48583a11a7c259a53');
	//     // 카카오 로그인 버튼을 생성합니다.
	//     Kakao.Auth.createLoginButton({
	//       container: '#kakao-login-btn',
	//       success: function(authObj) {
	//     	  Kakao.API.request({
	//     		  url: '/v2/user/me',
	//     		  success: function(res){
	//     			  alert(JSON.stringify(res));
	//     		  },
	//     		  fail: function(error){
	//     			  alert(JSON.stringify(error));
	//     		  }
	//     	  });
	//       },
	//       fail: function(err) {
	//          alert(JSON.stringify(err));
	//       }
	//     });
	//   //]]>
	//   /*var refreshToken = kakao.Auth.getRefreshToken();
	//   Kakao.Auth.setAccessToken(AccessTokenFromServer);*/
	//   Kakao.Auth.setAccessToken(accessTokenFromServer);
</script>
</html>