<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/join.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="https://cdn.emailjs.com/sdk/2.3.2/email.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
</head>
<body>
<jsp:include page="header.jsp" flush="true" />
	<div id="wrap">
		<h1 id="title">회원가입</h1>
		<form action="" id="loginForm">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" id="txtUserId" onkeyPress="if ( event.keyCode < 48 || (event.keyCode < 97 && event.keyCode > 57) || event.keyCode > 122) event.returnValue=false; ">
						&nbsp;<span id="iconId"></span>&nbsp;
						<input type="button" id="btnIdCheck" value="중복검사" class="btn"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="" id="pass1" onkeyPress="if (event.keyCode==32) event.returnValue=false;"></td>
				</tr>
				<tr>
					<td>비밀번호확인</td>
					<td><input type="password" name="" id="pass2" onkeyPress="if (event.keyCode==32) event.returnValue=false;">&nbsp;<span id="iconPass"></span>&nbsp;</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="" id="username" onkeyPress="if (event.keyCode < 65 || (event.keyCode > 90 && event.keyCode < 97) || event.keyCode > 122) event.returnValue=false;">&nbsp;<span id="iconName"></span>&nbsp;</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="text" name="" id="txtYear" placeholder="년(4자리)" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">
						<input type="text" name="" id="txtMonth" list="monthList" placeholder="월">
						<datalist id="monthList">
							<option value="01">
							<option value="02">
							<option value="03">
							<option value="04">
							<option value="05">
							<option value="06">
							<option value="07">
							<option value="08">
							<option value="09">
							<option value="10">
							<option value="11">
							<option value="12">
						</datalist> <input type="text" name="" id="txtDate" placeholder="일" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">&nbsp;<span id="iconBirth"></span>&nbsp;
				</tr>
				<tr>
					<td>성별</td>
					<td><input type="radio" name="gender" id="female"
						value="female"> <label for="female">여</label> <input
						type="radio" name="gender" id="male" value="male"> <label
						for="male">남</label>&nbsp;<span id="iconGender"></span>&nbsp;</td>
				</tr>
				<tr>
					<td>휴대전화</td>
					<td><input type="text" name="" id="mobile1" onkeyPress="if (event.keyCode<48 || (event.keyCode>57)) event.returnValue=false;"> - <input
						type="text" name="" id="mobile2"  onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"> - <input type="text" name=""
						id="mobile3"  onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"> &nbsp;<span id="iconMobile"></span></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="" id="adr">&nbsp;<span id="iconAdr"></span>&nbsp;</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="" id="email_1"> @ <input
						type="text" name="" id="email_2" list="emailList"
						placeholder="직접입력"> <datalist id="emailList">
							<option value="naver.com"></option>
							<option value="daum.net"></option>
							<option value="gmail.com"></option>
							<option value="nate.com"></option>
							<option value="yahoo.com"></option>
							<option value=""></option>
							<option value=""></option>
						</datalist>&nbsp;&nbsp;&nbsp; <input type="button" id="btnEmailGo"
						value="인증번호 받기" class="btn"></td>
				</tr>
				<tr>
					<td>인증번호확인</td>
					<td><input type="text" name="" id="txtCode" disabled>&nbsp;&nbsp; <input
						type="text" id="countTime" value="03:00" readonly>&nbsp;&nbsp;<span id="iconEmail"></span>
						<input type="button" id="btnAcce" value="인증확인" class="btn" disabled>
					</td>
				</tr>
			</table>
			<div id="btnDiv">
				<input type="button" value="가입" id="btnSubmit" class="btn" style="margin-right: 20px;"> <input
					type="button" value="홈으로" id="btnMain" class="btn">
			</div>
		</form>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script>
var rannum = "";
var successcode = "";

	//유효성 변수 선언
var idOk = false,
	passOk = false,
	nameOk = false,
	birthOk = false,
	genderOk = false,
	mobileOk = false,
	adrOk = false,
	emailOk = false;
	
$(document)
.on("click","#btnMain",function(){
	location.href='/main/main';
})
	//아이디 중복검사 버튼
