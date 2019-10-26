<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_board_config.css">
</head>
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
                            <h1>관리자 > 장르 관리 > 소 장르 수정</h1>
                        </div>
                        <table id="writeTbl">
                            <tr>
                                <th scope="col">대 장르</th>
                                <td scope="col" id="main_genre_name">${genre.main_genre_name}</td>
                            </tr>
                            <tr>
                                <th scope="col">소 장르</th>
                                <td scope="col">
                                    <input type="text" value="" style="width: 150px;" id="sub_genre_name">
                                </td>
                            </tr>
                            <tr>
                                <th scope="col">사용</th>
                                <td scope="col">
                                    <input type="radio" id="genreShow" name="weekDis" value="1" checked>
                                    <label for="genreShow">Y</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="radio" id="genreHide" name="weekDis" value="2">
                                    <label for="genreHide">N</label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="buttonTd">
                                    <button onclick="" id="insertBtn">소장르 추가</button>
                                    <button onclick="">목록</button>
                                    <button onclick="history.go(-1)">이전페이지</button>
                                </td>                                
                            </tr>
                        </table>
                    </div>
                </div>
            </section>
        </div>
        <div class="clear"></div>
    </div>
    <a href="./admin_book_detail.html"></a>
    <input type="hidden" value="${genre.main_genre_num}" id="main_genre_num"></input>
</body>
<script>
$(function(){
	$("#bookManage").addClass("mainOn");
    $(".numField").each(function(){
	   $(this).keyup(function(key) {
	   	     var reg = /[^0-9]/gi;
	         var v = $(this).val();
	         if (reg.test(v)) {
	             $(this).val(v.replace(reg, ''));
	             $(this).focus();
	             return false;
	         }
	   })
   })
})
.on('click', '#insertBtn', function(){
	var main_genre_num = $("#main_genre_num").val();
	var sub_genre_name = $('#sub_genre_name').val();
	var use = $('input[name="weekDis"]:checked').val();
	var main_genre_name = $('#main_genre_name').text();
	console.log(main_genre_num);
	console.log(sub_genre_name);
	console.log(use);
	console.log(main_genre_name);

	$.ajax
	({
	   url : "/main/insertSubGenre?main_genre_num="
		   +main_genre_num+"&sub_genre_name="+sub_genre_name+"&use="+use+"&main_genre_name="+main_genre_name+"&num=1",
	   type : 'get',
	   success : function(data) 
	   {
		   var main_genre_num = $("#main_genre_num").val();
		   alert("장르 추가 성공");
	       window.location.href = "/main/admin/book/genreSmallList?main_genre_num="+main_genre_num;
	   }, 
	   error : function() 
	   {
	      alert("실패");
	   }
	})
})
</script>
</html>