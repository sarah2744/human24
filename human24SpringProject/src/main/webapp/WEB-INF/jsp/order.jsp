<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/order.css">
<meta charset="UTF-8">
<title>주문 / 배송</title>
<script>
	var temp = 0;
	var realPrice = 0;
</script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<jsp:include page="header.jsp" flush="true" />
	<div id="wrap">
		<h1 id="title">주문/배송</h1>
		<table id="navtable" style="width: 883px !important;" border="1"
			class="w3-table">
			<thead>
				<tr class="w3-light-grey">
					<th scope="cols">주문번호</th>
					<th scope="cols">구매일자</th>
					<th scope="cols" colspan="2">구매정보</th>
					<th scope="cols">수량</th>
					<th scope="cols">할인가</th>
					<th scope="cols">사용포인트</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${buyTable}" var="com">
				<tr class="eachTr">
	          	  	<script>
	          	  	var pi = ${com.pur_index};
	          	  	var pointWrite = false;
	          	  	
          	  		if(temp != pi){
          	  			var str = ("${com.buy_date}".replace(/-/gi, "")+"${com.pur_index}");
          	  			document.write("<td rowspan = '${com.book_size}' style='vertical-align:middle; font-weight: bold'>"+str+"</td>");
          	  			temp = pi;
          	  			pointWrite = true;
          	  		}
	          	  	</script> 
	               <td style="border-right: none;" class="goDetail" bid="${com.booknum}">${com.buy_date}</td>
	               <td class="goDetail" bid="${com.booknum}"><img src="${pageContext.request.contextPath}/resources/${com.booknum}.jpg" alt=""></td>
	               <td style="font-weight:bold;">${com.booktitle}</td>
	               <td class="count">${com.buy_count}</td>
	          	   <td id="realPriceText">
	          	   		<p style="color: #666; font-size: 12px;">
	          	   			<span class="price">${com.price}</span> x ${com.buy_count} =
	          	   			<span class="price">${com.price*com.buy_count}</span>
	          	   		</p>
	          	   		<span style="color: tomato; font-size: 12px; font-weight: bold;">(
	          	   		<fmt:formatNumber value="${(1-com.dis_per)*100}" pattern="0"/>
	          	   		% 할인
	          	   		)</span><br/><br/>
	          	   		<span style="color: #666; font-size: 12px;">결제가 : </span>
	          	   		<span class="price" style="color: #333; font-size: 16px; font-weight: bold;">
	          	   			<fmt:formatNumber value="${com.price*com.buy_count*com.dis_per}" pattern="0"/>
	          	   		</span>
	          	   </td> 
	               <script>
	               if(pointWrite){
          	  		   document.write("<td rowspan = '${com.book_size}' style='vertical-align:middle;'>-${com.usepoint}</td>");
          	  	       pointWrite = false;
          	  	   }
	          	  	</script>
	            </tr>
	            	
	         </c:forEach>
			</tbody>
		</table>
	</div>

	<jsp:include page="footer.jsp" flush="true" />

</body>
<script>

   $(".goDetail").click(function(){
	   var bnum = $(this).attr("bid");
	   window.location.href="/main/detail?booknum="+bnum;
   })
   $(".price").each(function(){
	   $(this).text(AddComma($(this).text()));
   })

</script>
</html>