<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" META HTTP-EQUIV="refresh" CONTENT="3000">
<title></title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_detail_page.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/detail.css">
<script type="text/javascript" src="https://cdn.emailjs.com/sdk/2.3.2/email.min.js"></script>
<script src="https://kit.fontawesome.com/7cc56f1dc7.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
</head>
<body>
   <jsp:include page="header.jsp" flush="true" />
   <div id="wrap" class="w3-container">
      <h1 id="title" style="font-size: 36px; font-weight: normal;"></h1>
      <table id="boardtbl">
         <tr id="title">
            <td>* 제목</td>
            <td>${board_detail.title}</td>
         </tr>
         <tr id="writer">
         	<td>작성자</td>
         	<td>${board_detail.user_id}</td>
         </tr>
         <tr id="update">
         	<td>작성일자</td>
         	<td>${board_date}</td>
         </tr>
         <c:if test ="${board_detail.mobile ne null}">
	         <tr>
	       		<td>연락처</td>
	         	<td>${board_detail.mobile}</td>
	         </tr>
         </c:if>
         <c:if test ="${board_detail.email ne null}">
	         <tr>
	       		<td>이메일</td>
	         	<td id="userEmail">${board_detail.email}</td>
	         </tr>
         </c:if>
		 <tr>
		 	<td>조회수</td>
         	<td>${views}</td>
		 </tr>
         <tr>
            <td>* 내용</td>
            <td>${board_detail.contents}</td>
            <input type="hidden" value="${board_detail.board_num}" id="board_num">
         </tr>
         <tr>
            <td colspan=2>
            	<input type="button" value="수정" class="btn" id="Upbtn" class="onlyWriter">
            	<input type="button" value="삭제" class="btn" id="Debtn" class="onlyWriter">
            	<input type="button" value="답글달기" class="btn" id="dap">
                <input type="button" value="이전" class="btn" onclick="window.history.go(-1)">
            </td>
         </tr>
      </table>
      <div id="comlistdiv">
	      <input type="text" id="txtComment"><input type="button" id="btnWrite" value="작성" class="btn">
		  <table id="commenttbl" class="w3-table">
			 <tr id="commentTh">
				<th>작성자</th>
				<th>내용</th>
				<th>작성일</th>
				<th></th>
			 </tr>
		  </table>
      </div>
   </div>
   <jsp:include page="footer.jsp" flush="true" />
   <input type="hidden" value="${board_index}" id="hid">
</body>
<script type="text/javascript">
var reComNum = 0;
var commentNum = 0;
var board_index = $('#hid').val();
var board_num = $('#board_num').val();
var board_name = "" 
//답글 권한 변수 초기화
var commentAuth = false;

