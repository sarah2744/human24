<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_board_config.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_book_genreSmallModify.css">
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
                                <th scope="col">장르번호</th>
                                <td scope="col" id="sub_genre_num">${genre.sub_genre_num}</td>
                            </tr>
                            <tr>
                                <th scope="col">대 장르</th>
                                <td scope="col">
                                    <select name="" id="main_genre_name">
                                        <option value="">선택하세요.</option>
                                        <c:forEach items="${genreMain}" var="com">
                                        	<option value="${com.main_genre_num}" class="mainoption">${com.main_genre_name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th scope="col">소 장르</th>
                                <td scope="col">
                                    <input type="text" value="${genre.sub_genre_name}" style="width: 150px;" id="sub_genre_name">
                                </td>
                            </tr>
                            <tr>
                                <th scope="col">사용</th>
                                <td scope="col">
                                    <input type="radio" id="genreShow" name="weekDis" value="1" class="useRadio">
                                    <label for="genreShow">Y</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="radio" id="genreHide" name="weekDis" value="2" class="useRadio">
                                    <label for="genreHide">N</label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="buttonTd">
                                    <button id="updateBtn">수정</button>
                                    <button onclick="window.location.href='/main/admin/book/genreSmallList?main_genre_num=${genre.main_genre_num}&num=0'">목록</button>
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
</body>
<script>
$(function(){
	$("#bookManage").addClass("mainOn");
	$(".useRadio[value=${genre.use}]").attr("checked","checked");
	$("#main_genre_name").val("${genre.main_genre_num}").attr("selected","selected");
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
.on('click', '#updateBtn', function(){
	var main_genre_num = $("#main_genre_name option:selected").val();
	var sub_genre_name = $('#sub_genre_name').val();
	var sub_genre_num = $('#sub_genre_num').text();
	var use = $('input[name="weekDis"]:checked').val();
	window.location.href = "/main/admin/book/genreSmallDetail?main_genre_num="+main_genre_num+
			"&sub_genre_name="+sub_genre_name+"&sub_genre_num="+sub_genre_num+"&use="+use+"&num=0";
})
</script>
</html>