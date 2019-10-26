<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title></title>
<script>
   var totalPage = ${totalPage};
   var nowPage = ${nowPage};
   var tmp = 0;
</script>
</head>
<body>
   <jsp:include page="header.jsp" flush="true" />
   <div id="wrap" class="w3-container">
      <h1 id="title"></h1>
      <div id="write">
         <input type="button" value="글쓰기" id="writeBtn">
      </div>
      <table class="w3-table w3-bordered" id="boardTbl">
         <tr>
            <th></th>
            <th style="width: 50% !important;">제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>작성일</th>
         </tr>
         <c:forEach items="${Notice}" var="com" varStatus="status">
            <tr class="boardConTr" id="${com.board_num}">
               <td>
               		<script>
               			document.write(((nowPage*10)-9)+(tmp++));
               		</script>
               </td>
               <td>
               	<input type="hidden" class="userId" value="${com.truename}">
               		<script>
               			var index = ${status.index};
               			if(${com.dap_yn}==1){ // 답글
               				if((${com.sec_compl} == 1) && ($('.userId:nth-child('+index+')').val() != userid)){
	               					document.write('비밀글입니다.');               					
	               					$('#${com.board_num}').attr('id','se${com.board_num}');
                   			}else{
	               				document.write("${com.title}")               					
               				}
               			}else{ // 답글 X
               				if((${com.sec_compl} == 1) && ($('.userId:nth-child('+index+')').val() != userid)){
               					document.write('비밀글입니다.');  	             					
               					$('#${com.board_num}').attr('id','se${com.board_num}');
               			}else{
               				document.write("${com.title}")               					
           				}
               		}
               		</script>
               	</td>
               	
               <td class="writer">${com.user_id}</td>
               <td>${com.views}</td>
               <td class="writeDate">${com.board_date}</td>
            </tr>
         </c:forEach>
      </table>
      <ul id="listPage">
		  <li class="first"><<</li>
		  <li class="before"><</li>
		  <li class="after">></li>
		  <li class="last" disabled>>></li>
	  </ul>	
   </div>
   <input type="hidden" value="${board_index}" id="hid">
   <jsp:include page="footer.jsp" flush="true" />
</body>
<script>
//글쓰기 권한 변수 초기화
var writeAuthJudge = false;
$(function(){
   var board_index = $('#hid').val();   
  
   //게시판 컨트롤
   $.ajax({
		url : '${pageContext.request.contextPath}/board/boardControll?boardIndex='+board_index,		
			type : 'get',
		success : function(data) {
			console.log(data);
				//게시판 제목 보여주기
			   $("#title").text(data[0].board_name);
				
				//게시판 사용가능 여부 체크
			   if(data[0].presence === "N"){
				   $('#boardTbl').css("visibility","hidden");
				   $('#writeBtn').css("visibility","hidden");
			   }else{}
		}, error : function() {
			console.log("실패");
		}
	});
   
   //글쓰기 권한
   $.ajax({
		url : '${pageContext.request.contextPath}/board/boardWriteAuth?boardIndex='+board_index+'&userid='+userid,		
			type : 'get',
		success : function(data) {
			if(data == 0){
				writeAuthJudge = false;
			}else{
				writeAuthJudge = true;
			}
		}, error : function() {
			console.log("실패");
		}
	});
   
   $("#writeBtn").click(function(){
	  if(!loginYN()){
 		  goLogin();
 		  return false;
 	  }else if(writeAuthJudge==false){
 		  alert('사용자는 해당 게시판 글쓰기 권한이 없습니다.');
 	  }else{
      	  window.location.href = '/main/board_write?board_index=' + board_index+"&dap_yn=no";
 	  }
   })
   
   $('.boardConTr').click(function(){
	   var boardnum = $(this).attr("id");
	   if(boardnum.indexOf('se') == -1){ //비밀글인지 아닌지 체크
	       $.ajax({
	          url: '${pageContext.request.contextPath}/viewsPlus?boardnum='+boardnum,
	          type: "GET",
	       })
	       window.location.href = '/main/board_detail_page?boardnum='+boardnum+'&board_index='+board_index;		   
	   }else{}
   })	

   var pagePrint = 0;
   
   if(nowPage%5==0) pagePrint = parseInt(nowPage / 5);
   else pagePrint = parseInt(nowPage / 5) + 1;
   
   if(5*pagePrint > totalPage){
	   for(var i = totalPage; i>= (5*pagePrint)-4; i--){
		   $(".before").after("<li class = page value="+i+" board_index = "+board_index+">"+i+"</li>");
	   }	   
   }else{
	   for(var i = 5*pagePrint; i>= (5*pagePrint)-4; i--){
		   $(".before").after("<li class = page value="+i+" board_index = "+board_index+">"+i+"</li>");
	   }   
   }
   
   $("#listPage li[value="+nowPage+"]").css({"background-color":"black", "color" : "white"});
   
   $("#listPage li").each(function(){ // 페이지 이동
	    $(this).click(function(){
		if($(this).hasClass("first") || $(this).hasClass("before")){
			if(nowPage == 1) alert("첫번째 페이지입니다.");
			else{
				if($(this).hasClass("first")) location.href='/main/board?board_index='+board_index+'&nowPage=1'
				else if($(this).hasClass("before")) location.href='/main/board?board_index='+board_index+'&nowPage='+(nowPage-1)
			}
		}else if($(this).hasClass("after") || $(this).hasClass("last")){
			if(nowPage == totalPage) alert("마지막 페이지입니다.");
			else{
				if($(this).hasClass("after")) location.href='/main/board?board_index='+board_index+'&nowPage='+((nowPage*1)+1)
				else if($(this).hasClass("last")) location.href='/main/board?board_index='+board_index+'&nowPage='+totalPage
			}
		}else if($(this).hasClass("page")) {
			location.href='/main/board?board_index='+board_index+'&nowPage='+($(this).attr('value'));
		}
	})
  })
})
</script>
</html>