<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/weekDiscount.css">
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
<title>베스트</title>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<jsp:include page="header.jsp" flush="true" />

	<div id="weekDiv">
		<h1 id="weekTitle">베스트 - HUMAN24</h1>
		<table id="booktbl">
			<tr>
				<c:forEach items="${bookList}" var="dto" varStatus="status">
					<td>
						<div id="bookDiv" onclick="location.href='/main/detail?booknum=${dto.booknum}';">
							<div class="imgDiv">
								<img src="${pageContext.request.contextPath}/resources/${dto.booknum}.jpg">
							</div>
							<p class="bookTitle">${dto.booktitle}</p>
							<p>
								${dto.price} → <fmt:formatNumber value="${dto.price*dto.dis_per}" pattern="0"/>
								<br/>
								<span class="disPer">(<fmt:formatNumber value="${100-(dto.dis_per*100)}" pattern="0"/>% 할인)</span></br>
								<script>
								if(${100-(dto.dis_per*100)} == 30) document.write("<p style='color: tomato; margin-top: 5px;'>!!! 주말특가 !!!</p>")
								</script>
							</p>
							<p>판매지수 : ${dto.sales_cnt}</p>
							<p>
								<span class="blueStar gradeStar" id="gradeStar">
									<script>
										showStar(${dto.grade})
									</script>	
								</span>
								<span class="grayStar gradeStar" id="gradeStar">
									<script>
									showGrayStar(${5-dto.grade});
									</script>	
								</span>
							</p>
						</div>
					</td>
					<c:if test = "${status.count == 4}">
						</tr><tr>
					</c:if>
				</c:forEach>	
			</tr>
		</table>
	</div>
	
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script>
$(function(){
	
})
</script>
</html>