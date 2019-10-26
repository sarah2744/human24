<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_header.css">
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
<title>회원관리</title>
</head>
<script>
	var admin_index = ${admin_index};
	var age = 0;
	var thisDate = new Date();
	var thisYear = thisDate.getFullYear();
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<jsp:include page="admin_header.jsp" flush="true" />
<div id="wrap">
        <div id="wrapping">
            <div id="subMenu">
                <ul>
                    <li onclick="window.location.href='/main/admin/user/list?admin_index=0'" id="userListLink">회원 리스트</li>
                    <li onclick="window.location.href='/main/admin/user/list?admin_index=2'" id="blackListLink">블랙리스트</li>
                    <li onclick="window.location.href='/main/admin/user/list?admin_index=1'" id='adminListLink'>관리자 리스트</li>
                </ul>
            </div>
            <section>
                <div id="section">
                    <div id="shadowDiv" style="margin-bottom:50px;">
                        <div id="titleDiv">
                            <h1>관리자 > 회원관리 > <span id="titleSpan"></span></h1>
                        </div>
                        <div id="searchDiv">
							<select id="schSelect" class="searchField">
								<option value="user_id">아이디</option>
								<option value="user_name">이름</option>
                        	</select> 
	                        <input type="text" placeholder="search" class="searchField" id="searchField">
	                        <button id="schBtn"><i class="fas fa-search"></i></button>
	                    </div> 
                        <table id="listTbl" style="width:100%;">
                            <thead>
                                <tr>
                                    <th>이름(아이디)</th>
                                    <th>성별</th>
                                    <th>나이</th>
                                    <th>연락처</th>
                                    <th>생년월일</th>
                                    <th>등록일</th>
                                    <th>권한</th>
                                    <th colspan="2"></th>
                                </tr>
                            </thead>
                            <tbody>
	                            <c:forEach items="${memberList}" var="com" varStatus="status">
							        <tr>
							        
							        	<td><b>${com.user_name}(${com.user_id})</b></td>
							        	<td>${com.gender}</td>
							        	<td>
							        		<script>
							        			var birth = "${com.birth}";
							        			var year = birth.substr(0,4);
							        			age = thisYear - year +1;
							        			document.write('<p>' + age + '</p>');
							        		</script>
							        	</td>
							        	<td>${com.mobile}</td>
							        	<td>${com.birth}</td>
							        	<td>20190930</td>
							        	<td class="rankText">회원</td>
							        	<td id="inputTd">
							        		<script>
							        			admin_index = ${com.admin_index};
							        			if(admin_index == 0)
							        			{
							        				document.write('<input type="button" value="관리자 권한 부여" userid="${com.user_id}" class="btn2" id="adminAddBtn" ><input type="button" value="블랙리스트 추가" userid="${com.user_id}" class="btn2" id="blackAddBtn">');
							        			}else if(admin_index == 2){
							        				document.write('<input type="button" value="블랙리스트 해제" userid="${com.user_id}" class="btn2" id="blackDelBtn">');
							        			}else if(admin_index == 1){
							        				document.write('<input type="button" value="관리자 권한 해제" userid="${com.user_id}" class="btn2" id="adminDelBtn">');
							        			}
							        				
							        		</script>
							        		<input type="button" value="상세보기" class="btn2 goDetail" userid="${com.user_id}">
							        	</td>
							        </tr>
						        </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div id="listPageDiv" style="margin-bottom: 100px;">
                        <ul id="listPage">
						  <li class="first"><<</li>
						  <li class="before"><</li>
						  <li class="after">></li>
						  <li class="last" disabled>>></li>
                        </ul>
                    </div>
                </div>
            </section>
        </div>
        <div class="clear"></div>
    </div>
    <input type="hidden" value="${admin_index}" id="admin_index">
    <input type="hidden" value="${totalPage}" id="totalPage">
    <input type="hidden" value="${nowPage}" id="nowPage">
