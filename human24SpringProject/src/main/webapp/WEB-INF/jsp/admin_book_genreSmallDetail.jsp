<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_board_config.css">
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
                    <div id="shadowDiv" style="margin-bottom: 300px;">
                        <div id="titleDiv">
                            <h1>관리자 > 장르 관리 > 소 장르 정보</h1>
                        </div>
                        <table id="writeTbl">
                            <tr>
                                <th scope="col">장르번호</th>
                                <td scope="col" id="sub_genre_num">${genre.sub_genre_num}</td>
                            </tr>
                            <tr>
                                <th scope="col">대 장르</th>
                                <td scope="col" >${genre.main_genre_name}</td>
                            </tr>
                            <tr>
                                <th scope="col">소 장르</th>
                                <td scope="col">${genre.sub_genre_name}</td>
                            </tr>
                            <tr>
                                <th scope="col">사용</th>
                                <td scope="col">
                                	<script>
	                                    use = ${genre.use}
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
                            </tr>	 
                            <tr>
                                <td colspan="4" class="buttonTd" style="text-align: center;">
                                    <button onclick="" id="updateBtn">수정</button>
                                    <button onclick="" id="deleteBtn">삭제</button>
                                    <button onclick="window.location.href='/main/admin/book/genreSmallList?main_genre_num=${genre.main_genre_num}&num=0'">목록</button>
                                </td>                                
                            </tr>
                        </table>
                    </div>
                </div>
            </section>
        </div>
        <div class="clear"></div>
    </div>
    <input type="hidden" value="${genre.main_genre_num}" id="main_genre_num"></input>
</body>
<script>
$(function(){
	$("#bookManage").addClass("mainOn");
})
.on('click', '#updateBtn', function(){
	window.location.href='/main/admin/book/genreSmallModify?sub_genre_num=${genre.sub_genre_num}';
})
.on('click', '#deleteBtn', function(){
	var flag = confirm( '해당 장르의 책이 모두 삭제됩니다.\n정말로 삭제하시겠습니까?' );
	console.log('${genre.sub_genre_name}');
    if(flag) window.location.href = "/main/admin/book/genreSmallList?sub_genre_num=${genre.sub_genre_num}&main_genre_num=${genre.main_genre_num}&num=1&sub_genre_name=${genre.sub_genre_name}&num=1";
    else return false;
	
})
</script>
</html>