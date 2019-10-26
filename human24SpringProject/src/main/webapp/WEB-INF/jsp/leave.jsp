<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/leave.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>회원 탈퇴</title>
</head>
<body>
	<%String userid = (String) session.getAttribute("userid"); %>
	<input type = "hidden" id="loginyn" value=<%=userid%>>	
	<div id="wrap">
		<h1>회원 탈퇴</h1>
		비밀번호 : <input type="password" id="pwd">
		<div id="btnDiv">
			<input type="button" value="회원 탈퇴" id="tt" class="btn"> <input
				type="button" value="취소" id="cancel" class="btn"
				onclick="javascript:self.close();">
		</div>
	</div>
</body>
<script>
	$(function() {
		var judge = false;
		$("#tt").click(function() {
			var yn = confirm("탈퇴하면 복구할 수 없습니다. 정말 탈퇴하시겠습니까?");
			if (yn) {
				$.ajax({
					url : "${pageContext.request.contextPath}/passUpdate/passCheck?&userId="+$('#loginyn').val(),
					type : 'get',
					success : function(data) {
						if($('#pwd').val()==data){
							$.ajax({
								url : "${pageContext.request.contextPath}/leave/Submit?userPwd="+$('#newPass2').val()+"&userId="+$('#loginyn').val(),
								type : 'get',
								success : function(data) {
									if(confirm('성공적으로 탈퇴하였습니다 휴먼24를 이용해주셔서 감사합니다')==true){
							            opener.document.getElementById("sessionHidden").value = 'logout';
										window.close();
										return judge = true;
									}
								}, error : function() {
									console.log("실패");
								}
							})
						}else{
							alert('비밀번호가 틀립니다 다시한번 확인해주세요');
						}
					}, error : function() {
						console.log("실패");
					}
				})
			} else {
				self.close();
			}
		})
	})
</script>
</html>