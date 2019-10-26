<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_header.css"> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_detail.css">
<link rel="stylesheet" href="admin_header.css">
<link rel="stylesheet" href="admin_detail.css">
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
<title></title>
</head>
<style>
    #shadowDiv{
        margin-bottom: 300px;
    }
</style>
<script>
	var dis_per = 0;
</script>
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
                    <div id="shadowDiv">
                        <div id="titleDiv">
                            <h1>관리자 > 도서관리 > 책 정보</h1>
                        </div>
                        <table id="detailTbl">
                            <tr>
                                <th scope="col">책 고유번호</th>
                                <td scope="col" id="book_num">${bookdetail.booknum}</td>
                            </tr>
                            <tr>
                                <th scope="col">대 장르</th>
                                <td scope="col">${bookdetail.main_genre}</td>
                            </tr>
                            <tr>
                                <th scope="col">소 장르</th>
                                <td scope="col">${bookdetail.genre}</td>
                            </tr>
                            <tr>
                                <th scope="col">책 제목</th>
                                <td scope="col">${bookdetail.booktitle}</td>
                            </tr>	 
                            <tr>
                                <th scope="col">책 이미지</th>
                                <td scope="col"><img src="${pageContext.request.contextPath}/resources/${bookdetail.booknum}.jpg" alt=""></td>
                            </tr>	 
                            <tr>
                            	<th scope="col">저자</th>
                                <td scope="col">${bookdetail.writer}</td>
                            </tr>
                            <tr>
                            	<th scope="col">출판사</th>
                                <td scope="col">${bookdetail.publisher}</td>
                            </tr>
                            <tr>
                                <th scope="col">가격</th>
                                <td scope="col">${bookdetail.price}</td>
                            </tr> 						 
                            <tr>
                                <th scope="col">판매량</th>
                                <td scope="col">${bookdetail.sales_cnt}</td>
                            </tr>						 
                            <tr>
                                <th scope="col">평점</th>
                                <td scope="col">${bookdetail.grade}</td>
                            </tr>
                            <tr>
                                <th scope="col">댓글수</th>
                                <td scope="col">${bookdetail.com_cnt}</td>
                            </tr>
                            <tr>
                                <th scope="col">할인율</th>
                                <td scope="col">
                                	<script>
                                		document.write('<p>'+parseInt("${100-(bookdetail.dis_per*100)}")+'%</p>');
							        </script>
                                </td>
                            </tr>
                            <tr>
                                <th scope="col">주말할인</th>
                                <td scope="col">
                                	<script>
                                	dis_per = ${bookdetail.dis_index};
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
                            <tr>
                                <th scope="col">책 상세정보</th>
                                <td scope="col">${bookdetail.book_intro}</td>
                            </tr>
                            <tr>
                                <td colspan="4" class="buttonTd">
                                    <button onclick="window.location.href='/main/admin/book/modify?booknum=${bookdetail.booknum}'">수정</button>
                                    <button onclick="" id="deleteBook">삭제</button>
                                    <button onclick="window.location.href='/main/admin/book/list'">목록</button>
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
	$(".goDetail").click(function(){
		window.location.href="/main/admin/user/detail";
	})
})
.on('click', '#deleteBook', function(){
	var flag = confirm("정말로 삭제하시겠습니까?");
	if(flag) window.location.href="/main/admin/book/list2?booknum="+$('#book_num').text();
	else return false;
})
</script>
</html>