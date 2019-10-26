<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_book_weekDiscount.css">
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<jsp:include page="admin_header.jsp" flush="true" />
<div id="wrap">
        <div id="wrapping">
            <div id="subMenu">
                <ul>
                    <li onclick="window.location.href='/main/admin/book/list'">도서 관리</li>
                    <li class="subOn" onclick="window.location.href='/main/admin/book/weekDiscount'">주말특가 관리</li>
                    <li onclick="window.location.href='/main/admin/book/discountBook'">할인 책 관리</li>
                    <li onclick="window.location.href='/main/admin/book/genreBigList'">장르 관리</li>
                </ul>
            </div>
            <section>
                <div id="section">
                    <div id="shadowDiv">
                        <div id="titleDiv">
                            <h1>관리자 > 도서관리 > 주말특가 관리</h1>
                        </div>
                        <table id="listTbl">
                            <thead>
                                <tr>
                                    <th>책 고유번호</th>
                                    <th>대 장르</th>
                                    <th>소 장르</th>
                                    <th>책 이미지</th>
                                    <th>책제목</th>
                                    <th>가격</th>
                                    <th>판매량</th>
                                    <th>평점</th>
                                    <th>댓글수</th>
                                    <th>할인률</th>
                                    <th>주말할인</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>A1_1</td>
                                    <td>컴퓨터</td>
                                    <td>컴퓨터 개발</td>
                                    <td><img src="./A1_1.jpg" alt=""></td>
                                    <td class="btitle">이것이 자바다</td>
                                    <td>20,000</td>
                                    <td>9185</td>
                                    <td><span class="blueStar">★★★★</span><span class="grayStar">★</span></td>
                                    <td>45</td>
                                    <td>10%</td>
                                    <td>N</td>
                                    <td><input type="button" value="주말특가해제" class="btn2 goDetail"></td>
                                </tr>
                                <tr>
                                    <td>A1_1</td>
                                    <td>컴퓨터</td>
                                    <td>컴퓨터 개발</td>
                                    <td><img src="./A1_1.jpg" alt=""></td>
                                    <td class="btitle">이것이 자바다</td>
                                    <td>20,000</td>
                                    <td>9185</td>
                                    <td><span class="blueStar">★★★★</span><span class="grayStar">★</span></td>
                                    <td>45</td>
                                    <td>10%</td>
                                    <td>N</td>
                                    <td><input type="button" value="주말특가해제" class="btn2 goDetail"></td>
                                </tr>
                            </tbody>
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
</script>
</html>