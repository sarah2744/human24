<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/배송</title>
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/order_delivery.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script>
var price = 0;
var dis_price = 0;
var f_price = 0;
var point = 0;
var buyText = "";
var count = "";
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div id="wrap">
		<h1 id="title">주문/결제</h1>
		<table id="navtable" style="width: 883px !important;" border="1"
			class="w3-table">
			<thead>
				<tr class="w3-light-grey">
					<th scope="cols" colspan="2">책 정보</th>
					<th scope="cols">수량</th>
					<th scope="cols">정가</th>
					<th scope="cols">할인금액</th>
					<th scope="cols">적립포인트</th>
					<th scope="cols">할인 적용 가격</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${buyTable}" var="com">
	            <tr class="trEach" id="${com.booknum}">
	               <td><img src="${pageContext.request.contextPath}/resources/${com.booknum}.jpg" alt=""></td>
	               <td style="font-weight: bold;">${com.booktitle}</td>
	               <td class="count">${com.buy_count}</td>
	               <td>
	               		<span class = "price">${com.price}</span> x ${com.buy_count} = 
	               		<span class = "price" style="font-weight: bold">${com.price*com.buy_count}</span>
	               </td>
	               <td>
	               		<span class = "price"><fmt:formatNumber value="${com.price*com.buy_count*(1-com.dis_per)}" pattern="0"/></span>
	               		<span style="color: tomato; font-weight: bold; font-size: 13px;">(
	               			<script>document.write(Math.round((1-${com.dis_per})*100))</script>
	               		% 할인)</span>
	               </td>
	               <td><fmt:formatNumber value="${com.price*com.buy_count*0.05}" pattern="0"/></td>
	               <script>
	                  price += ${com.price*com.buy_count};
	                  dis_price += ${com.price*com.buy_count*(1-com.dis_per)};
	                  f_price += ${com.price*com.buy_count*com.dis_per};
	                  point += ${com.price*com.buy_count*0.05};
	                  buyText += "${com.booknum},";
	                  count += "${com.buy_count},";
	               </script>
	               <td>
	               		<script>
	               			var realPrice = ${com.price*com.buy_count}
	               			var disPrice = Math.round("${com.price*com.buy_count*(1-com.dis_per)}");
	               			document.write(realPrice - disPrice);
	               		</script>
	               </td>
	            </tr>	
	         </c:forEach>
			</tbody>
		</table>
		<div id="infodiv">
			<h2 class="smallTitle">배송지 정보</h2>

			<div id="infodiv2">
				<form>
					<p id="defaultInfoP">
						<input type="checkbox" id="defaultInfo" class="defaultInfo" checked> <label
							for="defaultInfo" class="defaultInfo">기본 정보 불러오기</label>
					</p>
					<table>
						<tr>
							<td class="texttd"><b>이름 </b></td>
							<td><input type="text" size="5" id="username" class="userInfo" value = "${userInfo.user_name}"></td>
						</tr>
						<tr>
							<td class="texttd"><b>연락처 </b></td>
							<td><input type="text" size="20" class="userInfo" id="phone" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;" value = "${userInfo.mobile}"></td>
						</tr>
						<tr>
							<td class="texttd"><b>주소 </b></td>
							<td><input type="text" size="60" class="userInfo" id="addinfo" value = "${userInfo.adr}"></td>
						</tr>
						<tr>
							<td class="texttd"><b>요청사항 </b></td>
							<td><input type="text" size="60" id="apply"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<h2 class="smallTitle">주문 금액</h2>
		<table id="infotable">
			<tr>
				<td class="priceTitle" style="padding-top: 50px;">포인트 사용</td>
				<td>
					<input type = "text" id="pointUse" value="0" style="width: 80px; !important; margin-right: 10px;" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"> 
					<p style="color: #666; font-size: 12px; margin-bottom: 10px;">
						현재 포인트 : <span id="totalPoint" style="color: tomato; font-weight: bold"></span>
					</p><br>
					<button id="pointBtn" class="pointBtn">사용</button>
					<button id="useAllPoint" class="pointBtn">전체 사용</button>
					<button id="pointAgain" class="pointBtn">다시 사용</button>
				</td>
			</tr>
			
			<tr>
				<td class="priceTitle">총 상품금액</td>
				<td><span id="pricetext"></span> 원</td>
				<td rowspan="5" class="noBorderBottom">
					<div id="btndiv">
						<input type="button" value="구매" class="btn" id="buyBtn"><br> <input
							type="button" value="홈으로" class="btn"
							id="btnMain">
					</div>
				</td>
			</tr>
			<tr>
				<td class="priceTitle">배송비 <span style="color: #666; font-size: 12px;">(30,000원 이상 무료배송)</span></td>
				<td><span id="delPrice">2,500</span> 원</td>
			</tr>
			<tr>
				<td class="priceTitle">총 할인금액</td>
				<td><span id="dis_pricetext"></span> 원</td>
			</tr>
			<tr>
				<td class="priceTitle">결제 금액</td>
				<td><span id="f_pricetext"></span> 원</td>
			</tr>
			<tr>
				<td class="priceTitle noBorderBottom">결제 방법</td>
				<td class="noBorderBottom"><input type="radio" name="howpay"
					value="mu" id="mu"> <label for="mu">무통장 입금</label> <input
					type="radio" name="howpay" value="mu" id="sin"> <label
					for="sin">신용카드</label></td>
			</tr>
		</table>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script>
