<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                    <div id="shadowDiv" style="margin-bottom: 300px;">
                        <div id="titleDiv">
                            <h1>관리자 > 장르 관리 > 대 장르 수정</h1>
                        </div>
                        <table id="writeTbl">
                            <tr>
                                <th scope="col">장르번호</th>
                                <td scope="col" id="main_genre_num">${genre.main_genre_num}</td>
                            </tr>
                            <tr>
                                <th scope="col">대 장르</th>
                                <td scope="col"><input type="text" value="${genre.main_genre_name}" id="main_genre_name"></td>
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
                                    <button onclick="" id="updateBtn">수정</button>
                                    <button onclick="window.location.href='/main/admin/book/genreBigList'">목록</button>
                                </td>                                
                            </tr>
                        </table>
                    </div>
                </div>
            </section>
        </div>
        <div class="clear"></div>
    </div>
</body>
<script>
$(function(){
	$("#bookManage").addClass("mainOn");
	$(".useRadio[value=${genre.use}]").attr("checked","checked");
})
.on('click', '#updateBtn', function(){
	var main_genre_name = $('#main_genre_name').val();
	var use = $('input[name="weekDis"]:checked').val();
	var main_genre_num = $('#main_genre_num').text();
	window.location.href = "/main/admin/book/genreBigDetail?main_genre_name="+main_genre_name+
			"&use="+use+"&main_genre_num="+main_genre_num+"&num=0";
})
</script>
</html>