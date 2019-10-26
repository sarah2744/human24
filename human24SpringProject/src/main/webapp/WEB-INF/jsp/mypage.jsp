<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>마이페이지</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<section>
		<div id="topSection">
			<div id="topleft">
				<h1>MY PAGE</h1>
				<p>마이페이지</p>
			</div>

		</div>
		<div class="clear"></div>
		<div id="midSection">
			<p id="hh">나의 주문/배송현황</p>
			<ul>
				<li><p>0</p>입금전</li>
				<li><p>0</p>배송준비</li>
				<li><p>0</p>배송중</li>
				<li><p>0</p>배송완료</li>
			</ul>
		</div>
		<div class="clear" style="margin: 50px 0;"></div>
		<div id="botSection">
			<div class="sectionNav" id="nav1">
				<p>
					ORDER<br> 주문내역 조회
				</p>
			</div>
			<div class="sectionNav" id="nav2">
				<p>
					PROFILE<br> 회원 정보 수정
				</p>
			</div>
			<div class="sectionNav" id="nav3">
				<p>
					CHECKIN<br> 출석체크 관리
				</p>
			</div>
			<div class="sectionNav" id="nav4">
				<p>
					CART<br> 장바구니
				</p>
			</div>
			<div class="sectionNav" id="nav5">
				<p>
					POINT<br> 내 포인트 조회하기
				</p>
			</div>
			<div class="sectionNav" id="nav6">
				<p>
					LEAVE<br> 탈퇴하기
				</p>
			</div>
			<input type="hidden" id="sessionHidden">
		</div>
	</section>
	<div class="clear"></div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script>


$(function(){
	$("#nav1").click(function(){
		window.location.href = '/main/order';
	})
	$("#nav2").click(function(){
		window.location.href = '/main/modify';
	})
	$("#nav3").click(function(){
		window.location.href = '/main/attendance_check';
	})
	$("#nav4").click(function(){
		window.location.href = '/main/cart';
	})
	$("#nav5").click(function(){
		window.location.href = '/main/point';
	})
	$("#nav6").click(function(){
		var popupX = (window.screen.width / 2) - (200 / 2) - 150;
		var popupY= (window.screen.height / 2) - (300 / 2) - 50;
		openDialog('/main/leave', '회원탈퇴', 'width=500, height=300, menubar=no, status=no, scrollbars=no, toolbar=no, left=' + popupX + ' ,top=' + popupY, function(win){
			if($('#sessionHidden').val()=="logout"){
				window.location.href="/main/logout";
			}
		});  
	})
})

//팝업 오픈 및 팝업 닫힐때 콜백실행
var openDialog = function(uri, name, options, closeCallback) {
    var win = window.open(uri, name, options);
    var interval = window.setInterval(function() {
        try {
            if (win == null || win.closed) {
                window.clearInterval(interval);
                closeCallback(win);
            }
        }
        catch (e) {
        }
    }, 1000);
    return win;
};
</script>
</html>