.on("click","#btnIdCheck",function() {
	var user_id = $('#txtUserId').val();
	$.ajax({
		url : '${pageContext.request.contextPath}/join/idCheck?userId='+ user_id,
		type : 'get',
		success : function(data) {
			console.log("1 = 중복o / 0 = 중복x : "+ data);								
		    if (data == 1) {
				$('#iconId').text('');
		    	$('#iconId').append('<i class="fas fa-times" style="color:red"></i>');
		    	alert("중복된 아이디입니다.");
		    	return idOk = false;
			}else if(user_id == ''){
				alert("아이디를 입력해주십시오");
				return idOk = false;
			}else if(user_id == null){
				alert("아이디를 입력해주십시오");
				return idOk = false;
			}else {
				$('#iconId').text('');
				$('#iconId').append('<i class="fas fa-check" style="color:green"></i>');
				if(confirm('사용가능한 아이디입니다. 사용하시겠습니까?')==true){
		            $('#txtUserId').attr({ disabled: true });
		            $('#btnIdCheck').attr({ disabled : true});
		            console.log("true");
		            return idOk = true;
		        }else{}
			}
		}, error : function() {
			console.log("실패");
		}
	});
})
.on('blur','#txtUserId',function(){
	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
})
.on('blur','#pass1',function(){
	PasswordCheck();
})
.on('blur','#pass2',function(){
	PasswordCheck();	
})
.on('blur','#username',function(){
	$(this).val( $(this).val().replace( /[A-Z|a-z|ㄱ-ㅎ]/g, '' ) );
	if($(this).val() != ''){
		$('#iconName').text('');
		$('#iconName').append('<i class="fas fa-check" style="color:green"></i>');
		console.log("true");
		return nameOk = true;
	}else{
		$('#iconName').text('');
		$('#iconName').append('<i class="fas fa-times" style="color:red"></i>');
		return nameOk = false;
	}
})
.on('blur','#txtYear',function(){
	BirthCheck('#txtYear');
})
.on('blur','#txtMonth',function(){
	BirthCheck('#txtMonth');
})
.on('blur','#txtDate',function(){
	BirthCheck('#txtDate');
})
.on('click','input:radio[name=gender]',function(){
	$('#iconGender').text('');
	$('#iconGender').append('<i class="fas fa-check" style="color:green"></i>');
	genderOk=true;
})
.on('blur','#mobile1',function(){
	MobileCheck('#mobile1');
})
.on('blur','#mobile2',function(){
	MobileCheck('#mobile2');
})
.on('blur','#mobile3',function(){
	MobileCheck('#mobile3');
})
.on('blur','#adr',function(){
	if($.trim($(this).val())!=''){
		$('#iconAdr').text('');
		$('#iconAdr').append('<i class="fas fa-check" style="color:green"></i>');
		console.log("true");
		return adrOk = true;
	}else{
		$('#iconAdr').text('');
		$('#iconAdr').append('<i class="fas fa-times" style="color:red"></i>');
		return adrOk = false;
	}
})
.on('click','#btnEmailGo',function(){
	//EmailJS 이메일 보내기
	var emailC = {
	            to_name: $('#username').val(),
	            context: '인증코드는 ' + ranNumber() + '입니다. (6자리를 정확히 입력해주세요)',
	            give_man: String($('#email_1').val() + "@" + $('#email_2').val())
			}
	emailjs.init("user_hulDFJsMY0GjWW7BMW50I");
	emailjs.send("gmail", "template_q8iakN6E", emailC)
	.then(function (response) {
		console.log("SUCCESS. status=%d, text=%s", response.status, response.text);
	}, function (err) {
		console.log("FAILED. error=", err);
	});
	successcode = rannum;
	alert("귀하의 메일로 인증번호 6자리를 보냈습니다. 확인하여 3분 안에 입력해주세요");
	//타이머 03:00 시작
	var threeMinutes = 60 * 3,
	display = $('#countTime').val();
	
	//스타트타이머 함수 실행
	startTimer(threeMinutes, display);
	
	//인증코드 폼 활성
	$('#txtCode').attr({ disabled:false });
	$('#btnAcce').attr({ disabled:false })
})
.on('click', '#btnAcce', function () {
	//코드인증 확인
    if (successcode == $('#txtCode').val()){
        alert("인증이 완료되었습니다.");
        $('#iconEmail').text('');
        $('#iconEmail').append('<i class="fas fa-check" style="color:green"></i>');
        $('#email_1').attr({disabled : true})
        $('#email_2').attr({disabled : true})
        console.log("true");
        return emailOk=true;
    } else {
        alert("인증실패");
        $('#iconEmail').text('');
		$('#iconEmail').append('<i class="fas fa-times" style="color:red"></i>');
    }
})
.on('click','#btnSubmit',function(){
	if(idOk && passOk && nameOk && birthOk && genderOk && mobileOk && adrOk && emailOk){
		var userBirth = 
		alert('축하드립니다 HUMAN24의 가족이 되신것을 환영합니다 홈페이지로 이동합니다.');
		window.location.href="${pageContext.request.contextPath}/join/sign?user_id="+$('#txtUserId').val()+
				"&user_name="+$('#username').val()+
				"&user_pwd="+$('#pass2').val()+
				"&birth="+$('#txtYear').val()+$('#txtMonth').val()+$('#txtDate').val()+
				"&mail="+$('#email_1').val()+"@"+$('#email_2').val()+
				"&adr="+$('#adr').val()+
				"&gender="+$('input:radio[name=gender]').val()+
				"&mobile="+$('#mobile1').val()+$('#mobile2').val()+$('#mobile3').val()+"";
	}else{
		alert("항목에 초록색 체크가 모두 되어있는지 확인해주세요!");
	}
})


	//6자리 난수 코드 함수
    function ranNumber() {
        for (var i = 0; i < 6; i++) {
            rannum += Math.floor(Math.random() * 10);
        }
        return rannum;
    };
    
    //타이머 실행 함수
	function startTimer(timemove, display) {
		var timer = timemove, minutes, seconds;
		setInterval(function() {
			minutes = parseInt(timer / 60, 10);
			seconds = parseInt(timer % 60, 10);

			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;

			$('#countTime').val(minutes + ":" + seconds);

			if (--timer < 0 || emailOk==true) {
				$('#btnAcce').attr({disabled:true});
				$('#txtCode').attr({disabled:true});
				$('#countTime').val("03:00");
				clearInterval();
			}
		}, 1000);
	}
   	//패스워드 유효성 함수
   	function PasswordCheck(){
   		if($('#pass1').val() == $('#pass2').val() && $('#pass1').val() != ''){
   			$('#iconPass').text('');
   			$('#iconPass').append('<i class="fas fa-check" style="color:green"></i>');
   			console.log("true");
   			return passOk = true;
   		}else{
   			$('#iconPass').text('');
   			$('#iconPass').append('<i class="fas fa-times" style="color:red"></i>');
   			return passOk = false;
   		}
   	}
   	
    //생년월일 유효성 함수
    function BirthCheck(field){
    	if($('#txtMonth').val().length == 1){
    		$('#txtMonth').val("0"+$('#txtMonth').val());
    		console.log("한자리네요 추가할게요")
    	}
    	if($('#txtDate').val().length == 1){
    		$('#txtDate').val("0"+$('#txtDate').val());
    		console.log("한자리네요 추가할게요")
    	}
    	$(field).val( $(field).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
    	if($('#txtYear').val().length == 4 &&
    			parseInt($('#txtMonth').val()) < 13 && 
    			parseInt($('#txtMonth').val()) > 0 && 
    			parseInt($('#txtDate').val()) > 0 &&
    			parseInt($('#txtDate').val()) < 32){
    		$('#iconBirth').text('');
    		$('#iconBirth').append('<i class="fas fa-check" style="color:green"></i>');
    		console.log("true");
    		birthOk = true;
    	}else{
    		$('#iconBirth').text('');
    		$('#iconBirth').append('<i class="fas fa-times" style="color:red"></i>');
    		birthOk = false;
    	};
    }
    
    //휴대폰 유효성 함수
    function MobileCheck(field){
    	$(field).val( $(field).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
    	if($('#mobile1').val().length == 3 && ($('#mobile2').val().length == 3 || $('#mobile2').val().length == 4) && $('#mobile3').val().length==4){
    		$('#iconMobile').text('');
    		$('#iconMobile').append('<i class="fas fa-check" style="color:green"></i>');
    		console.log("true");
    		return mobileOk = true;
    	}else{
    		$('#iconMobile').text('');
    		$('#iconMobile').append('<i class="fas fa-times" style="color:red"></i>');
    		return mobileOk = false;
    	}
    }
</script>
</html>