//날짜 sysdate 출력 형식에 맞게 변환
function digitalDate() {
	var now = new Date();
	var year = String(now.getFullYear()), month = String(now.getMonth() + 1), date = String(now
			.getDate()), hours = String(now.getHours()), minutes = String(now
			.getMinutes()), seconds = String(now.getSeconds());

	if (month.length == 1) {
		month = "0" + month;
	} else if (date.length == 1) {
		date = "0" + date;
	} else if (hours.length == 1) {
		hours = "0" + hours;
	} else if (minutes.length == 1) {
		minutes = "0" + minutes;
	} else if (seconds.length == 1) {
		seconds = "0" + seconds;
	}

	return year + '-' + month + '-' + date + " " + hours + ":" + minutes
			+ ":" + seconds;
}
$(function(){	
   $.ajax({
	   url : '${pageContext.request.contextPath}/board/boardControll?boardIndex='+$("#hid").val() ,
		type : 'get',
		success : function(data) {
			console.log(data);
			console.log()
			 $("#title").text(data[0].board_name);
			   $(document).attr("title", data[0].board_name + " - Human24");

			 //답글 허용에 따른 버튼 활성화
			 if(data[0].reply_compl == "Y"){
				 $("#dap").css("display", "inline");
			 }else{
				 $("#dap").css("display", "none");
			 }
			 console.log(data[0].comment_compl);
			 
			 
			 if(data[0].comment_compl == "Y"){
				 $.ajax({
						url : '${pageContext.request.contextPath}/board_detail_page/CommentList?boardIndex='+$("#hid").val()+'&boardNum='+$("#board_num").val(),
						type : 'get',
						success : function(data) {
							for(var i=0; i<data.length; i++){
								if(userid == data[i].user_id){
									if(data[i].dap_yn == 0){
										console.log("댓글")
										$('#commenttbl').append('<tr><td class="userName">'+data[i].user_id+'</td><td>'+data[i].comments+'</td><td style="text-align : center">'+data[i].write_date+'</td><td><input type="button" value="답글" class="comReply btn2"><input type="button" value="삭제" class="comDel btn2"><input type="hidden" class="comNum" value="'+data[i].comment_num+'"></td></tr>');													
									}else{
										console.log("댓댓글")
										$('#commenttbl').append('<tr style="background-color : rgb(231, 231, 231)"></td><td class="userName"> <i class="fab fa-replyd fa-2x"></i>  '+data[i].user_id+'</td><td>'+data[i].comments+'</td><td style="text-align : center">'+data[i].write_date+'</td><td><input type="button" value="답글" class="comReply btn2"><input type="button" value="삭제" class="comDel"><input type="hidden" class="comNum" value="'+data[i].comment_num+'"></td></tr>');													
									}
								}else{
									if(data[i].dap_yn == 0){
										console.log("댓글")
										$('#commenttbl').append('<tr><td class="userName">'+data[i].user_id+'</td><td>'+data[i].comments+'</td><td style="text-align : center">'+data[i].write_date+'</td><td><input type="button" value="답글" class="comReply btn2"><input type="button" value="삭제" class="comDel btn2"><input type="hidden" class="comNum" value="'+data[i].comment_num+'"></td></tr>');													
									}else{
										console.log("댓댓글")
										$('#commenttbl').append('<tr style="background-color : rgb(231, 231, 231)"></td><td class="userName"> <i class="fab fa-replyd fa-2x"></i>  '+data[i].user_id+'</td><td>'+data[i].comments+'</td><td style="text-align : center">'+data[i].write_date+'</td><td><input type="button" value="답글" class="comReply btn2"><input type="button" value="삭제" class="comDel"><input type="hidden" class="comNum" value="'+data[i].comment_num+'"></td></tr>');													
									}
								}
							}
						}, error : function() {
							console.log("실패");
						}
				 })
			 }else{}
		}, error : function() {
		}
   })
   $("#comlistdiv").css("display", "block"); 
   if(userid != "${board_detail.truename}"){
	   $("#Upbtn").hide();
	   $("#Debtn").hide();	
   }
   $(document)
   .on("click", "#Upbtn", function() {
		window.location.href = "/main/board_write2?board_num=" + board_num + "&board_index="+board_index;
   })
   .on("click", "#Debtn", function(){
      $.ajax
      ({
         url : '${pageContext.request.contextPath}/board_delete?board_num='+ board_num+'&board_index='+board_index,
         type : 'get',
         success : function(data) 
         {
            alert("삭제완료");
            window.location.href = "/main/board?board_index="+board_index;
         }, 
         error : function() 
         {
            alert("앙대");
           }
      })
   })
   .on("click","#dap",function(){
	   window.location.href = '/main/board_write?board_index=' + board_index+"&dap_yn="+board_num;
   })
   .on('click','#btnWrite',function(){
	  $.ajax({
		  url : '${pageContext.request.contextPath}/board/boardControll?boardIndex='+$("#hid").val(),		
			type : 'get',
		success : function(data) {
			var emailOk = data[0].email_receive
			if(emailOk ==  "Y"){
				var emailC = {
			            to_name: "귀하의 게시글에 댓글이 달렸습니다.",
			            context: '귀하의 글에 댓글이 달렸습니다.',
			            give_man: $('#userEmail').text()
					}
					emailjs.init("user_hulDFJsMY0GjWW7BMW50I");
					emailjs.send("gmail", "template_q8iakN6E", emailC)
					.then(function (response) {
						console.log("SUCCESS. status=%d, text=%s", response.status, response.text);
					}, function (err) {
						console.log("FAILED. error=", err);
					});		
			}
		}, error : function() {
		console.log("실패");
		}
	  })
		$.ajax({
			url : '${pageContext.request.contextPath}/board_detail_page/CommentWrite?boardIndex='+$("#hid").val()+'&boardNum='+$("#board_num").val()+'&userName='+userid+'&comments='+$("#txtComment").val(),		
					type : 'get',
			success : function(data) {
				$('#commenttbl').append('<tr><td>'+userid+'</td><td>'+$("#txtComment").val()+'</td><td style="text-align : center">'+digitalDate()+'</td></tr>');
				$('#txtComment').val('');
				window.location.reload(true);
			}, error : function() {
				console.log("실패");
			}
		});
	})
	.on('click','.comDel',function(){ //eo
		var indexNum = $('.comDel').index(this)+1;
		var commentNum = String($('#commenttbl tr:eq("'+indexNum+'") .comNum').val());
		console.log(commentNum);
			if(confirm("정말 삭제하시겠습니까?") == true){
				console.log("commentNum="+commentNum);
				$.ajax({
					url : '${pageContext.request.contextPath}/board_detail_page/CommentErase?comNum='+commentNum+'',		
							type : 'get',
					success : function(data) {
						$('#commenttbl tr:eq("'+indexNum+'")').remove();
					}, error : function() {
						console.log("실패");
					}
				});
			}else{
				
			}
	})
 	.on('click','.comReply',function(){
		reComNum = $('.comReply').index(this)+1;
		commentNum = String($('#commenttbl tr:eq("'+reComNum+'") .comNum').val());
		comNum = $('.comNum').index(this)+1;
		comNum = $()
		$('#commenttbl tr:eq("'+reComNum+'")').after('<tr><td colspan="5"><input type="text" id="txtReply"><input type="button" id="btnReSubmit" value="작성" class="btn2 reBtn"><input type="button" id="btnReCancel" value="취소" class="btn2 reBtn"></td></tr>');
		$('.comReply').click(function(){
			$('#iptRe').remove();
		})
	})
	.on('click','#btnReSubmit',function(){
		$.ajax({
			url : '${pageContext.request.contextPath}/board_detail_page/CommentReWrite?boardIndex='+$("#hid").val()+'&boardNum='+$("#board_num").val()+'&userName='+userid+'&comments='+$("#txtReply").val()+'&comNum='+commentNum,		
					type : 'get',
			success : function(data) {
				window.location.reload(true);
			}, error : function() {
				console.log("실패");
			}
		});
	})
})
</script>
</html>