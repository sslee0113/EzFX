<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/head/head.jsp"%>
</head>
<body>
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
					<%@ include file="/WEB-INF/jsp/left/left-webeventinfo.jsp"%>
				</div>

				<div class="right_content">
					<!-- start of right content-->

					<h2>Event</h2>
					<table id="list">
					</table>
					<div id="pager"></div>
					<%@ include file="/WEB-INF/jsp/menu/gridmenuonlyview.jsp"%>




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

	<script type="text/javascript">
	var createDialog = {}
	
	var updateDialog = {}
		
	var deleteDialog = {}

	var viewDialog = {caption:'Event 상세보기'}
	</script>

	<script type="text/javascript">
		$(document).ready(
				function() {
					jQuery("#list").jqGrid(
							{
								url : '${pageContext.request.contextPath}/rest/event',
								datatype : 'json',
								mtype : 'GET',								
								colNames : [ 'seq', '접속자', '접속 IP', '요청 화면',
										'요청 이벤트', '요청 시간' ],
								colModel : [ {
									name : 'seq',
									index : 'seq',
									sorttype : 'number',
									width : 50
								}, {
									name : 'username',
									index : 'username',
									width : 50
								}, {
									name : 'useraddr',
									index : 'useraddr',
									width : 50
								}, {
									name : 'requesturi',
									index : 'requesturi',
									width : 100
								}, {
									name : 'requestmethod',
									index : 'requestmethod',
									width : 100
								}, {
									name : 'requestdate',
									index : 'requestdate',
									width : 100,
									searchoptions : {
										searchOperators : true,
										dataInit : function(element) {
											$(element).datepicker({
												id : 'orderDate_datePicker',
												dateFormat : 'yy-mm-dd',
												prevText : '이전 달',
												nextText : '다음 달',
												monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
												monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
												dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
												dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
												dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
												maxDate : new Date(2020, 0, 1),
												OnSelect : function() {
												},
												showOn : 'focus'
											});
										},
										sopt : [ "eq", "ge", "le" ]
									}
								} ],
								pager : '#pager',
								rowNum : 100,
								rowList : [ 100, 200, 300 ],
								sortname : 'seq',
								sortorder : 'desc',
								viewrecords : true,
								gridview : true,
								caption : 'Event',
								loadonce : true,
								autowidth : true,
								shrinkToFit : true,
								editurl : 'clientArray',
								cellsubmit : 'clientArray',
								height : 400,
								colMenu : true,
				                gridComplete: initGrid,
				                loadError: errorOnLoad						
							});
					
					jQuery("#list").jqGrid('navGrid', '#pager', {
						add : false,
						edit : false,
						del : false,
						search : true,
						view : true
					},updateDialog
					 ,createDialog
					 ,deleteDialog
					 ,{}
					 ,viewDialog
					 );
					
					addExcelDownload();

					addFileterToolbar();
					fixSearchOperators();					

				});	
			

		
	</script>
</body>
</html>
