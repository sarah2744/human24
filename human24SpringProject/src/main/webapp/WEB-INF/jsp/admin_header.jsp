<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_header.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
<title>Insert title here</title>
<%String admin_id = (String) session.getAttribute("admin_id"); %>
<script>
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
</script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <div id="wrap">
        <div id="top">
            <div id="logo">
                <h1>Human 24</h1>
                <p id="hello"><span id="adminId"><%=admin_id%></span> 님 반갑습니다. <span id="logout">로그아웃</span></p>
            </div>
            <input type = "hidden" id="loginyn" value=<%=admin_id%>>
            <div id="mainMenu">
                <ul>
                    <li id="tong" onclick="window.location.href='/main/admin/statistics/user'">통계보기</li>
                    <li id="bookManage" onclick="window.location.href='/main/admin/book/list'">도서관리</li>
                    <li id="userManage" onclick="window.location.href='/main/admin/user/list'">회원관리</li>
                    <li id="boardManage" onclick="window.location.href='/main/admin/board/list'">게시판관리</li>
                </ul>
            </div>
        </div>
    </div>
</body>
<script>
	$(function(){
		if($("#loginyn").val() == "null"){
			alert("로그인 후 이용 가능합니다.");
			window.location.href="/main/admin/login";
		}else{
			$("#hello").css("display","block");
		}
		
		$("#logout").click(function(){
			alert("로그아웃 되었습니다.");
			window.location.href = "/main/logout?id=admin" 
		})
	})
</script>
</html>