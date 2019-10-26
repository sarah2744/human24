<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_login.css">
<head>
<meta charset="EUC-KR">
<title>������ �α���</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
<script>
$(function(){
    $("#autoLogin").click(function(){
        var autoLogin = confirm("�ڵ��α����� ����Ͻø� �������� ȸ�����̵�� ��й�ȣ�� �Է��Ͻ� �ʿ䰡 �����ϴ�.\n\n������ҿ����� ���������� ����� �� ������ ����� �����Ͽ� �ֽʽÿ�.\n\n�ڵ��α����� ����Ͻðڽ��ϱ�?")
        if(!autoLogin){
            $("#autoLogin").prop("checked", false);
        }
    })
})
</script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <div id="wrap">
        <div id="loginDiv">
            <p id="logo">
            	<h1 id="logoText">
            		Human 24<br>
            		<span style="font-size: 17px; font-weight: bold;">������ �α���</span>
            	</h1>
            </p>
            <form action="adminLogin" method="post" id="loginForm">
                <p class="inputP"><i class="fas fa-user"></i><input type="text" name = "admin_id" id="userid" placeholder="���̵� �Է��ϼ���." class="input" autocomplete="off"></p>
                <p class="inputP" style="margin-bottom: 30px;"><i class="fas fa-lock"></i><input type="password" name = "pwd" id="pwd" placeholder="��й�ȣ�� �Է��ϼ���" class="input"></p>
	            <p><input type="button" value="LOGIN" id="loginBtn"></p>
            </form>
        </div>
    </div>
</body>
<script>
$(function(){
	$("#loginBtn").click(function(){
		if($("#userid").val()=="" || $("#pwd").val()=="") {
			alert("���̵� Ȥ�� ��й�ȣ�� �Է����ּ���.");
			return false;
		}else{
	  	    $.ajax({
				url : "${pageContext.request.contextPath}/main/admin/loginCheck?admin_id="+$('#userid').val()+"&userPwd="+$('#pwd').val(),
				type : 'get',
				success : function(data) {
					if(data == 1){
				         $("#loginForm").submit();						
					}else{
						alert('�α��ο� �����Ͽ����ϴ�')
						$('#loginPwd').val('');
					}
				}, error : function() {
					console.log("����");
				}
		   })
	   }
  })
	$("#userid").keydown(function(key) {
		if (key.keyCode == 13) {
			$("#loginBtn").trigger("click");
        }
	});	
	$("#pwd").keydown(function(key) {
		if (key.keyCode == 13) {
			$("#loginBtn").trigger("click");
        }
	});	
})
</script>
</html>