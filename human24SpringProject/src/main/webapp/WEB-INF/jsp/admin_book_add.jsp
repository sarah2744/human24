<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_book_modify.css">
<style>
	#listTbl tr td img{
		width: 120px;
		height: 170px;
	}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
                        <form id="bookModify" action="bookInsert" method="POST">
	                        <table id="listTbl" style="width: 100%;">
	                           <colgroup>
		                          <col width="20%" />
		                          <col width="80%" />
		                       </colgroup>
	                            <tr>
	                                <th scope="col">대 장르</th>
	                                <td scope="col">
	                                    <select name="main_genre" id="main_genre_name">
	                                        <c:forEach items="${genreMain}" var="com">
	                                        	<option value="${com.main_genre_name}" class="mainoption">${com.main_genre_name}</option>
	                                        </c:forEach>
	                                    </select>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="col">소 장르</th>
	                                <td scope="col">
	                                    <select name="sub_genre" id="sub_genre_name">
	                                    	<option id="subOption" value="${bookmodify.genre}">${bookmodify.genre}</option>
	                                    </select>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="col">책 제목</th>
	                                <td scope="col"><input type="text" id="booktitle" name="booktitle"></td>
	                            </tr>    
	                            <tr>
	                                <th scope="col">저자</th>
	                                <td scope="col"><input type="text" id=writer name="writer"></td>
	                            </tr>
	                            <tr>
	                                <th scope="col">출판사</th>
	                                <td scope="col"><input type="text" id="publisher" name="publisher"></td>
	                            </tr>
	                            <tr>
	                                <th scope="col">책 이미지</th>
	                                <td scope="col"></td>
	                            </tr>    
	                            <tr>
	                                <th scope="col">가격</th>
	                                <td scope="col"><input type="text" id="price" name="price" class="numField" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"></td>
	                            </tr>               
	                            <tr>
	                                <th scope="col">할인율</th>
	                                <td scope="col">
	                                	<input type="text" id = "dis_per" name="dis_per" class="numField" value="0" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">%
	                                </td>
	                                
	                            </tr>
	                            <tr>
	                                <th scope="col">주말할인</th>
	                                <td>
	                                    <input type="radio" id="weekDisYes" name="dis_index" value="1"/>
	                                    <label for="weekDisYes">Y</label>&nbsp;&nbsp;&nbsp;&nbsp;
	                                    <input type="radio" id="weekDisNo" name="dis_index" value="0" checked/>
	                                    <label for="weekDisNo">N</label>
	                                </td>
	                            </tr>
	                            <tr>
	                                <th scope="col">책 상세정보</th>
	                                <td scope="col"><textarea id="book_intro" name="book_intro"></textarea></td>
	                            </tr>
	                            <tr>
	                                <td colspan="4" class="buttonTd" style="text-align: center;">
	                                    <button class="btn2" id="bookInsert">등록</button>
	                                    <button onclick="window.location.href='/main/admin/book/list'" class="btn2">목록</button>
	                                    <button onclick="history.go(-1)" class="btn2">이전페이지</button>
	                                </td>
	                            </tr>
	                        </table>
                        </form>
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
   $(".goDetail").click(function(){
        window.location.href="./admin_book_detail.html";
   })
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
   var main_genre_name = $("#main_genre_name option:selected").val();
   console.log(main_genre_name);
   $('#sub_genre_name').empty();
   	  $.ajax({
	     url : "${pageContext.request.contextPath}/admin/genreSub?main_genre_name="+main_genre_name,
	     type : 'get',
	     success : function(data){
		 var subArr = data.split(",");
		 for(i=0; i<=subArr.length-1; i++){
			 $('#sub_genre_name').append("<option class='subOption' value="+subArr[i]+">"+subArr[i]+"</option>");
		 }
	  }
   })
   $(document)
   .on("change", "#main_genre_name", function(){
		var main_genre_name = $("#main_genre_name option:selected").val();
		$('#sub_genre_name').empty();
		 $.ajax({
			   url : "${pageContext.request.contextPath}/admin/genreSub?main_genre_name="+main_genre_name,
			   type : 'get',
			   success : function(data){
				   var subArr = data.split(",");
				   for(i=0; i<=subArr.length-1; i++){
					   $('#sub_genre_name').append("<option class='subOption' value="+subArr[i]+">"+subArr[i]+"</option>");
				   }
				   
			   }
		})
	})
	.on('click', '#bookInsert', function(){
		alert("책이 등록되었습니다.");
		$("#bookInsert").submit();
	}) 	
})
</script>
</html>