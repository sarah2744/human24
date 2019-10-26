<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modify.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<title>회원 정보 수정</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<%String userid = (String) session.getAttribute("userid"); %>
	<div id="wrap">
            <h1 id="title">회원 정보 수정</h1>
            <form action="" id="loginForm">
                <table>
                    <tr>
                        <td>아이디</td>
                        <td><%=userid %></td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td>
                        <input type="password" id="password" readonly> 
                        <input type="button" id="btnPassUpdate" value="비밀번호 수정" class="btn">
                        </td>
                    </tr>
                    <tr>
                        <td>이름</td>
                        <td><input type="text" name="" id="username" onkeyPress="if (event.keyCode < 65 || (event.keyCode > 90 && event.keyCode < 97) || event.keyCode > 122) event.returnValue=false;">&nbsp;<span id="iconName"></span></td>
                    </tr>
                    <tr>
                        <td>생년월일</td>
                        <td><input type="text" name="" id="txtYear" placeholder="년(4자리)" class="birth" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">
                            <input type="text" name="" id="txtMonth" list="monthList" placeholder="월"  class="birth" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">
                            <datalist id="monthList">
                                <option value="1">
                                <option value="2">
                                <option value="3">
                                <option value="4">
                                <option value="5">
                                <option value="6">
                                <option value="7">
                                <option value="8">
                                <option value="9">
                                <option value="10">
                                <option value="11">
                                <option value="12">
                            </datalist> <input type="text" name="" id="txtDate" placeholder="일" class="birth" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">&nbsp;<span id="iconBirth">
                    </tr>
                    <tr>
                        <td>성별</td>
                        <td><input type="radio" name="gender" id="female"
                            value="female"> <label for="female">여</label> <input
                            type="radio" name="gender" id="male" value="male"> <label
                            for="male">남</label>&nbsp;<span id="iconGender"><i class="fas fa-check" style="color:green"></i></span></td>
                    </tr>
                    <tr>
                        <td>휴대전화</td>
                        <td><input type="text" name="" id="p1" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"> - <input
                            type="text" name="" id="p2" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"> - <input type="text" name=""
                            id="p3" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"></td>
                    </tr>
                    <tr>
                        <td>주소</td>
                        <td><input type="text" name="" id="adr">&nbsp;<span id="iconAdr"></span></td>
                    </tr>
                    <tr>
                        <td>이메일</td>
                        <td><input type="text" name="" class="email" id="email_1" readonly> @ <input
                            type="text" name="" class="email" list="emailList"
                            placeholder="직접입력" id="email_2" readonly>
                            </datalist>&nbsp;&nbsp;&nbsp; </td>
                    </tr>
                    
                </table>
                <div id="btnDiv">
                    <input type="button" value="수정" id="btnUpdate" class="btn" style="margin-right: 20px;"> <input
                        type="button" id="btnHome" value="돌아가기" class="btn">
                </div>
            </form>
        </div>
	
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script type="text/javascript">

	//유효성 변수 초기화
var nameOk = true,
	birthOk = true,
	mobileOk = true,
	adrOk = true;

