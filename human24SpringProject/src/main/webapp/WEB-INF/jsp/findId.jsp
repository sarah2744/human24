<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findId.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	<script type="text/javascript" src="https://cdn.emailjs.com/sdk/2.3.2/email.min.js"></script>
</head>
<body>
	<div id="wrap">
		<h1>아이디 찾기</h1>
		이메일 : <input
			type="text" id="email_1"> @ <input type="text" id="email_2">
		<div id="btnDiv">
			<input type="button" value="찾기" id="btnEmailGo" class="btn"> <input
				type="button" value="취소" id="cancel" class="btn"
				onclick="javascript:self.close();">
		</div>
	</div>
</body>
<script>
$(document).on('click','#btnEmailGo',function(){
	$.ajax({
		url : '${pageContext.request.contextPath}/findId/Submit?mail='+$("#email_1").val() + '@' + $("#email_2").val()+'',
		type : 'get',
		success : function(data) {
		    	var emailC = {
		    	      	to_name: '귀하의 이메일을 확인하여주십시오',
		    	        context: '귀하의 아이디는 '+ data +'입니다.',
		    	        give_man: String($('#email_1').val() + "@" + $('#email_2').val())
		    		}
		    	emailjs.init("user_hulDFJsMY0GjWW7BMW50I");
		    	emailjs.send("gmail", "template_q8iakN6E", emailC)
		    	.then(function (response) {
		    	console.log("SUCCESS. status=%d, text=%s", response.status, response.text);
		    	}, function (err) {
		    	console.log("FAILED. error=", err);
		    	});
		}, error : function() {
			console.log("실패");
		}
	});	
})
</script>
</html>