<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/7cc56f1dc7.js"></script>
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<%String userid = (String) session.getAttribute("userid"); %>
<title>header</title>
<script>
var weekyn = new Date().getDay();
function showStar(n){
	var star="";
	var gradeNum = Math.round(n);
	for(var i = 0; i < gradeNum; i++){
		star += "★";
	}	
	document.write(star);
}
function showGrayStar(n){
	var star="";
	var gradeNum = 0
	if(n == 0.5 || n == 1.5 || n == 2.5 || n == 3.5 || n == 4.5) gradeNum = Math.floor(n);
	else gradeNum = Math.round(n);
	for(var i = 0; i < gradeNum; i++){
		star += "★";
	}
	document.write(star);
}
function showStarDetail(n){
	var gradeNum = Math.round(n);
	var star="";
	for(var i = 0; i < gradeNum; i++){
		star += "★";
	}	
	return star;
}
</script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<div id="wrap">	
		<input type = "hidden" id="loginyn" value=<%=userid%>>
		<script>
			var userid = $("#loginyn").val();
		</script>
        <div id="subMenu">
            <ul id = "subMenuUl" class="subMenuUlClass">
                <li><a href = "/main/mypage">마이페이지</a></li>
                <li><a href = "/main/cart">장바구니</a></li>
                <li><a href = "/main/order">주문 / 배송</a></li>
                <li><a href = "/main/board?board_index=1&nowPage=1">고객센터</a></li>
                <li><a href = "/main/logout?id=user">로그아웃</a></li>
            </ul>
            <ul id = "subMenuUlnoLog" class="subMenuUlClass">
                <li><a href = "/main/main">로그인</a></li>
                <li><a href = "/main/join_check">회원가입</a></li>
            </ul>
        </div>
        <div id="logoSearchDiv">
            <div id="logoDiv">
                <a href="/main/main">
                    <h1 class="animated bounce delay-1s slow" id = "logo">Human 24</h1>
                </a>
            </div>
            <div id="searchDiv">
                <input type = "text" id="schBar" autocomplete="off">
                <i class="fas fa-search" id = "schIcon"></i>
            </div>
        </div>        
        <div id = "mainMenu">
            <ul>
                <li><a href="/main/main">HOME</a></li>
                <li><a href="/main/store">스토어</a></li>
                <li><a href="/main/best">베스트</a></li>
                <li><a href="/main/used">중고상점</a></li>
                <li><a href="#" id="weekDisPage">주말특가</a></li> <!-- 주말에만 접근 가능 -->
                <li><a href="/main/attendance_check">출석체크</a></li>
                <li><a href="/main/board?board_index=2&nowPage=1">공지사항</a></li>
            </ul>
        </div>
    </div>
</body>
<script>
function loginYN(){ // 로그인 유무 check function
	if(userid == null || userid == "" || userid == "undefined" || userid == "null"){
		return false;		
	}else{
		return true;
	}
}
function goLogin(){ // 로그인 화면 이동 function
	var logYn = confirm("로그인 후 사용 가능합니다. \n로그인 페이지로 이동하시겠습니까?");
	if(logYn){
		location.href = "main";
	}else{
		return false;
	}
}
function AddComma(data_value) {
	return Number(data_value).toLocaleString('en');
}
$(function(){
	
	if($("#loginyn").val() != "null"){ // login 성공
		$("#subMenuUlnoLog").css("display","none");
		$("#subMenuUl").css("display","block");
	}
	$("#weekDisPage").click(function(){
		if(weekyn != 0 && weekyn != 6) {
			alert("주말특가이벤트는 주말에만 진행합니다."); 
			return false;
		}
		else location.href = "/main/weekDiscount";
	})
	$("#schIcon").click(function(){
		var searchText = $("#schBar").val();
		searchText = searchText.toLowerCase();
		if(searchText != "" && searchText != null) location.href = '/main/search?searchText='+searchText;
		else{
			alert("검색어를 입력해주세요."); 
		}
	})
	$("#schBar").keydown(function(key) {
		if (key.keyCode == 13) {
			$("#schIcon").trigger("click");
        }
	});
})
</script>
</html>