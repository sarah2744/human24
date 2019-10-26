<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_book_list.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<jsp:include page="admin_header.jsp" flush="true" />
<div id="wrap">
        <div id="wrapping">
            <div id="subMenu">
                <ul>
                    <li class="subOn" onclick="window.location.href='/main/admin/book/list'">도서 관리</li>
                    <li onclick="window.location.href='/main/admin/book/weekDiscount'">주말특가 관리</li>
                    <li onclick="window.location.href='/main/admin/book/discountBook'">할인 책 관리</li>
                    <li onclick="window.location.href='/main/admin/book/genreBigList'">장르 관리</li>
                </ul>
            </div>
            <section>
                <div id="section">
                    <div id="shadowDiv" style="margin-bottom:150px;">
                        <div id="titleDiv">
                            <h1>관리자 > 도서관리 > 책 리스트</h1>
                        </div>
                        <p id="genreP">
                        	<input type="button" class = "btn" value="장르별보기" id="genreBtn">
                        	<%-- <input type="button" class = "btn" value="기본 할인율 설정" id="disPerConfig">
							<span id="disPerConfigWrap">
								<input type="text" placeholder="기본 할인율을 입력하세요." id="defaultDisPerField" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">
								<input type="button" class = "btn" value="입력" id="defaultDisPerSubmit">
								<input type="button" class = "btn" value="취소" id="defaultDisPerCancel">
							</span> --%>
                        </p>                        
                        <div id="orderP">
                            <ul id="order">
                                <li id="default" class="orderLi">기본정렬</li>
                                <li id="orderBySellCnt" class="orderLi">판매량순</li>
                                <li id="orderByHighPrice" class="orderLi">최고가순</li>
                                <li id="orderByLowPrice" class="orderLi">최저가순</li>
                                <li id="orderByGrade" class="orderLi">평점순</li>
                            </ul>
                        </div>
                        <div id="searchDiv">
							<select id="schSelect" class="searchField">
								<option value="booktitle">제목</option>
								<option value="writer">작성자</option>
								<option value="publisher">출판사</option>
                        	</select> 
	                        <input type="text" placeholder="search" class="searchField" id="searchField">
	                        <button id="schBtn"><i class="fas fa-search"></i></button>
	                        <span id="listTitle"></span>
	                    </div>
                        <table id="listTbl" style="width: 100%;">
	                        <colgroup>
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="9%">
								<col width="15%">
								<col width="7%">
								<col width="7%">
								<col width="6%">
								<col width="6%">
								<col width="7%">
								<col width="6%">
								<col width="6%">
								<col width="8%">
							</colgroup>
                            <thead>
                                <tr>
                                    <th>책 고유번호</th>
                                    <th>대 장르</th>
                                    <th>소 장르</th>
                                    <th>책 이미지</th>
                                    <th>책제목</th>
                                    <th>저자</th>
                                    <th>출판사</th>
                                    <th>가격</th>
                                    <th>판매량</th>
                                    <th>평점</th>
                                    <th>댓글수</th>
                                    <th>할인률</th>
                                    <th>주말할인</th>
                                </tr>
                            </thead>
                            <tbody>
                                 <c:forEach items="${bookList}" var="com">
							        <tr id="bookTr" booknum="${com.booknum}">
							        	<td>${com.booknum}</td>
							        	<td>${com.main_genre}</td>
							        	<td>${com.genre}</td>
							        	<td><img src="${pageContext.request.contextPath}/resources/${com.booknum}.jpg" alt=""></td>
							        	<td class="btitle">${com.booktitle}</td>
							        	<td>${com.writer}</td>
							        	<td>${com.publisher}</td>
							        	<td>${com.price}</td>
							        	<td>${com.sales_cnt}</td>
							        	<td>
											<span class="blueStar gradeStar" id="gradeStar">
												<script>
													showStar(${com.grade/com.com_cnt});
												</script>
											</span>
											<span class="grayStar gradeStar" id="gradeStar">
												<script>
													showGrayStar(${5-(com.grade/com.com_cnt)});
												</script>	
											</span>
										</td>
							        	<td>${com.com_cnt}</td>
							        	<td>
											<script>
		                                		document.write(parseInt("${100-(com.dis_per*100)}")+"%");
		                                	</script>
							        	</td>
							        	<td>
							        		<script>
							        			dis_per = ${com.dis_index};
							        			if(dis_per == 0)
							        			{
							        				document.write('<p>N</p>');
							        			}
							        			else
							        			{
							        				document.write('<p>Y</p>');
							        			}
							        		</script>
							        	</td>
							        </tr>
						        </c:forEach>
                            </tbody>
                        </table>
                        <ul id="listPage">
						  <li class="first"><<</li>
						  <li class="before"><</li>
						  <li class="after">></li>
						  <li class="last">>></li>
                        </ul>
                        <div style="width: 100%; text-align: right;"><input type="button" onclick="location.href='/main/admin/book/add'" value="책 추가" class="btn" id="boardAddBtn"></div>
                    </div>
                </div>
            </section>
        </div>
        <div class="clear"></div>
        <input type="hidden" value="${order}" id="order">
    </div>
