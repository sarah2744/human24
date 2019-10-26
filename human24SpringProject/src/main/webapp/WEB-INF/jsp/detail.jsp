<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/detail.css">
<link
	href="https://fonts.googleapis.com/css?family=Manjari|Nanum+Gothic&display=swap"
	rel="stylesheet">
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<jsp:include page="header.jsp" flush="true" />
	<div id="wrap">
		<div id="wrapping">
			<div id="imgDiv">
				<img
					src="${pageContext.request.contextPath}/resources/${booklist.booknum}.jpg"
					alt="">
			</div>
			<div id="bookinfoDiv">
				<div id="booktitle">
					<p id="title">${booklist.booktitle}</p>
					<span class="binfo">${booklist.writer} 저</span> <span class="binfo">${booklist.publisher}</span>
					<span class="binfo" id="pdate">${booklist.p_date}</span>
					<p id="emptyP"></p>
					<span id="grade">
						<span class = "blueStar" id = "bs"></span>
						<span class = "grayStarDetail" id = "gs"></span>
					</span> 
					<span id="gradeNum"></span>
					<span id="comcnt">회원리뷰(<span id="comcntNum">${booklist.com_cnt}</span>건)
					</span> <span id="sellcnt">판매지수 ${booklist.sales_cnt}</span>
				</div>
				<div class="borderDiv"></div>
				<div id="wrap2">
					<table>
						<tr id="price">
							<td>정가</td>
							<td><span id="realPrice"></span></td>
						</tr>
						<tr id="discount">
							<td>할인가</td>
							<td><span id="disnum"><span id="bookPrice"></span>원 </span>
								<b style="font-size: 15px;"> (<span id="dis_per"><fmt:formatNumber value="${100-(booklist.dis_per*100)}" pattern="0"/></span>%
									할인)
							</b></td>
						</tr>
						<tr>
							<td>Human24 포인트</td>
							<td><fmt:formatNumber value="${booklist.price*0.05}"
									pattern="0" />원 (5% 적립)</td>
						</tr>
						<tr>
							<td>배송비</td>
							<td>2,500원<br>(30,000원 이상 무료배송)
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="borderDiv"></div>
							</td>
						</tr>
						<tr>
							<td>수량</td>
							<td align="right">
								<div id="order">
									<p>
										<input type="button" id="minus" class="pm" value="-">
										<input type="text" id="cnt" value="1"
											onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">
										<input type="button" id="plus" class="pm" value="+">
									</p>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div style="margin: 79px 0;"></div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<p style="text-align: right;">
									<span id="ordercnttext">총 수량 <span id="ordercnt"></span>개
									</span> <span id="orderPrice"> <span id="orderPriceNum"></span>
										원
									</span>
								</p>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="btntd"><input type="button" value="구매하기"
								class="btn" id="buybtn"> <input type="button"
								value="장바구니" class="btn" id="cartbtn"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<div class="tab_wrap">
			<ul class="tab_btn">
				<li class="on" id="detaillist">상세내용</li>
				<li id="commentlist">댓글달기</li>
				<li id="delilist">배송/반품/교환</li>
			</ul>
			<ul class="tab_cont">
				<li>
					<h1 id="bookintro">책 소개</h1>
					<p id="introcon">${booklist.book_intro}</p>
				</li>
				<li>
					<div id="commentDiv">
						<p>
							<span id="comtitle">한줄평</span> <span id="comcnttext"> (<span
								id="comcnt2">${booklist.com_cnt}</span>건)
							</span>
						</p>
						<p>구매 후 한줄평 작성 시 50 포인트를 드립니다.</p>
						<div id="writeDiv">
							<form>
								<p>
									<span id="gradetxt">평점</span> 
									<span id="star1" class="star">★</span>
									<span id="star2" class="star">★</span> 
									<span id="star3" class="star">★</span> 
									<span id="star4" class="star">★</span> 
									<span id="star5" class="star">★</span> 
									<input type="hidden" id="gradehid">
								</p>
								<textarea id="commenttext"></textarea>
								<input type="button" value="작성" id="submitbtn" class="btn">
								<p id="counter">(0 / 최대 200자)</p>
							</form>
						</div>
						<div id="comlistdiv">
							<table class="w3-table">
								<thead>
									<tr id="commentTh">
										<th>작성자</th>
										<th width="5%">평점</th>
										<th width="50%">내용</th>
										<th >날짜</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="comTbody">
									<c:forEach items="${commentShow}" var="com">
										<tr>
											<td id="com_userid">
												<script>
													if('${com.user_id}' == userid) {
														document.write("<span style = 'color: tomato; font-weight: bold;'>${com.user_id}</span>");
													}
													else document.write("${com.user_id}");
												</script>
											</td>
											<td class="comgrade">
												<span class="blueStar gradeStar" id="gradeStar"> 
													<script>showStar(${com.grade});</script>
												</span> 
												<span class="grayStar gradeStar" id="gradeStar">
													<script>showStar(${5-com.grade});</script> 
												</span>
											</td>
											<td align=center>${com.contents}</td>
											<td style="color: #666; font-size: 12px;">${com.com_date}</td>
											<td>
												<script>
												if("${com.user_id}" == userid){
													document.write("<input type = 'button' value = 'X' id='comDel'><input type = 'hidden' value='${com.com_num}' id='hidComNum'>")
												}
												</script>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</li>
				<li>
					<div id="tradediv">
						<h1 id="tradetitle">배송/반품/교환 안내</h1>
						<h3 id="deliguide">배송 안내</h3>
						<table class="deli">
							<tr>
								<td>배송 구분</td>
								<td>human24 배송</td>
							</tr>
							<tr>
								<td>포장 안내</td>
								<td><p>
										<b style="color: #333;">안전하고 정확한 포장을 위해 CCTV를 설치하여 운영하고
											있습니다.</b>
									</p> <br> 고객님께 배송되는 모든 상품을 CCTV로 녹화하고 있으며, 철저한 모니터링을 통해 작업 과정에
									문제가 없도록 최선을 다 하겠습니다. <br> <br> 목적 : 안전한 포장 관리<br>
									촬영범위 : 박스 포장 작업<br> <br></td>

							</tr>
						</table>
						<h3 id="returnguide">반품/교환안내</h3>
						<p id="returntxt">저희 Human24는 반품 / 교환을 지원하지 않습니다. 신중하게 구매해주세요.</p>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<input type="hidden" id="booknumHid" value="${booklist.booknum}">
	<input type="hidden" id="tab" value="${tab}">
	<input type ="hidden" id = "comCount" value="${comCount}">
	<input type = "hidden" id = "buyRecord" value = "${buyRecord}">
	<input type = "hidden" id = "receivePoint" value = "${receivePoint}">
	<div class="clear"></div>
	<jsp:include page="footer.jsp" flush="true" />