$(function(){
	if(f_price>=30000){ // 결제금액이 30000원 이상인 경우
	   $("#delPrice").text("0");
    }else{ // 결제 금액이 3만원 미만인 경우
	   f_price += 2500;
    }
	$("#totalPoint").text("${totalPoint}");
	var totalPoint = $("#totalPoint").text();
	$("#pricetext").text(AddComma(price));
	$("#dis_pricetext").text(AddComma(dis_price));
	$("#f_pricetext").text(AddComma(f_price));
	$("#btnMain").click(function(){
		window.location.href = '/main/main';
	})
	
	$(".price").each(function(){
	  $(this).text(AddComma($(this).text()));
   })
   
   $(".trEach").click(function(){
       var bnum = $(this).attr("id");
	   window.location.href="/main/detail?booknum="+bnum;
   })
   
   $("#pointUse").focus(function(){
	   $(this).val("");
	   return false;
   })
   
   $("#pointUse").keyup(function(key) {
   	  var reg = /[^0-9]/gi;
      var v = $(this).val();
   	  if(v>${totalPoint}){
   		  $(this).val(${totalPoint});
   		  $("#totalPoint").text(0);
   	  }else $("#totalPoint").text(${totalPoint}-v);
      if (reg.test(v)) {
          $(this).val(v.replace(reg, ''));
          $(this).focus();
          return false;
      }
   })
   
   $("#pointBtn").click(function(){
	   var v = $("#pointUse").val();
	   if(v == ""){
		  alert("사용할 포인트를 입력해주세요.");
		  $("#pointUse").val("0");
		  return false;
	   }else if(v>f_price){
   		  alert("포인트 사용 금액이 결제 금액보다 많습니다.");
   		  $("#pointUse").focus();
   		  return false;
   	   }else {
   		  $("#f_pricetext").text(AddComma(f_price-v));
   		  $("#pointUse").attr("disabled","true");
   	   }
   })
   $("#useAllPoint").click(function(){
	   $("#pointUse").val(totalPoint);
	   var v = $("#pointUse").val();
	   if(v == ""){
		  alert("사용할 포인트를 입력해주세요.");
		  $("#pointUse").val("0");
		  return false;
	   }else if(totalPoint>f_price){
		   $("#pointUse").val(f_price);
		   $("#f_pricetext").text("0");
		   $("#pointUse").attr("disabled","true");
	   }else if(v>f_price){
   		  alert("포인트 사용 금액이 결제 금액보다 많습니다.");
   		  $("#pointUse").focus();
   		  return false;
   	   }else {
   		  $("#f_pricetext").text(AddComma(f_price-v));
   		  $("#pointUse").attr("disabled","true");
   	   }
   })
   $("#pointAgain").click(function(){
	      $("#pointUse").removeAttr("disabled");
   })
   $("#buyBtn").click(function(){
	   buyText = buyText.slice(0,-1);
	   count = count.slice(0,-1);
	   if($("#username").val() == "" || $("#phone").val() == "" || $("#addinfo").val() == ""){
		   alert("배송지 정보를 입력해주세요!");
		   return false;
	   }	   
	   var usePoint = "0"
	   var pointFlag = 0;
	   
	   if($("#pointUse").attr("disabled") == "disabled") {
		   usePoint = $("#pointUse").val();
		   pointFlag = 1;
	   }
	   
	   if(!alert("구매가 완료되었습니다!")) document.location = "/main/buyBook?point="+point+"&buyText="+buyText+"&count="+count+"&usePoint="+usePoint+"&pointFlag="+pointFlag;
   })
   $("#defaultInfo").click(function(){
	   if(this.checked){ // 기본 정보 불러오기 체크
		   $("#username").val("${userInfo.user_name}");
	   	   $("#phone").val("${userInfo.mobile}");
	   	   $("#addinfo").val("${userInfo.adr}");
	   }else{ // 기본 정보 불러오기 체크 해제
		   $(".userInfo").each(function(){
			   $(this).val('');
		   }) 
	   }
   })
})
</script>
</html>