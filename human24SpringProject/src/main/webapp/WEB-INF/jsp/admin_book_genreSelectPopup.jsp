<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_book_genreSelectPopup.css">
<title>Insert title here</title>
<style>

</style>
</head>
<body>
    <p>장르를 클릭하면 해당 페이지로 이동합니다.</p>
    <div id="genreContainer">
        <ul id="menubar">
        <c:forEach items="${mainGenre}" var="com">
        	<li class="title"><button class="mainName" onclick='window.open("/main/admin/book/list?call=mainGenre&mainGenre=${com.main_genre_name}")'>${com.main_genre_name}</button>
        		<ul class="smallTitle" id="${com.main_genre_name}">
        		</ul>
        		<script>
	        		$.ajax
	        		({
	        		   url : '${pageContext.request.contextPath}/admin/book/popup?main_genre_num=${com.main_genre_num}',
	        		   type : 'post',
	        		   success : function(data){
						  var jsonObj = JSON.parse(data);  
						  for(var i = 0; i < jsonObj.length; i++){
							  console.log(jsonObj[i].sub_genre_name);
							  $(".smallTitle[id='${com.main_genre_name}']").append("<li class='subLi' onclick='window.open("+'"/main/admin/book/list?call=subGenre&subGenre='+jsonObj[i].sub_genre_name+'"'+")'>"+jsonObj[i].sub_genre_name+"</li>")
						  }
	        		   }
	        		})
        		</script>
        	</li>
        </c:forEach>
        </ul>
    </div>
</body>
<script>
	$(function(){
		$(".mainName, .subLi").click(function(){
			self.close();
		})
	})
</script>
</html>