</body>
<script>
$(function(){
	$("#userManage").addClass("mainOn");
	
	var admin_index = $("#admin_index").val();
	var totalPage = $("#totalPage").val();
	var nowPage = $("#nowPage").val();
	
	if(admin_index == 0) {
		$("#userListLink").addClass("subOn");
		$("#titleSpan").text("회원 리스트")
	}else if(admin_index == 1) {
		$("#adminListLink").addClass("subOn");
		$("#titleSpan").text("관리자 리스트")
	}else if(admin_index == 2) {
		$("#blackListLink").addClass("subOn");
		$("#titleSpan").text("블랙 리스트")
	}
	
	// 페이징 ////////////////////////////////////////////////////////////////
	
	var pagePrint = 0;
	   
    if(nowPage%5==0) pagePrint = parseInt(nowPage / 5);
    else pagePrint = parseInt(nowPage / 5) + 1;
   
    if(5*pagePrint > totalPage){
	    for(var i = totalPage; i>= (5*pagePrint)-4; i--){
	 	   $(".before").after("<li class = page value="+i+">"+i+"</li>");
	    }	   
    }else{
	    for(var i = 5*pagePrint; i>= (5*pagePrint)-4; i--){
		   $(".before").after("<li class = page value="+i+">"+i+"</li>");
	    }   
    }
   
    $("#listPage li[value="+nowPage+"]").css({"background-color":"black", "color" : "white"});
   
    $("#listPage li").each(function(){ // 페이지 이동
	    $(this).click(function(){
			if($(this).hasClass("first") || $(this).hasClass("before")){
				if(nowPage == 1) alert("첫번째 페이지입니다.");
				else{
					if($(this).hasClass("first")) location.href='/main/admin/user/list?admin_index='+admin_index+'&nowPage=1'
					else if($(this).hasClass("before")) location.href='/main/admin/user/list?admin_index='+admin_index+'&nowPage='+(nowPage-1)
				}
			}else if($(this).hasClass("after") || $(this).hasClass("last")){
				if(nowPage == totalPage) alert("마지막 페이지입니다.");
				else{
					if($(this).hasClass("after")) location.href='/main/admin/user/list?admin_index='+admin_index+'&nowPage='+((nowPage*1)+1)
						else if($(this).hasClass("last")) location.href='/main/admin/user/list?admin_index='+admin_index+'&nowPage='+totalPage
					}
				}else if($(this).hasClass("page")) {
					location.href='/main/admin/user/list?admin_index='+admin_index+'&nowPage='+($(this).attr('value'));
				}
		})
	})
	
	////////////////////////////////////////////////////////////////////////
	$("#adminAddBtn").click(function(){
		var user_id = $(this).attr("userid");
		$.ajax
		({
		   url : '${pageContext.request.contextPath}/admin/rank?admin_index=1&user_id='+ user_id,
		   type : 'get',
		   success : function(data) 
		   {
			  alert("관리자 권한이 부여되었습니다.");
			  window.location.reload(true);
		   },
		   error : function() 
		   {
		      alert("실패");
		   }
		})
	})
	$("#blackAddBtn").click(function(){
		var user_id = $(this).attr("userid");
		$.ajax
		({
		   url : '${pageContext.request.contextPath}/admin/rank?admin_index=2&user_id='+ user_id,
		   type : 'get',
		   success : function(data) 
		   {
			  alert("블랙리스트로 등록되었습니다.");
			  window.location.reload(true);
		   },
		   error : function() 
		   {
		      alert("실패");
		   }
		})
	})
	$("#adminDelBtn").click(function(){
		var user_id = $(this).attr("userid");
		$.ajax
		({
		   url : '${pageContext.request.contextPath}/admin/rank?admin_index=0&user_id='+ user_id,
		   type : 'get',
		   success : function(data) 
		   {
			  alert("관리자 권한이 해제되었습니다.");
			  window.location.reload(true);
		   },
		   error : function() 
		   {
		      alert("실패");
		   }
		})
	})
	$("#blackDelBtn").click(function(){
		var user_id = $(this).attr("userid");
		$.ajax
		({
		   url : '${pageContext.request.contextPath}/admin/rank?admin_index=0&user_id='+ user_id,
		   type : 'get',
		   success : function(data) 
		   {
			  alert("블랙리스트가 해제되었습니다.");
			  window.location.reload(true);
		   },
		   error : function() 
		   {
		      alert("실패");
		   }
		})
	})
	$("#searchField").keydown(function(key) {
		if (key.keyCode == 13) {
			$("#schBtn").trigger("click");
        }
	})	
	$("#schBtn").click(function(){
		window.location.href = "/main/admin/user/list?sel="+$("#schSelect option:selected").val()+"&schText="+$("#searchField").val()+"&admin_index="+admin_index;
	})	
	$(".goDetail").click(function(){
		var user_id = $(this).attr("userid");
		window.location.href = "/main/admin/user/detail?user_id="+user_id;
	})
})
</script>
</html>