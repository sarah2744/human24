<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_book_genreSmallList.css">
<title>Insert title here</title>
</head>
<script>
	var use = 0;
</script>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<jsp:include page="admin_header.jsp" flush="true" />
<div id="wrap">
        <div id="wrapping">
            <div id="subMenu">
                <ul>
                    <li onclick="window.location.href='/main/admin/book/list'">도서 관리</li>
                    <li onclick="window.location.href='/main/admin/book/weekDiscount'">주말특가 관리</li>
                    <li onclick="window.location.href='/main/admin/book/discountBook'">할인 책 관리</li>
                    <li class="subOn" onclick="window.location.href='/main/admin/book/genreBigList'">장르 관리</li>
                </ul>
            </div>
            <section>
                <div id="section">
                    <div id="shadowDiv">
                        <div id="titleDiv">
                            <h1>관리자 > 장르 관리 > 장르 관리 (소 장르)</h1>
                        </div>
                        <table id="listTbl">
                            <colgroup>
                                <col width="10%" />
                                <col width="25%" />
                                <col width="25%" />
                                <col width="10%" />
                                <col width="30%" />
                            </colgroup> 
                            <thead>
                                <tr>
                                    <th scope="col">장르 번호</th>
                                    <th scope="col">대 장르</th>
                                    <th scope="col">소 장르</th>
                                    <th scope="col">사용</th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${genre}" var="com">
	                                <tr>
	                                    <td scope="col">${com.main_genre_num}</td>
	                                    <td scope="col">${com.main_genre_name}</td>
	                                    <td scope="col">${com.sub_genre_name}</td>
	                                    <td scope="col">
	                                    	<script>
	                                    		use = ${com.use}
	                                    		if(use == 1)
	                                    		{
	                                    			document.write('<p>Y</p>');
	                                    		}
	                                    		else
	                                    		{
	                                    			document.write('<p>N</p>');
	                                    		}
	                                    	</script>
	                                    </td>
	                                    <td scope="col">
	                                    	<input type="button" value="상세보기" class="btn2 goDetail" id="goDetail" genrenum = "${com.sub_genre_num}">
	                                    	<input type="button" value="장르 책 보기" class="btn2 goDetail" id="goGenreBookList" genrename = "${com.sub_genre_name}">
	                                    </td>
	                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div style="width: 100%; text-align: right;"><input type="button" value="소 장르 추가" class="btn" id="boardAddBtn"></div>
                    </div>
                </div>
            </section>
        </div>
        <div class="clear"></div>
    </div>
    <input type="hidden" value="${main_genre_num}" id="main_genre_num"></input>
</body>
<script>
$(function(){
	$("#bookManage").addClass("mainOn");
})
.on('click', '#goDetail', function(){
	var sub_genre_num = $(this).attr("genrenum");
	window.location.href="/main/admin/book/genreSmallDetail?sub_genre_num="+sub_genre_num+"&num=1";
})
.on('click', '#boardAddBtn', function(){
	var main_genre_num = $('#main_genre_num').val();
	window.location.href="/main/admin/book/genreSmalladd?main_genre_num="+main_genre_num;
})
.on('click', '#goGenreBookList', function(){
	window.location.href="/main/admin/book/list?call=subGenre&subGenre="+$(this).attr("genrename");
})
</script>
</html>