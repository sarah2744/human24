<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cart.css">
</head>
<script>
var price = 0;
var dis_price = 0;
var f_price = 0;
</script>
<body>
   <jsp:include page="header.jsp" flush="true" />
   <div id="wrap">
   <h1 id="title">장바구니</h1>
   <table id="navtable" class="w3-table-all w3-hoverable"
      style="width: 883px !important;">
      <thead>
         <tr class="w3-light-grey">
            <th scope="cols"><input type="checkbox" checked id="check_all"></th>
            <th scope="cols" colspan=2>책 정보</th>
            <th scope="cols">수량</th>
            <th scope="cols">정가</th>
            <th scope="cols">할인금액</th>
            <th scope="cols">적립포인트</th>
            <th scope="cols">할인 적용 가격</th>
            <!-- <th scope="cols">상세페이지</th> -->
         </tr>
      </thead>
      <tbody>
         <c:forEach items="${cartTable}" var="com">
            <tr class="trEach">
               <td><input type="checkbox" value="${com.booknum}" cnt = "${com.cart_count}" class="bookCheck" checked></input></td>
               <td class = "goDetail" bid="${com.booknum}"><img src="${pageContext.request.contextPath}/resources/${com.booknum}.jpg" alt=""></td>
               <td class = "goDetail" bid="${com.booknum}">${com.booktitle}</td>
               <td class="count">
                     <div class="countDiv">
                        <input type="text name="count" autocomplete="off"
                           style='IME-MODE: disabled' class="countInput" id="${com.booknum}"  value="${com.cart_count}" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/><br>
                        <input type="button" value="변경" class="countBtn" bid="${com.booknum}">
                     </div>
                  </td>
               <td>
               		<span class = "price">${com.price}</span> x ${com.cart_count} = 
               		<span class = "price" style="font-weight: bold;">${com.price*com.cart_count}</span>
               </td>
               <td>
               		<span class = "price"><fmt:formatNumber value="${com.price*com.cart_count*(1-com.dis_per)}" pattern="0"/></span>
               		<span style="color: tomato; font-weight: bold; font-size: 13px;">(
               			<script>document.write(Math.round((1-${com.dis_per})*100))</script>
               		% 할인)</span>
               </td>
               <td><fmt:formatNumber value="${com.price*com.cart_count*0.05}" pattern="0"/></td>
               <script>
                  price += ${com.price*com.cart_count};
                  dis_price += ${com.price*com.cart_count*(1-com.dis_per)};
                  f_price += ${com.price*com.cart_count*com.dis_per};
               </script>
               <td>
               		<script>
	               		var realPrice = ${com.price*com.cart_count};
	           			console.log(${com.price*com.cart_count*(1-com.dis_per)});
	           			disPrice = Math.round(${com.price*com.cart_count*(1-com.dis_per)});
	           			document.write(realPrice - disPrice);
               		</script>
               </td>
               <!-- 
               <td>
               	<i class="fas fa-search goDetail" id = "schIcon" bid="${com.booknum}"></i>
               </td>
                -->
            </tr>	
         </c:forEach>
      </tbody>
   </table>
   
   <table id="infotable">
      <tr>
         <td class="priceTitle">총 상품금액</td>
         <td><span id="pricetext"></span>원</td>
         <td rowspan="4" class="noBorderBottom">
            <div id="btndiv">
               <input type="button" value="구매" class="btn" id="btnBuy"><br> <input
                  type="button" value="삭제" class="btn" id="btndelete">
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
         <td class="priceTitle noBorderBottom"><b>결제 금액</b></td>
         <td class="noBorderBottom"><b><span id="f_pricetext"></span> 원</b></td>
      </tr>
   </table>
   <form method="POST" action="order_delivery" id="buyForm">
   		<input type = "hidden" id="buyText" name="buyText">
   		<input type = "hidden" id="count" name="count">
   		<input type = "hidden" name="cartOrDetail" value="cart">
   </form>
   </div>
   <jsp:include page="footer.jsp" flush="true" />
   
</body>
<script>
$(function(){
   if(f_price>=30000){
	   $("#delPrice").text("0");
   }else{
	   f_price += 2500;
   }
   $("#pricetext").text(AddComma(price));
   $("#dis_pricetext").text(AddComma(dis_price));
   $("#f_pricetext").text(AddComma(f_price));
   $("#btnBuy").click(function(){
	   var buyText = "";
	   var count = "";
	    $("input:checkbox[class='bookCheck']").each(function() {
	    	
	        if(this.checked){//checked 처리된 항목의 값
	        	buyText += this.value + ",";
	        	count += $(this).attr("cnt")+",";
	        }
	    });
	    buyText = buyText.slice(0,-1);
	    count = count.slice(0,-1);
		$("#buyText").val(buyText);
		$("#count").val(count);
 		$("#buyForm").submit();
   })
   
   $(".goDetail").click(function(){
	   var bnum = $(this).attr("bid");
	   window.location.href="/main/detail?booknum="+bnum;
   })
	   
   $(".price").each(function(){
	  $(this).text(AddComma($(this).text()));
   })
   
   $(".goDetail").each(function(){
	   $(this).click(function(){
		   var bnum = $(this).attr("bid");
		   window.location.href="/main/detail?booknum="+bnum;
	   })
   })
   
   $("#check_all").click(function(){ // 체크박스 모두 체크 / 모두 해제
        var chk = $(this).is(":checked");//.attr('checked');
        if(chk) $(".bookCheck").prop('checked', true);
        else  $(".bookCheck").prop('checked', false);
   });
   
   $(".countBtn").each(function(){
      $(".countBtn").click(function(){
         var bid = $(this).attr("bid"); // 책 번호
         var count = $(".countInput[id="+bid+"]").val() // 책 수량
         $.ajax({
              url: '${pageContext.request.contextPath}/u_cart?cartcount=' + count + '&cartbooknum='+ bid+'&userid='+userid, // 클라이언트가 요청을 보낼 서버의 URL 주소
              type: "GET",
              complete : function(data) {
                 window.location.reload(true);
              }
          })
      })
   })
   
   $(".countInput").each(function(){
	   $(this).keyup(function(key) {
	   	     var reg = /[^0-9]/gi;
	         var v = $(this).val();
	         if (reg.test(v)) {
	             $(this).val(v.replace(reg, ''));
	             $(this).focus();
	             return false;
	         }else if(v == '0'){
		       	  alert("수량이 1보다 작을 수 없습니다.");
		       	  $(this).val(v.replace(0, '1'));
		       	  return false;
	         }else{
	    	      $(this).val(v.replace("e",''));
	    	      return false;
	         }
	   })
   })
})
	
$(document).on("click", "#btndelete", function() {
   var delText = "";
    $("input:checkbox[class='bookCheck']").each(function() {
        if(this.checked){//checked 처리된 항목의 값
           delText += this.value + ",";
        }
    });
    delText = delText.slice(0,-1);
    $.ajax({
        url: '${pageContext.request.contextPath}/d_cart?d_cartnum=' + delText+'&userid='+userid, // 클라이언트가 요청을 보낼 서버의 URL 주소
        type: "GET",
        complete : function(data) {
           window.location.reload(true);
        }
    })
})
</script>
</html>