$(document)
.ready(function(){
	//페이지가 로드될때 세션에 있는 아이디값으로 회원정보를 불러옴
	$.ajax({
		url : '${pageContext.request.contextPath}/modify/userinfo?userId='+userid,
		type : 'get',
		success : function(data) {
			console.log(data);
			//비밀번호 값 로드
			$('#password').val(data[0].user_pwd);
			
			//이름
			$('#username').val(data[0].user_name);
			
			//생년월일
			$('#txtYear').val(data[0].birth.substring(0, 4));
			$('#txtMonth').val(data[0].birth.substring(4, 6));
			$('#txtDate').val(data[0].birth.substring(6, 8));
			
			//성별체크
			if(data[0].gender == 'female'){
				$('#female').prop('checked',true);
			}else{
				$('#male').prop('checked',true);
			}
			//휴대폰
			console.log(data[0].mobile.length)
			if(data[0].mobile.length == 10){
				$('#p1').val(data[0].mobile.substring(0, 3));
				$('#p2').val(data[0].mobile.substring(3, 6));
				$('#p3').val(data[0].mobile.substring(6, 10));	
			}else{
				$('#p1').val(data[0].mobile.substring(0, 3));
				$('#p2').val(data[0].mobile.substring(3, 7));
				$('#p3').val(data[0].mobile.substring(7, 11));				
			}
			$('#adr').val(data[0].adr);
			
			//이메일
			var arr = data[0].mail.split('@');		//이메일 문자열을 @을 기준으로 잘라 변수 arr에 배열로 담음
			$('#email_1').val(arr[0]);
			$('#email_2').val(arr[1]);
			
		}, error : function() {
			console.log("실패");
		}
	})
});
$(document)
.on('click','#btnPassUpdate',function(){
	var popupX = (window.screen.width/2)-(200/2)-200;
	var popupY= (window.screen.height/2)-(300/2)-100;
	//window.open('/main/passUpdate', '비밀번호 변경', 'width=600, height=400, menubar=no, status=no, scrollbars=no, toolbar=no, left=' + popupX + ' ,top=' + popupY);
	openDialog('/main/passUpdate', '비밀번호 변경', 'width=600, height=400, menubar=no, status=no, scrollbars=no, toolbar=no, left=' + popupX + ' ,top=' + popupY, function(win) {
	    alert('비밀번호가 재설정되었습니다 페이지를 다시 로드합니다.');
	  //페이지가 로드될때 세션에 있는 아이디값으로 회원정보를 불러옴
		$.ajax({
			url : '${pageContext.request.contextPath}/modify/userinfo?userId='+userid,
			type : 'get',
			success : function(data) {
				console.log(data);
				//비밀번호 값 로드
				$('#password').val(data[0].user_pwd);
				
				//이름
				$('#username').val(data[0].user_name);
				
				//생년월일
				$('#txtYear').val(data[0].birth.substring(0, 4));
				$('#txtMonth').val(data[0].birth.substring(4, 6));
				$('#txtDate').val(data[0].birth.substring(6, 8));
				
				//성별체크
				if(data[0].gender == 'female'){
					$('#female').prop('checked',true);
				}else{
					$('#male').prop('checked',true);
				}
				//휴대폰
				console.log(data[0].mobile.length)
				if(data[0].mobile.length == 10){
					$('#p1').val(data[0].mobile.substring(0, 3));
					$('#p2').val(data[0].mobile.substring(3, 6));
					$('#p3').val(data[0].mobile.substring(6, 10));	
				}else{
					$('#p1').val(data[0].mobile.substring(0, 3));
					$('#p2').val(data[0].mobile.substring(3, 7));
					$('#p3').val(data[0].mobile.substring(7, 11));				
				}
				$('#adr').val(data[0].adr);
				
				//이메일
				var arr = data[0].mail.split('@');		//이메일 문자열을 @을 기준으로 잘라 변수 arr에 배열로 담음
				$('#email_1').val(arr[0]);
				$('#email_2').val(arr[1]);
				
			}, error : function() {
				console.log("실패");
			}
		})
	});

})
.on('click','#btnUpdate',function(){
	if(nameOk && birthOk && mobileOk && adrOk){
		alert('회원님의 정보가 성공적으로 수정되었습니다. 마이페이지로 이동합니다');
		window.location.href="${pageContext.request.contextPath}/modify/Submit?user_id="+userid+
		"&user_name="+$('#username').val()+
		"&birth="+$('#txtYear').val()+$('#txtMonth').val()+$('#txtDate').val()+
		"&adr="+$('#adr').val()+
		"&gender="+$('input:radio[name=gender]').val()+
		"&mobile="+$('#p1').val()+$('#p2').val()+$('#p3').val()+"";
	}else{
		alert("수정에 실패하였습니다. 빈칸이 있는지 빨간체크가 있는지 다시한번 확인해주세요");
	}
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
.on('blur','#p1',function(){
	MobileCheck('#p1');
})
.on('blur','#p2',function(){
	MobileCheck('#p2');
})
.on('blur','#p3',function(){
	MobileCheck('#p3');
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
.on('click','#btnHome',function(){
	document.location.href = "/main/mypage";
})


 function BirthCheck(field){
    	if($('#txtMonth').val().length == 1){
    		$('#txtMonth').val("0"+$('#txtMonth').val());
    	}
    	if($('#txtDate').val().length == 1){
    		$('#txtDate').val("0"+$('#txtDate').val());
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
    
//팝업이 닫힐시 실행되는 이벤트 함수
var openDialog = function(uri, name, options, closeCallback) {
    var win = window.open(uri, name, options);
    var interval = window.setInterval(function() {
        try {
            if (win == null || win.closed) {
                window.clearInterval(interval);
                closeCallback(win);
            }
        }
        catch (e) {
        }
    }, 1000);
    return win;
};


</script>
</html>