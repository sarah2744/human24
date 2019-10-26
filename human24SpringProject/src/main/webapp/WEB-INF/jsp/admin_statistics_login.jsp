<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_statistics_user.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_statistics_login.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<style>
	.graphOn{
	    background-color: rgb(154, 2, 0) !important;
		color: white !important;    
	}
	
</style>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
<jsp:include page="admin_header.jsp" flush="true" />
	<div id="wrap">
        <div id="wrapping">
            <div id="subMenu">
                <ul>
                    <li onclick="window.location.href='/main/admin/statistics/user?stat=age'">회원 통계</li>
                    <li onclick="window.location.href='/main/admin/statistics/sell?stat=mainGenre'">판매 통계</li>
                    <li class="subOn" id="statLogin">로그인 통계</li>
                </ul>
            </div>
            <section>
                <div id="section">
                    <div id="shadowDiv" style="margin-bottom: 250px;">
                        <div id="titleDiv">
                            <h1>관리자 > 통계보기 > 로그인 통계</h1>
                        </div>
                        <div id="dateOne" class="searchDiv">
                        	<span class="schDivSpan">날짜 &nbsp;&nbsp;:&nbsp;&nbsp; </span>
                        	<select id="yearSelect" class="searchField">
                        	</select>
                        	<span class="schDivSpan"> 년&nbsp;&nbsp;&nbsp;  </span>
                        	<select id="monthSelect" class="searchField">
                        	</select>
                        	<span class="schDivSpan"> 월&nbsp;&nbsp;&nbsp;  </span>
	                    </div>
                        <div id="dateTwo" class="searchDiv">
                        	<span class="schDivSpan">기간 &nbsp;&nbsp;:&nbsp;&nbsp; </span>
                        	<input placeholder="formDate" class="textbox-n searchField" type="text" onfocus="(this.type='date')"  required="required" id="fromDate">
                        	<span class="schDivSpan" style="padding-right: 15px;"> &nbsp;&nbsp;~&nbsp;&nbsp; </span>
                        	<input placeholder="toDate" class="textbox-n searchField" type="text" onfocus="(this.type='date')"  required="required" id="toDate">
	                    </div> 
                        <div id="btnTd" style="text-align: right;">
                        	<input type = "button" id="ampm" class="btn statBtn dateTwo" value="오전/오후">
                        	<input type = "button" id="time" class="btn statBtn dateTwo" value="시간별">
                        	<input type = "button" id="date" class="btn statBtn dateOne" value="날짜별">
                        	<input type = "button" id="day" class="btn statBtn dateTwo" value="요일별">
                        	<input type = "button" id="month" class="btn statBtn dateTwo" value="월별">
                        	<input type = "button" id="year" class="btn statBtn dateTwo" value="연도별">
                        </div>
                        <div id="schDate">
                        	<h1>기간 : ${selDate}</h1>
                        </div>
                        <div id="container"></div>
                        <div id="tmp1" class="btnDiv" style="display: inline-block;">
							<button id="plain" class="btn graphBtn graphOn">Plain</button>
							<button id="inverted" class="btn graphBtn">Inverted</button>
							<button id="polar" class="btn graphBtn">Polar</button>
						</div>
                    </div>
                </div>
            </section>
        </div>
        <div class="clear"></div>
    </div>
</body>
<script>

$(function(){
	
	var nowYear = new Date().getFullYear();
	var nowMon = new Date().getMonth()+1;
	var todayDate = new Date().getFullYear()+"/"+(new Date().getMonth()+1)+"/"+new Date().getDate();
	
	var choice = "${choice}";
	
	$("#statLogin").click(function(){
		location.href='/main/admin/statistics/login?stat=ampm&fromDate='+todayDate+'&toDate='+todayDate;
	})
	
	$(".textbox-n").val(new Date().toISOString().substring(0, 10));
	
	$(".statBtn[id="+choice+"]").css({"background-color":"rgb(154, 2, 0)","color":"white"});
	
	$(".graphBtn").click(function(){
		$(".graphBtn").removeClass("graphOn");
		$(this).addClass("graphOn");		
	})
		
	
	for(var i = nowYear; i >= 2000 ; i--){
		$("#yearSelect").append("<option value="+i+">"+i+"</option>")
	}
	
	for(var i = 1; i <= 12; i++){
		if(i == nowMon) {
			$("#monthSelect").append("<option value="+i+" selected>"+i+"</option>");
			continue;
		}
		$("#monthSelect").append("<option value="+i+">"+i+"</option>")	
	}
	
	if(choice == "date"){
		$("#dateTwo").css("display","none");
		$("#dateOne").css("display","block");
	}
	
	$(".dateOne").click(function(){
		var statYear = $("#yearSelect option:selected").val();
		var statMon = $("#monthSelect option:selected").val();
		var statVal = $(this).attr("id");
		
		if(statYear == undefined){
			statYear = nowYear;
			statMon = nowMon
		}
		
		location.href='/main/admin/statistics/login?stat='+statVal+'&statYear='+statYear+'&statMon='+statMon;
	})
	$(".dateTwo").click(function(){
		var fromDate = ($("#fromDate").val()).replace(/-/gi,'/');
		var toDate = ($("#toDate").val()).replace(/-/gi,'/');
		var statVal = $(this).attr("id");
		console.log(fromDate+"/"+toDate)
		location.href='/main/admin/statistics/login?stat='+statVal+'&fromDate='+fromDate+'&toDate='+toDate;
	})
	
	
	var property = [];
	var values = [];
	
	if(choice != "ampm" && choice != "day"){
		<c:forEach items="${statArr}" var="arr">
			property.push("${arr.statProperty}");
			values.push(${arr.statValue});
		</c:forEach>
	}else if(choice == "ampm"){
		property = ["오전", "오후"]
		values = [${amList}, ${pmList}];			
	}else if(choice == "day"){
		property = ["일", "월", "화", "수", "목", "금", "토"]
		<c:forEach items="${statArr}" var="arr">
			values.push(${arr.statValue});
		</c:forEach>
	}
	console.log(property);
	console.log(values);
	var chart = Highcharts.chart('container', {
	    title: {
	        text: '로그인 통계'
	    },
	    xAxis: {
	        categories:property
	    },
	    yAxis: {
	        title: {
	            text: '회원 수'
	        }
	    },
	    series: [{
	    	name: '회원 수',
	        type: 'column',
	        colorByPoint: true,
	        data: values,
	        showInLegend: false
	    }]
	});
	
	$('#plain').click(function () {
	    chart.update({
	        chart: {
	            inverted: false,
	            polar: false
	        },
	        subtitle: {
	            text: '로그인 통계'
	        }
	    });
	});
	
	$('#inverted').click(function () {
	    chart.update({
	        chart: {
	            inverted: true,
	            polar: false
	        },
	        subtitle: {
	            text: '로그인 통계'
	        }
	    });
	});
	
	$('#polar').click(function () {
	    chart.update({
	        chart: {
	            inverted: false,
	            polar: true
	        },
	        subtitle: {
	            text: '로그인 통계'
	        }
	    });
	});
});
</script>