</body>
<script>
$(function(){
	var tmpUrl = "";
	var call = "${call}";
	var oder = $("#order").val();
	if(order == "" || order == null) $("#orderByDefault").addClass("orderOn");
	$(".orderLi[id=${order}]").addClass("orderOn");
	
	if(call == "mainGenre"){
		tmpUrl = '&mainGenre=${mainGenre}'
		$("#listTitle").text("대장르 : ${genreName}")
	}else if(call == "subGenre"){
		tmpUrl = '&subGenre=${subGenre}'
		$("#listTitle").text("소장르 : ${genreName}")
	}else if(call == "sch"){
		tmpUrl = '&sel=${sel}&schText=${schText}'
		var schTitle = "";
		
		if("${sel}" == "booktitle") schTitle = "제목";
		else if("${sel}" == "booktitle") schTitle = "작성자";
		else if("${sel}" == "booktitle") schTitle = "출판사";
		
		$("#listTitle").text(schTitle + " : ${schText}");
	}
	$(".orderLi").click(function(){
		location.href='/main/admin/book/list?call=${call}&order='+$(this).attr("id")+'&nowPage=1'+tmpUrl
	})
	
	$("#bookManage").addClass("mainOn");
	$("#genreBtn").click(function(){
		var popupX = (window.screen.width / 2) - (200 / 2) - 500;
		var popupY= (window.screen.height / 2) - (300 / 2) - 250;
		window.open('/main/admin/book/genreSelectPopup', '장르 선택', 'width=1300, height=700, menubar=no, status=no, scrollbars=no, toolbar=no, left=' + popupX + ' ,top=' + popupY);
	})
/* 	$("#disPerConfig").click(function(){
		$("#disPerConfigWrap").css("display","inline-block");
	})
	$("#defaultDisPerCancel").click(function(){
		$("#disPerConfigWrap").css("display","none");
	})
	$("#defaultDisPerSubmit").click(function(){
		if($("#defaultDisPerField").val()=="") alert("할인률을 입력해주세요.");
		else window.location.href = "";
	}) */
	
	
// 페이징 ////////////////////////////////////////////////////////////////
	
	var pagePrint = 0;
	var nowPage = ${nowPage};
	var totalPage = ${totalPage};
    if(nowPage%5==0) pagePrint = parseInt(nowPage / 5);
    else pagePrint = parseInt(nowPage / 5) + 1;
    
    if(5*pagePrint > totalPage){
	    for(var i = totalPage; i>= (5*pagePrint)-4; i--){
	 	   $(".before").after("<li class = page value="+i+">"+i+"</li>");
	    }	   
    }else{
	    for(var i = 5*pagePrint; i>= (5*pagePrint)-4; i--){
		   $(".before").after("<li class = page value="+i+">"+i+"</li>");
	    }
    }
   
    $("#listPage li[value="+nowPage+"]").css({"background-color":"black", "color" : "white"});
   
    $("#listPage li").each(function(){ // 페이지 이동
	    $(this).click(function(){
			if($(this).hasClass("first") || $(this).hasClass("before")){
				if(nowPage == 1) alert("첫번째 페이지입니다.");
				else{
					if($(this).hasClass("first")) location.href='/main/admin/book/list?call=${call}&order=${order}&nowPage=1'+tmpUrl
					else if($(this).hasClass("before")) location.href='/main/admin/book/list?call=${call}&order=${order}&nowPage='+(nowPage-1)+tmpUrl
				}
			}else if($(this).hasClass("after") || $(this).hasClass("last")){
				if(nowPage == totalPage) alert("마지막 페이지입니다.");
				else{
					if($(this).hasClass("after")) location.href='/main/admin/book/list?call=${call}&order=${order}&nowPage='+((nowPage*1)+1)+tmpUrl
						else if($(this).hasClass("last")) location.href='/main/admin/book/list?call=${call}&order=${order}&nowPage='+totalPage+tmpUrl
					}
				}else if($(this).hasClass("page")) {
					location.href='/main/admin/book/list?call=${call}&order=${order}&nowPage='+($(this).attr('value'))+tmpUrl;
				}
		})
	})
	$("#searchField").keydown(function(key) {
		if(key.keyCode == 13) $("#schBtn").trigger("click");
	})	
	$("#schBtn").click(function(){
		window.location.href = "/main/admin/book/list?call=sch&sel="+$("#schSelect option:selected").val()+"&schText="+$("#searchField").val();
	})
	  ////////////////////////////////////////////////////////////////////////
})
.on('click', '#bookTr', function(){
	var booknum = $(this).attr("booknum");
	window.location.href = "/main/admin/book/detail?booknum="+booknum+"&updateFlag=0";
})
</script>
</html>