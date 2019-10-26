<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_statistics_user.css">
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
                    <li class="subOn" onclick="window.location.href='/main/admin/statistics/sell?stat=mainGenre'">판매 통계</li>
                    <li id="statLogin">로그인 통계</li>
                </ul>
            </div>
            <section>
                <div id="section">
                    <div id="shadowDiv" style="margin-bottom: 250px;">
                        <div id="titleDiv">
                            <h1>관리자 > 통계보기 > 판매 통계</h1>
                        </div>
                        <div id="btnTd" style="text-align: right;">
                        	<a href = '/main/admin/statistics/sell?stat=mainGenre'><input type = "button" id="mainGenre" class="btn statBtn" value="대장르 통계"></a>
                        	<a href = '/main/admin/statistics/sell?stat=subGenre'><input type = "button" id="subGenre" class="btn statBtn" value="소장르 통계"></a>
                        	<a href = '/main/admin/statistics/sell?stat=mainGenreGender'><input type = "button" id="mainGenreGender" class="btn statBtn" value="대장르 + 성별"></a>
                        	<a href = '/main/admin/statistics/sell?stat=subGenreGender'><input type = "button" id="subGenreGender" class="btn statBtn" value="소장르 + 성별"></a>
                        </div>
                        <div id="container"></div>
                        <div id="tmp1" class="btnDiv">
							<button id="plain" class="btn graphBtn graphOn">Plain</button>
							<button id="inverted" class="btn graphBtn">Inverted</button>
							<button id="polar" class="btn graphBtn">Polar</button>
						</div>
						<div id="tmp2" class="btnDiv">
						    <button id="small" class="btn graphBtn graphOn">Small</button>
						    <button id="large" class="btn graphBtn">Large</button>
						    <button id="auto" class="btn graphBtn">Auto</button>
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
	
	var todayDate = new Date().getFullYear()+"/"+(new Date().getMonth()+1)+"/"+new Date().getDate();
	var choice = "${choice}";
	
	if(new Date().getDate() < 10){
		todayDate = new Date().getFullYear()+"/"+(new Date().getMonth()+1)+"/0"+new Date().getDate();
	}
	
	$("#statLogin").click(function(){
		location.href='/main/admin/statistics/login?stat=ampm&fromDate='+todayDate+'&toDate='+todayDate;
	})
	
	$(".statBtn[id="+choice+"]").css({"background-color":"rgb(154, 2, 0)","color":"white"});
	
	$(".graphBtn").click(function(){
		$(".graphBtn").removeClass("graphOn");
		$(this).addClass("graphOn");		
	})
	
	if(choice == "mainGenre" || choice == "subGenre"){
		var property = [];
		var values = [];
		
		$("#tmp1").css("display","block");
		
		if(choice == "mainGenre"){
			
			<c:forEach items="${mainGenreStat}" var="arr">
			
				property.push("${arr.statProperty}");
				values.push(${arr.statValue});
				
			</c:forEach>
			
		}else if(choice == "subGenre"){
			
			<c:forEach items="${subGenreStat}" var="arr">
				property.push("${arr.statProperty}");
				values.push(${arr.statValue});
				
			</c:forEach>
			
		}
		
		if(choice == "age"){
			cate = age;
			con = ageCnt
		}else if(choice == "gender"){
			cate = ['남자', '여자'];
			con= [${maleCnt},${femaleCnt}];
		}
		
		var chart = Highcharts.chart('container', {
		    title: {
		        text: '판매량 통계'
		    },
		    subtitle: {
		        text: '장르별 통계'
		    },
		    xAxis: {
		        categories:property
		    },
		    yAxis: {
		        title: {
		            text: '판매량'
		        }
		    },
		    series: [{
		    	name: '판매량',
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
		            text: '판매량 통계'
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
		            text: '판매량 통계'
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
		            text: '판매량 통계'
		        }
		    });
		});
	}else if(choice == "mainGenreGender" || choice == "subGenreGender"){
		
		$("#tmp2").css("display","block");
	
		var property = [];
		var maleVal = [];
		var femaleVal = [];
		
		
		if(choice == "mainGenreGender"){
			<c:forEach items="${mainGenreMale}" var="arr">
				property.push("${arr.statProperty}");
				maleVal.push(${arr.statValue});
			</c:forEach>
			<c:forEach items="${mainGenreFemale}" var="arr">
				femaleVal.push(${arr.statValue});
			</c:forEach>
		}else if(choice == "subGenreGender"){
			<c:forEach items="${subGenreMale}" var="arr">
				property.push("${arr.statProperty}");
				maleVal.push(${arr.statValue});
			</c:forEach>
			<c:forEach items="${subGenreFemale}" var="arr">
				femaleVal.push(${arr.statValue});
			</c:forEach>
		}
		var chart = Highcharts.chart('container', {

		    chart: {
		        type: 'column'
		    },

		    title: {
		        text: '판매량 통계'
		    },

		    subtitle: {
		        text: '장르 + 성별 통계'
		    },

		    legend: {
		        align: 'right',
		        verticalAlign: 'middle',
		        layout: 'vertical'
		    },

		    xAxis: {
		        categories: property,
		        labels: {
		            x: -10
		        }
		    },
		    yAxis: {
		        allowDecimals: false,
		        title: {
		            text: '판매량'
		        }
		    },
		    series: [{
		        name: '남자',
		        data: maleVal
		    }, {
		        name: '여자',
		        data: femaleVal
		    }],
		    responsive: {
		        rules: [{
		            condition: {
		                maxWidth: 500
		            },
		            chartOptions: {
		                legend: {
		                    align: 'center',
		                    verticalAlign: 'bottom',
		                    layout: 'horizontal'
		                },
		                yAxis: {
		                    labels: {
		                        align: 'left',
		                        x: 0,
		                        y: -5
		                    },
		                    title: {
		                        text: "판매량"
		                    }
		                },
		                subtitle: {
		                    text: null
		                },
		                credits: {
		                    enabled: false
		                }
		            }
		        }]
		    }
		});

		document.getElementById('small').addEventListener('click', function () {
		    chart.setSize(400);
		});

		document.getElementById('large').addEventListener('click', function () {
		    chart.setSize(800);
		});

		document.getElementById('auto').addEventListener('click', function () {
		    chart.setSize(null);
		});
	}
});
</script>