<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="${pageContext.request.contextPath}/js/jquery/context-menu.js"></script>

<!-- Basic style components -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/jui/jui/dist/ui.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/jui/jui/dist/ui-jennifer.min.css" />

<!-- Grid style components -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/jui/jui-grid/dist/grid.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/jui/jui-grid/dist/grid-jennifer.min.css" />

<%@ include file="/WEB-INF/jsp/head/head.jsp"%>
<%
SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
Calendar calendar = Calendar.getInstance(java.util.Locale.KOREA);
String nowDate = format.format(calendar.getTime());
calendar.add(Calendar.MINUTE, -5);
String beforeDate = format.format(calendar.getTime());
%>

</head>
<body class="jui">
	<script src="${pageContext.request.contextPath}/js/jui/jui/dist/ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/jui/jui-core/dist/core.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/jui/jui-chart/dist/chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/jui/jui-grid/dist/grid.min.js"></script>
	<div id="main_container">

		<!-- start of body-->

		<div class="header">
			<%@ include file="/WEB-INF/jsp/header/header.jsp"%>
		</div>

		<div class="main_content">

			<div class="menu">
				<%@ include file="/WEB-INF/jsp/menu/menu.jsp"%>
			</div>

			<div class="center_content">

				<div class="left_content">
					<%@ include file="/WEB-INF/jsp/left/left-dashboard.jsp"%>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</div>

				<div class="right_content">
					<!-- start of right content-->
					<h2>DASH BOARD</h2>
					
					<div id="chart1" style="float: left; width:400px; height:370px; border:1px solid #ccc!important; border-radius: 10px; padding: 10px; margin: 10px;"></div>
					<div id="chart2" style="float: left; width:400px; height:370px; border:1px solid #ccc!important; border-radius: 10px; padding: 10px; margin: 10px;"></div>
					<div id="chart3" style="float: left; width:400px; height:300px; border:1px solid #ccc!important; border-radius: 10px; padding: 10px; margin: 10px;"></div>
					<div id="chart4" style="float: left; width:400px; height:300px; border:1px solid #ccc!important; border-radius: 10px; padding: 10px; margin: 10px;"></div>

					<!-- end of right content-->
				</div>

			</div>

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<div class="footer">
			<%@ include file="/WEB-INF/jsp/footer/footer.jsp"%>
		</div>

		<!-- end of body-->
	</div>
	
	<script>
	
		// FILE QUEUE 
		var queueName1="KTNET";
		var queueName2="KFTC";
		
		// async false 로 하면  $.getJSON 후 실행이 종료될 때까지 기다리므로 comsetidList 값이 모두 생성된 후에 다음 스크립트가 실행된다.
		$.ajaxSetup({ async: false });

		// FILE QUEUE 데이터 가져오기
		function getQueueData(targetName){
			var queuedata;
			$.getJSON( "${pageContext.request.contextPath}/rest/filequeue/"+targetName )
			.done(function( data ) {
				console.log( "JSON Data: " + JSON.stringify(data) );
				queuedata = data;
			})
			.fail(function( jqxhr, textStatus, error ) {
				var err = textStatus + ", " + error;
				console.log( "Request Failed: " + err );
			});
			return queuedata;
		}
		
		// AUDIT 상태가져오기
		// 오늘 날짜 얻기
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();
		if(dd<10) {
			dd = '0'+dd
		} 
		if(mm<10) {
			mm = '0'+mm
		} 

		var rdate = yyyy+mm+dd;
		console.log("rdate:"+rdate);
		function getAuditStat(){
			// IAUDIT 통계값 가져오기
			$.getJSON( "${pageContext.request.contextPath}/rest/istatistics/"+rdate )
				.done(function( data ) {
					console.log( "JSON Data: " + data.itotal );
					
					tt1=parseInt(data.itotal);
					ts1=parseInt(data.isend);
					te1=parseInt(data.ierror);
					tw1=parseInt(data.iwait);
					
					console.log("it:"+tt1);
					console.log("is:"+ts1);
					console.log("ie:"+te1);
					console.log("iw:"+tw1);

				})
				.fail(function( jqxhr, textStatus, error ) {
					var err = textStatus + ", " + error;
					console.log( "Request Failed: " + err );
				});
			
			// OAUDIT 통계값 가져오기
			$.getJSON( "${pageContext.request.contextPath}/rest/ostatistics/"+rdate )
				.done(function( data ) {
					console.log( "JSON Data: " + data.ototal );

					tt2=parseInt(data.ototal);
					ts2=parseInt(data.osend);
					te2=parseInt(data.oerror);
					tw2=parseInt(data.owait);

					console.log("it:"+tt2);
					console.log("is:"+ts2);
					console.log("ie:"+te2);
					console.log("iw:"+tw2);

				})
				.fail(function( jqxhr, textStatus, error ) {
					var err = textStatus + ", " + error;
					console.log( "Request Failed: " + err );

				});
		
			auditChartData = [{
				  quarter:'iAudit',
				  TOTAL:tt1,
				  C:ts1,
				  W:tw1,
				  S:te1
				  },{
				  quarter:'oAudit',
				  TOTAL:tt2,
				  C:ts2,
				  W:tw2,
				  S:te2
			}];
			
			return auditChartData;
		}
		
		var chart1 = jui.include("chart.builder");
		var chart2 = jui.include("chart.builder");
		var chart3 = jui.include("chart.builder");
		
		var showEventMessage = function(obj) {
		    alert("[" + obj.dataIndex + "] 갯수 : " + obj.data[obj.dataKey]);
		}
		
		// KTNET 차트
		var c1 = chart1("#chart1", {
			padding : {
			        //top : 100,
			        left : 70
			        //right : 50,
			        //bottom : 50
			    },
		    axis : [{
		        y : {
		            type : "block",
		            domain : "dir",
		            line : true
		        },
		        x : {
		            type : "range",
		            domain : [ 0, 50 ],
		            step : 10,
		            line : true
		        },
		        data : getQueueData(queueName1)
		    }],
		    brush : [{
//		        type : "column",
		        type : "bar",
		        target : [ "count" ],
				// Color index of theme or RGB color code
		        colors : function(data) {
		            if(data.count > 20) {
		                return "#9228E4";
		            }
		            return 2;
		        }
		    }],
		    event : {
		        click : function(obj, e) {
		            showEventMessage(obj);
		        }
		    },
		    widget : [{
		        type : "title",
		        text : queueName1+" Queue Status",
		        orient : "top",
		        align : "start"
		    }]
		});
		
		// KFTC 차트
		var c2 = chart2("#chart2", {
			padding : {
		        //top : 100,
		        left : 70
		        //right : 50,
		        //bottom : 50
		    },
	    	axis : [{
		        y : {
		            type : "block",
		            domain : "dir",
		            line : true
		        },
		        x : {
		            type : "range",
		            domain : [ 0, 50 ],
		            step : 10,
		            line : true
		        },
		        data : getQueueData(queueName2)
		    }],
		    brush : [{
//		        type : "column",
		        type : "bar",
		        target : [ "count" ],
				// Color index of theme or RGB color code
		        colors : function(data) {
		            if(data.count > 20) {
		                return "#9228E4";
		            }
		            return 2;
		        }
		    }],
		    event : {
		        click : function(obj, e) {
		            showEventMessage(obj);
		        }
		    },
		    widget : [{
		        type : "title",
		        text : queueName2+" Queue Status",
		        orient : "top",
		        align : "start"
		    }]
		});
		
		// AUDIT 차트
		var c3 = chart3("#chart3", {
			axis : {
				data : getAuditStat(),
				y : {
					domain : "quarter",
					line : true
				},
				x : {
					orient : 'top',
					type : "range",
					step : tt1,
					line : true,
					format : function(d) {
						return d;
					},
					domain : function(d) { return [tt1, 0]; }
				}
			},
			brush : {
				type : "bar",
				target : [ "TOTAL", "C", "W", "S" ],
				innerPadding : -2,
				outerPadding : 2
			},
			widget : [
				{ type : "title", text : "AUDIT Status", orient: "top", align: "start" },
				{ type : "tooltip", orient: "right" },
				{ type : "legend", align: "end" }
			]
		});

		// 5초마다 CHART 를 새로 그림
		refreshChart1 = setInterval(function() {
			// Data updated after rendering
			c1.axis(0).update(getQueueData(queueName1));
			c2.axis(0).update(getQueueData(queueName2));
			c3.axis(0).update(getAuditStat());
		}, 5000);
		
		// Events defined by the method
		/*
		c.on("rclick", function(obj, e) {
		    showEventMessage(obj);
		});
		*/

	</script>
	
</body>
</html>
