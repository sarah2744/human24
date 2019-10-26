<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%
		String admin_id = request.getParameter("admin_id");
		session.setAttribute("admin_id", admin_id);
		response.sendRedirect("/main/admin/statistics/user");
	%>
</body>
<script>
</script>
</html>