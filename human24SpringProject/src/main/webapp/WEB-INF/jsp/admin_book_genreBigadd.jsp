<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_board_config.css">
</head>
<style>
	#listTbl{
		width: 100% !important;
	}
	#listTbl td, #listTbl th{
		text-align: left;
		padding: 20px;
	}
	#listTbl th{
		width: 15%;
	}
</style>
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
                            <h1>관리자 > 장르 관리 > 대 장르 추가</h1>
                        </div>
                        <table id="writeTbl">
                            <tr>
                                <th scope="col">대 장르</th>
                                <td scope="col"><input type="text" id="genreName"></input></td>
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
                                <td colspan="4" class="buttonTd" style="text-align: center">
                                    <button onclick="" id="insertBtn">추가</button>
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
})
.on('click', '#insertBtn', function(){
	var genreName = $('#genreName').val();
	var use = $('input[name="weekDis"]:checked').val();
	$.ajax
	({
	   url : "/main/insertGenre?genreName="+genreName+"&use="+use,
	   type : 'get',
	   success : function(data) 
	   {
		   alert("장르 추가 성공");
	       window.location.href = '/main/admin/book/genreBigList';
	   }, 
	   error : function() 
	   {
	      alert("실패");
	    }
	})
})
</script>
</html>