</body>
<script type="text/javascript">
function price(tmp, bp) {
    $("#cnt").val(tmp);
    $("#ordercnt").text(tmp);
    var disprice = bp;
    var sumprice = bp * tmp;
    $("#orderPriceNum").text(AddComma(sumprice));
 }
 function gradestar(n) {
    $(".star").css("color", "rgb(200, 200, 200)");
    for (i = 1; i <= n; i++) {
       $("#star" + i).css("color", "rgb(102, 153, 204)");
    }
    var a = n * 2;
    $("#gradehid").text(a);
}

$(function() {
	var starnum=0;
	var booknum = $("#booknumHid").val();
	var tab = $("#tab").val();
	var blueStar = "";
	var grayStar = "";
	var now = new Date();
	var year = now.getFullYear(); 
	var month = now.getMonth()+1;
	var today = now.getDate();
	
	if(month<10) "0"+month;
	if(today<10) "0"+today;
	
	var todayDateText = year + "-" + month + "-" + today;
	
	$("#gradeNum").text(${booklist.grade});
	
	$(document).attr("title",$("#title").text() + " - HUMAN24"); 
    $("#bs").text(showStarDetail(${booklist.grade}));
	
    
	if($("#gradeNum").text() == '0.5' || $("#gradeNum").text() == '1.5' || $("#gradeNum").text() == '2.5' || $("#gradeNum").text() == '3.5' || $("#gradeNum").text() == '4.5'){
		var tmp = Math.floor(${5-booklist.grade})
		console.log("if")
		$("#gs").text(showStarDetail(tmp));
	}else{
		console.log("else");
	 	$("#gs").text(showStarDetail(${5-booklist.grade}));	 	
	}
	
	if(isNaN($("#gradeNum").text())){
		$("#gradeNum").text(0);
		$("#gs").text("★★★★★");
	}
	var dis_per = ${booklist.dis_per};
	var bookPrice = ${booklist.price*booklist.dis_per};
	$("#bookPrice").text(AddComma(bookPrice));
	
    $("#ordercnt").text(1);
    $("#orderPriceNum").text(AddComma(bookPrice));
    $("#realPrice").text(AddComma(${booklist.price}));
    
    $(".tab_btn li").bind("click",function(){
        var list = $(this).index();
        $(".tab_btn li").removeClass("on");
        $(this).addClass("on");

        $(".tab_cont > li").hide();
        $(".tab_cont > li").eq(list).show();
     });
   
   if(tab == "comment"){
	   $("#commentlist").trigger("click");
	   tab="";
   }
	$("#minus").click(function() {
		 var tmp = $("#cnt").val();
         tmp--;
         if (tmp < 1) {
            alert("수량이 1보다 작을 수 없습니다.");
            $("#cnt").val(1);
            return false;
         } else {
            price(tmp, bookPrice);
         }
      })
      $("#plus").click(function() {
         var tmp = $("#cnt").val();
         tmp++;
         price(tmp, bookPrice);
      })
      $("#cnt").keyup(function(key) {
    	  var reg = /[^0-9]/gi;
          var v = $(this).val();
          if (reg.test(v)) {
              $(this).val(v.replace(reg, ''));
              $(this).focus();
              return false;
          }else if(v == '0'){
        	  alert("수량이 1보다 작을 수 없습니다.");
        	  $(this).val(v.replace(0, '1'));
        	  return false;
          }else{
	    	  price(v, bookPrice);    	  
          }
      })
      $("#star1").click(function() {
          starnum=1;
          blueStar = "★";
          grayStar = "★★★★";
          gradestar(1);
       })
       $("#star2").click(function() {
    	   
          starnum=2;
          blueStar = "★★";
          grayStar = "★★★";
          gradestar(2);
       })
       $("#star3").click(function() {
          starnum=3;
          blueStar = "★★★";
          grayStar = "★★";
          gradestar(3);
       })
       $("#star4").click(function() {
          starnum=4;
          blueStar = "★★★★";
          grayStar = "★";
          gradestar(4);
       })
       $("#star5").click(function() {
          starnum=5;
          blueStar = "★★★★★";
          grayStar = "";
          gradestar(5);
       })
       
       $('#commenttext').keyup(function (e){
		    var content = $(this).val();
		    $('#counter').html("("+content.length+" / 최대 200자)");    //글자수 실시간 카운팅
		
		    if (content.length > 200){
		        alert("최대 200자까지 입력 가능합니다.");
		        $(this).val(content.substring(0, 200));
		        $('#counter').html("(200 / 최대 200자)");
		    }
		});
      $("#buybtn").click(function(){
    	  if(!loginYN()){
    		  goLogin();
    		  return false;
    	  }else{
	          var bookCount = $("#cnt").val();
	          window.location.href = "/main/order_delivery?d_booknum="+booknum+"&d_count="+bookCount+"&cartOrDetail=detail";
    	  }
      })
      $("#cartbtn").click(function(){
    	  if(!loginYN()){
    		  goLogin();
    		  return false;
    	  }else{
	    	  var cartCnt = $("#cnt").val();
				$.ajax
				({
				   url : "/main/insertCart?cart_booknum="+booknum+"&cart_count="+cartCnt+"&userid="+userid,
				   type : 'get',
				   success : function(data) 
				   {
					   var flag = confirm("장바구니에 저장되었습니다. \n장바구니로 이동하시겠습니까?");
				       if(flag) window.location.href = '/main/cart';
				   }, 
				   error : function() 
				   {
				      alert("실패");
				    }
				})
    	  }
      })
      $(document)
      .on("click", "#commentlist", function() {
         $('#footerwrap').addClass('noshow');	
      })
      .on("click", "#detaillist,#delilist", function() {
         $('#footerwrap').removeClass('noshow');
      })
      .on("click", "#submitbtn", function() {
    	  var buyRecord = $("#buyRecord").val();
    	  if(!loginYN()){
    		  goLogin();
    		  return false;
    	  }else if($("#comCount").val() != 0){
    		  alert("이미 댓글을 작성하셨습니다.");
    		  return false;
    	  }else if(starnum == 0){
	   		   alert("별점을 클릭해주세요!");
	   		   return false;
	   	  }else if(($('#commenttext').val()).length<5){
	   		  alert("5자 이상 입력해주세요.")
	   		  return false;
	   	  }else{
	   		    var text = $("#commenttext").val();
		        $("#commenttext").val('');
		        var receivePoint = $("#receivePoint").val();
				$.ajax
				({
				   url : '${pageContext.request.contextPath}/detail/comment?booknum='+booknum +'&userid='+userid+'&contents='+ text + '&grade=' + starnum + '&receivePoint='+receivePoint+'&buyRecord='+$("#buyRecord").val(),
				   type : 'get',
				   success : function(data) 
				   {
					   
					   $('#comTbody').append(
				       '<tr>'
						   +"<td id='com_userid'><span style = 'color: tomato; font-weight: bold;'>"+userid+"</span></td>"
						   +'<td class="comgrade">'
							   +'<span class="blueStar gradeStar" id="gradeStar">'+blueStar+'</span>'
							   +'<span class="grayStar gradeStar" id="gradeStar">'+grayStar+'</span>'
						   +'</td>'
						   +'<td align=center>'+text+'</td>'
						   +'<td style="color: #666; font-size: 12px;">'+todayDateText+'</td>'
						   +"<td><input type = 'button' value = 'X' id='comDel'><input type = 'hidden' value="+data+" id='hidComNum'></td>"
					   +'</tr>'
				  	   );
					   
					   if(buyRecord == 0){ alert("댓글이 달렸습니다."); // 구매한 책이 아님
					   }else{ // 구매한 책임
						   if(receivePoint == 0) alert("댓글이 달렸습니다.\n50 포인트가 적립되었습니다."); // 구매한 책이고 댓글 포인트를 받은 기록이 없음   
						   else alert("댓글이 달렸습니다.\n 해당 책으로 이미 댓글 포인트를 받았습니다.\n(포인트 지급이 되지 않았습니다.)"); // 이미 받은 포인트
					   }
				   }, 
				   error : function() 
				   {
				      alert("실패");
				    }
				})
	   	    }
      })
      .on("click","#comDel",function(){
    	  var delyn = confirm("댓글을 삭제하시겠습니까?");
		  if(delyn){
	    	  var comnum = $("#hidComNum").val();
	    	  $.ajax
				({
				   url : "${pageContext.request.contextPath}/commentDel?comnum="+comnum,
				   type : 'get',
				   success : function(data) 
				   {
				  	 alert("댓글이 삭제되었습니다.")
				       location.href="${pageContext.request.contextPath}/detail?tab=comment&booknum="+booknum;
				   }, 
				   error : function() 
				   {
				      alert("실패");
				    }
				})
		  }
      })
   })
  
   
</script>
</html>