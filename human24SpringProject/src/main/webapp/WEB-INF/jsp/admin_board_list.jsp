<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_list_table.css">
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
<title></title>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<jsp:include page="admin_header.jsp" flush="true" />
<div id="wrap">
        <div id="wrapping">
            <div id="subMenu">
                <ul>
                    <li class="subOn" onclick="window.location.href='/main/admin/board/list'">게시판 리스트</li>
                    <li onclick="window.location.href='/main/admin/board/write'">공지사항 작성</li>
                </ul>
            </div>
            <section>
                <div id="section">
                    <div id="shadowDiv">
                        <div id="titleDiv">
                            <h1>관리자 > 게시판관리 > 게시판 리스트</h1>
                        </div>
                        <table id="listTbl">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>유형</th>
                                    <th>게시판번호</th>
                                    <th>게시판명</th>
                                    <th>사이트명</th>
                                    <th>사용여부</th>
                                    <th>업데이트 날짜</th>
                                    <th>게시물건수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach  items="${boardlist}" var="i" varStatus="status">
                                <tr>
                                	<td>${i.board_index}</td>
                                	<td>list</td>
                                	<td>${i.board_index}</td>
                                	<td>${i.board_name}</td>
                                	<td>HUMAN 24</td>
                                	<td>${i.presence}</td>
                                	<td>${i.update_date}</td>
                                	<td id="${status.index}">
                                	</td>
                                		<script>
                                		var index = ${i.board_index}
                                		var count = null;
                                		$.ajax({
                                			url : '${pageContext.request.contextPath}/admin/board/listCount?boardIndex='+index,		
                                				type : 'get',
                                			success : function(data) {
                                				document.getElementById("${status.index}").innerHTML = data;
                                			}
                                		});
                                		</script>
                                </tr>
                                </c:forEach>
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
	$("#boardManage").addClass("mainOn");
	$("#listTbl tr").click(function(){
		var row = $('#listTbl tr').index(this);
		var boardIndex = $('#listTbl tr:eq("'+row+'") td:first-child').text();
		
		window.location.href="/main/admin/board/configView?boardIndex="+boardIndex;
	})
})
</script>
</html>