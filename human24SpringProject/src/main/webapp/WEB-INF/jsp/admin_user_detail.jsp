<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_detail.css">
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
<title>회원관리</title>
</head>
<script>
	var admin_index = 0;
	var age = 0;
	var  thisDate = new Date();
	var thisYear = thisDate.getFullYear();
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<jsp:include page="admin_header.jsp" flush="true" />
<div id="wrap">
        <div id="wrapping">
            <div id="subMenu">
                <ul>
                    <li class="subOn" onclick="window.location.href='/main/admin/user/list'">회원 리스트</li>
                    <li onclick="window.location.href='/main/admin/user/blacklist'">블랙리스트</li>
                    <li onclick="window.location.href='/main/admin/user/adminlist'">관리자 리스트</li>
                </ul>
            </div>
            <section>
                <div id="section">
                    <div id="shadowDiv" style="margin-bottom:250px;">
                        <div id="titleDiv">
                            <h1>관리자 > 회원관리 > 회원정보보기</h1>
                        </div>
                        <table id="detailTbl">
                            <tr>
                                <th scope="col">이름</th>
                                <td scope="col">${memberList.user_name}</td>
                            </tr>
                            <tr>
                                <th scope="col">아이디</th>
                                    <td scope="col">${memberList.user_id}</td>
                                </td>
                            </tr>	 
                            <tr>
                                <th scope="col">성별</th>
                                    <td scope="col">${memberList.gender}</td>
                                </td>
                            </tr>	 
                            <tr>
                                <th scope="col">나이</th>
                                <td scope="col">
                                	<script>
	                                	var birth = "${memberList.birth}";
					        			console.log("birth = " + birth);
					        			var year = birth.substr(0,4);
					        			console.log("year = " + year);
					        			age = thisYear - year +1;
					        			document.write('<p>' + age + '</p>');
							        </script>
							    </td>
                            </tr> 						 
                            <tr>
                                <th scope="col">연락처</th>
                                <td scope="col">${memberList.mobile}</td>
                            </tr>						 
                            <tr>
                                <th scope="col">생년월일</th>
                                <td scope="col">${memberList.birth}</td>
                            </tr>
                            <tr>
                                <th scope="col">가입일자</th>
                                <td scope="col">2019/09/30</td>
                            </tr>
                            <tr>
                                <th scope="col">구매횟수</th>
                                <td scope="col">${memberList.pur_count}</td>
                            </tr>
                            <tr>
                                <th scope="col">포인트</th>
                                <td scope="col">${memberList.user_point}</td>
                            </tr>
                            <tr>
                                <th scope="col">권한</th>
                                <td scope="col">
                                	<script>
							        	admin_index = ${memberList.admin_index};
							        	if(admin_index == 0) document.write('<p>회원</p>');
							        	else if(admin_index == 1) document.write('<p>관리자</p>');
							        	else if(admin_index == 2) document.write('<p>블랙리스트</p>');
							        </script>
                                </td>
                            </tr>
                            <tr>
                                <th scope="col">이메일</th>
                                <td scope="col">${memberList.mail}</td>
                            </tr>
                            <tr>
                                <th scope="col">주소</th>
                                <td scope="col">${memberList.adr}</td>
                            </tr>
                            <tr>
                                <td colspan="4" class="buttonTd">
                                    <button onclick="history.go(-1)">목록</button>
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
	$("#userManage").addClass("mainOn");
	$(".goDetail").click(function(){
		window.location.href="/main/admin/user/detail";
	})
})
</script>
</html>