<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/point.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>나의 포인트</title>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">>
	<jsp:include page="header.jsp" flush="true" />

	<div id="wrap" class="w3-container">
		<h1 id="title">나의 포인트 : 총 <span style = "color: tomato">${totalPoint}</span> 포인트</h1>
		<table class="w3-table" id="boardTbl">
			<tr>
				<th>적립 / 사용 전 포인트</th>
				<th>적립 / 사용 기록</th>
				<th>정보</th>
				<th>적립 / 사용 일자</th>
				<th>적립 / 사용 후 포인트</th>
			</tr>
			<c:forEach items="${pointList}" var="dto">
				<tr class="boardConTr">
					<td>${dto.beforepoint}</td>
					<td>
						<script>
							if("${dto.how_point}"=="포인트 사용") document.write("<span style='color: tomato;'> ${dto.use_accu}</span>")
							else document.write("<span style='color: #2730ad;'>+${dto.use_accu}</span>")
						</script>
					</td>
					<td>${dto.how_point}</td>
					<td>${dto.point_date}</td>
					<td>${dto.afterpoint}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>