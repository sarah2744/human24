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
	session.invalidate();
	String id = request.getParameter("id");
	if(id.equals("user")) response.sendRedirect("main");
	else if(id.equals("admin")) response.sendRedirect("/main/admin/login");
%>
</body>
</html>