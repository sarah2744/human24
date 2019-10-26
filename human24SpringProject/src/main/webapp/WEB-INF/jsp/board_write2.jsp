<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_write.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>
</head>
<body>
<jsp:include page="header.jsp" flush="true" />
   <div id="wrap" class="w3-container">
      <h1 id="title"></h1>
      <table id="boardtbl">
         <tr>
            <td>* 제목</td>
            <td><input type="text" id="inputtitle" value="${board.title}"></td>
         </tr>
         <tr>
            <td>* 내용</td>
            <td><textarea name="contents" id="contents" cols="30" rows="10">${board.contents}</textarea></td>
            <input type="hidden" value="${board.board_num}" id="board_num">
         </tr>
         <tr>
            <td>파일 첨부</td>
            <td><input type="file"></td>
         </tr>
         <tr>
            <td colspan=2><input type="button" value="수정" class="btn" id="writebtn">
               <input type="button" value="이전" class="btn"
               onclick="window.history.go(-1)"></td>
         </tr>
      </table>
   </div>
   <jsp:include page="footer.jsp" flush="true" />
   <input type="hidden" value="${board_index}" id="hid">
</body>
<script type="text/javascript">
$(function(){
   var board_index = $('#hid').val();
   var boardName = "";
   
   if(board_index == 1) boardName = "고객센터";
   else if(board_index == 2) boardName = "공지사항";
   else if(board_index == 3) boardName = "중고 책 구매";
   else if(board_index == 4) boardName = "중고 책 판매";
   $(document).attr("title", boardName + " - Human24");
   $("#title").text(boardName);
   $(document).on("click", "#writebtn", function() {
      var title = $("#inputtitle").val();
      var contents = $("#contents").val();
      var board_num = $("#board_num").val();
      var board_index = $('#hid').val();
      $.ajax
      ({
         url : '${pageContext.request.contextPath}/board/update?title='+ title + '&contents=' + contents + '&board_num=' + board_num + '&board_index=' + board_index,
         type : 'get',
         success : function(data) 
         {
            alert("수정완료");
            window.location.href = "/main/board?board_index="+board_index;
         }, 
         error : function() 
         {
            alert("앙대");
           }
      })
   })
})
</script>
</html>