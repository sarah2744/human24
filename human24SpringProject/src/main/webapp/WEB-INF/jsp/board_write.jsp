<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_write.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
</head>
<script>
</script>
<body>
<jsp:include page="header.jsp" flush="true" />
   <div id="wrap" class="w3-container">
      <h1 id="title"></h1>
      <form>
      <table id="boardtbl">
         <tr>
            <td>* 제목</td>
            <td><input type="text" id="inputtitle" ></td>
         </tr>
         <tr>
            <td>* 내용</td>
            <td><textarea name="contents" id="contents" cols="30" rows="10"></textarea></td>
         </tr>
         <tr>
            <td>파일 첨부</td>
            <td><input type="file"></td>
         </tr>
         <tr>
            <td colspan=2><input type="button" value="작성" class="btn" id="writebtn">
               <input type="button" value="이전" class="btn"
               onclick="window.history.go(-1)"></td>
         </tr>
      </table>
      </form>
   </div>
   <input type="hidden" value="${board_index}" id="hid">
   <input type="hidden" value="${dap_yn}" id="dap_yn">
   <jsp:include page="footer.jsp" flush="true" />
</body>
<script type="text/javascript">
//유저정보 저장
	var user_email;
	var user_mobile;
$(function(){
   var board_index = $('#hid').val();
   var dap_yn = $("#dap_yn").val();
   


    $.ajax({
		url : '${pageContext.request.contextPath}/modify/userinfo?userId='+userid,		
			type : 'get',
		success : function(data) {
			console.log(data);
			user_email = data[0].mail
			user_mobile = data[0].mobile
			console.log(user_email);
		}, error : function() {
			console.log("실패");
		}
	});
   // 기본 입력창인지 config으로 변경된 입력창인지 변수 초기화 작업 
   var transaction = true;
   var jud_write = false;
   var jud_mobile = false;
   var jud_email = false;
   var jud_security = false;
   $.ajax({
		url : '${pageContext.request.contextPath}/board/writeConfigView?boardIndex='+board_index,		
			type : 'get',
		success : function(data) {
			console.log(data);
			   $("#title").text(data[0].board_name);
			   
			   //****boardconfig***

			   // 작성자 입력창
			   if(data[0].writer_compl == "Y"){
				   	console.log('작성자 허용')
					var trleng =($("#boardtbl tr").length-3)
				   $('#boardtbl tr:eq("'+trleng+'")').before('<tr><td>작성자</td><td>'+
						   '<input type="radio" id="id_writer_realname" name="writer_name" value="name" checked><label for="id_writer_name">실명</label>'+
						   '<input type="radio" id="id_writer_custum_name" name="writer_name" value="custum_name"><label for="id_writer_custum_name">가명</label>'+
						   '<input type="text" id="txtWriter" placeholder="입력해주세요" ></td></tr>');
				   	transaction = false;
				    jud_write = true;
				    $('#txtWriter').val(userid).attr("readonly", true);
;
			   }else{
				   console.log('작성자 불가')
			   }
			   // 연락처 입력창
			   if(data[0].mobile_compl == "Y"){
				var trleng =($("#boardtbl tr").length-3)
				   console.log('연락처 허용')
				   $('#boardtbl tr:eq("'+trleng+'")').before('<tr><td>연락처</td>'+
						   '<td><input type="radio" id="id_writer_mobile" name="writer_mobile" value="mobile" checked><label for="id_writer_mobile">유저</label>'+
						   '<input type="radio" id="id_writer_custum_mobile" name="writer_mobile" value="custum_mobile"><label for="id_writer_custum_mobile">새로 작성</label>'+
						   '<input type="text" id="txtMobile" placeholder="입력해주세요" ></td></tr>')
					transaction = false;
					jud_mobile = true;
					$('#txtMobile').val(user_mobile).attr("readonly", true);
			   }else{
				   console.log('연락처 불가')
			   }
			   // 이메일 입력창
			   if(data[0].email_compl == "Y"){
				   var trleng =($("#boardtbl tr").length-3)
				   console.log('이메일 허용');
				   $('#boardtbl tr:eq("'+trleng+'")').before('<tr><td>이메일</td>'+
						   '<td><input type="radio" id="id_writer_email" name="writer_email" value="email" checked><label for="id_writer_email">정보조회</label>'+
						   '<input type="radio" id="id_writer_custum_email" name="writer_email" value="custum_email"><label for="id_writer_custum_email">직접입력</label>'+
						   '<input type="text" id="txtEmail" placeholder="입력해주세요" ></td></tr>')
					transaction = false;
				   	jud_email = true;
				   	$('#txtEmail').val(user_email).attr("readonly", true);
			   }else{
				   console.log('이메일 불가');
			   }
			    // 비밀글 입력창 
			   if(data[0].security_compl == "Y"){
				   var trleng =($("#boardtbl tr").length-3)
				   console.log('비밀글 허용');
				   $('#boardtbl tr:eq("'+trleng+'")').before('<tr><td>비밀글</td>'+
						   '<td><input type="checkbox" id="id_writer_checkbox" value="true"><label for="id_writer_checkbox">비밀글은 해당 작성자와 운영자(답글의 원글 작성자)만 볼 수 있습니다.</label></td></tr>')
					transaction = false;
				   	jud_security = true;
			   }else{
				   console.log('비밀글 허용');
			   }

		}, error : function() {
			console.log("실패");
		}
	});

   $(document).on("click", "#writebtn", function() {
      var title = $('#inputtitle').val();
      var contents = $('#contents').val();
      var board_index = $('#hid').val();
      if(transaction){
    	  // 기존 코드 변경없는 코드
	      window.location.href = "/main/write_board?title="+title+"&contents="+contents+"&board_index=" + board_index+"&dap_yn="+dap_yn;    	  
      }else if(transaction == false){
    	  //config 변경 코드
		var str = "/main/write_configBoard?title="+title+"&contents="+contents+"&board_index=" + board_index+"&dap_yn="+dap_yn;
		if(jud_write){
			var name = $('#txtWriter').val();
			str += "&nickname="+name;
		}
		if(jud_mobile){
			var mobile = $('#txtMobile').val();
			str += "&mobile="+mobile;
		}
		if(jud_email){
			var email = $('#txtEmail').val();
			str += "&email="+email;
		}
		if(jud_security){
			var sec_ok = $('#id_writer_checkbox').prop("checked");
			var security = 0;
			if(sec_ok == true){
				security = 1;
			}
			str += "&security="+security;
		}
		window.location.href = str;
      }
   })
})
$(document)
.on('click','#id_writer_realname',function(){
	$('#txtWriter').val(userid).attr("readonly", true);
})
.on('click','#id_writer_custum_name',function(){
	$('#txtWriter').val('').attr("readonly", false);
})
.on('click','#id_writer_mobile',function(){
	$('#txtMobile').val(user_mobile).attr("readonly", true);
})
.on('click','#id_writer_custum_mobile',function(){
	$('#txtMobile').val('').attr("readonly", false);
})
.on('click','#id_writer_email',function(){
	$('#txtEmail').val(user_email).attr("readonly", true);
})
.on('click','#id_writer_custum_email',function(){
	$('#txtEmail').val('').attr("readonly", false);
})
</script>
</html>