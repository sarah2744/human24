<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/store.css">
<title>스토어  - HUMAN24</title>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<jsp:include page="header.jsp" flush="true" />
	<!-- header include -->
	<div id="genreContainer">
		<ul id="menubar">
	        <c:forEach items="${mainGenre}" var="com">
	        	<li class="title">${com.main_genre_name}
	        		<ul class="smallTitle" id="${com.main_genre_name}">
	        		</ul>
	        		<script>
		        		$.ajax
		        		({
		        		   url : '${pageContext.request.contextPath}/useSubGenre?main_genre_num=${com.main_genre_num}',
		        		   type : 'post',
		        		   success : function(data){
							  var jsonObj = JSON.parse(data);  
							  for(var i = 0; i < jsonObj.length; i++){
								  $(".smallTitle[id='${com.main_genre_name}']").append("<li class='subLi'>"+jsonObj[i].sub_genre_name+"</li>")
							  }
		        		   }
		        		})
	        		</script>
	        	</li>
	        </c:forEach>
        </ul>
	</div>
	<div id="storeContainer">
		<h1 id="genre"></h1>
		<ul id="order">
			<li id="orderByDefault">기본정렬</li>
			<li id="orderBySellCnt">판매량순</li>
			<li id="orderByHighPrice">최고가순</li>
			<li id="orderByLowPrice">최저가순</li>
			<li id="orderByGrade">평점순</li>
		</ul>
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
										showStar(${dto.grade});
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
		<ul id="listPage">
			<li class="first"><<</li>
			<li class="before"><</li>
			<li class="after">></li>
			<li class="last" disabled>>></li>
		</ul>
	</div>
	<div id = "clearBoth"></div>
	<input type = "hidden" value = "${totalPage}" id="totalPage">
	<input type = "hidden" value = "${nowPage}" id = "nowPage">
	<input type = "hidden" value = "${bookGenre}" id="genreHid">
	<input type = "hidden" value = "${order}" id = "orderHid">
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script>
$(function(){
	var genre ="한국소설";
	var totalPage = $("#totalPage").val();
	var genreHid = $("#genreHid").val();
	var nowPage = "";
	$(document).attr("title",genreHid + " - HUMAN24");
	$("#genre").text(genreHid);
	if($("#nowPage").val()=="" || $("#nowPage").val() == null){
		nowPage = 1;
	}else{
		nowPage = $("#nowPage").val();
	}

	for(var i = totalPage; i >= 1; i--){
		 $(".before").after("<li class = page value="+i+" genre = "+genreHid+">"+i+"</li>");
	}
	
	
	
	$(".smallTitle>li").each(function(){
		$(this).click(function(){
			genre = $(this).text();
			location.href='/main/store?genre='+genre;
		})
	})
	$("#listPage li[value="+nowPage+"]").css({"background-color":"black", "color" : "white"});
	$("#listPage li").each(function(){ // 페이지 이동
		$(this).click(function(){
			if($(this).hasClass("first") || $(this).hasClass("before")){
				if(nowPage == 1) alert("첫번째 페이지입니다.");
				else{
					if($(this).hasClass("first")) location.href='/main/store?genre='+genreHid+'&order=${order}&page=1'
					else if($(this).hasClass("before")) location.href='/main/store?genre='+genreHid+'&order=${order}&page='+(nowPage-1)
				}
			}else if($(this).hasClass("after") || $(this).hasClass("last")){
				if(nowPage == totalPage) alert("마지막 페이지입니다.");
				else{
					if($(this).hasClass("after")) location.href='/main/store?genre='+genreHid+'&order=${order}&page='+(nowPage+1)
					else if($(this).hasClass("last")) location.href='/main/store?genre='+genreHid+'&order=${order}&page='+totalPage
				}
			}else if($(this).hasClass("page")) {
				location.href='/main/store?genre='+genreHid+'&order=${order}&page='+($(this).attr('value'));
			}
		})
	})
	if($("#orderHid").val() == 0){
		$("#orderByDefault").css("color", "#2730ad");
	}else if($("#orderHid").val() == 1){
		$("#orderBySellCnt").css("color", "#2730ad");
	}else if($("#orderHid").val() == 2){
		$("#orderByHighPrice").css("color", "#2730ad");
	}else if($("#orderHid").val() == 3){
		$("#orderByLowPrice").css("color", "#2730ad");
	}else if($("#orderHid").val() == 4){
		$("#orderByGrade").css("color", "#2730ad");
	}
	$("#orderBySellCnt").click(function(){
		location.href = '/main/store?genre='+genreHid+'&page=1&order=1';
	})
	$("#orderByHighPrice").click(function(){
		location.href = '/main/store?genre='+genreHid+'&page=1&order=2';
	})
	$("#orderByLowPrice").click(function(){
		location.href = '/main/store?genre='+genreHid+'&page=1&order=3';
	})
	$("#orderByGrade").click(function(){
		location.href = '/main/store?genre='+genreHid+'&page=1&order=4';
	})
})
</script>
</html>