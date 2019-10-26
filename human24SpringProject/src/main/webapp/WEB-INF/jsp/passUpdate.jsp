<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/passUpdate.css">
</head>
<%String userid = (String) session.getAttribute("userid"); %>
<body>
<input type = "hidden" id="loginyn" value=<%=userid%>>
	<div id="wrap">
		<h1>비밀번호 변경</h1>
		기존 비밀번호 : <input type="password" id="oldPass" onkeyPress="if (event.keyCode==32) event.returnValue=false;"><br>
		새 비밀번호 : <input type="password" id="newPass1" onkeyPress="if (event.keyCode==32) event.returnValue=false;"><br>
		새 비밀번호 확인 : <input type="password" id="newPass2" onkeyPress="if (event.keyCode==32) event.returnValue=false;">
		<div id="btnDiv">
			<input type="button" value="변경" id="btnUpdate" class="btn"> <input
				type="button" value="취소" id="cancel" class="btn"
				onclick="javascript:self.close();">
		</div>
	</div>
</body>
<script type="text/javascript">
function PasswordCheck(){
	if($('#newPass1').val() == $('#newPass2').val() && $('#newPass1').val() != ''){
		console.log('true');
		return newPassOk = true;
	}else{
		console.log('false');
		return newPassOk = false;
	}
}
var	newPassOk = false;
$(document)
.on('blur','#newPass1',function(){
	PasswordCheck();
})
.on('blur','#newPass2',function(){
	PasswordCheck();	
})
.on('click','#btnUpdate',function(){
	$.ajax({
		url : '${pageContext.request.contextPath}/passUpdate/passCheck?userId='+$('#loginyn').val(),
		type : 'get',
		success : function(data) {
			if($('#oldPass').val() == data && newPassOk == true){
				$.ajax({
					url : "${pageContext.request.contextPath}/passUpdate/Submit?userPwd="+$('#newPass2').val()+"&userId="+$('#loginyn').val(),
					type : 'get',
					success : function(data) {
						if(confirm('귀하의 비밀번호를 수정 완료하였습니다 홈페이지로 이동합니다')) window.close();
					}, error : function() {
						console.log("실패");
					}
				})
			}
		}, error : function() {
			console.log("실패");
		}
	})
})

</script>
</html>