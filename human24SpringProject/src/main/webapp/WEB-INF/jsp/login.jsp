<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String usrnm = request.getParameter("usrnm");
		session.setAttribute("userid", usrnm);
		response.sendRedirect("main");
	%>
</body>
</html>