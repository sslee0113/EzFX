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

		<div id="dummy_white_div" class="main_content" style="display:block;border-radius: 10px;">
			<div id="main_content_div" style="display:none">
				<div class="header">
					<%@ include file="/WEB-INF/jsp/header/header.jsp"%>
				</div>
				<div class="center_content"> 
					<div id="main_easyui_layout" class="easyui-layout" style="width:100%;height:800px">
						<!--
						<div data-options="region:'north'" style="height:50px"></div>
						<div data-options="region:'south',split:true" style="height:50px;"></div>
						<div data-options="region:'east',split:true" title="East" style="width:100px;"></div>
						-->
					
						<!-- LEFT MENU -->
						<div id="menu_div" data-options="region:'west',split:true" title="메뉴" style="width:200px;">
							<%@ include file="/WEB-INF/jsp/menu/roleMenu.jsp"%>
						</div>
						<!-- RIGHT CONTENT -->
						<div id="contents_div" data-options="region:'center',footer:'#footer'" style="padding:3px 3px 3px 3px">
						<h2 align="center" style="margin-bottom:5px; padding:0px 0px 0px 0px"><%=selectedMenuName %></h2>
							<div id="searchCondition_div" class="easyui-panel" title="검색조건" style="width:100%;height:73px;padding:7px;">
								<div align="left" style="width:70%;float:left">
									<input id="searchStartDate" name="searchStartDate" class="easyui-datebox" label="거래일자" labelWidth="60px" labelAlign="right" style="width:160px" data-options="required:false,formatter:myformatter,parser:myparser" />
									~
									<input id="searchEndDate" name="searchEndDate" class="easyui-datebox" style="width:100px" data-options="required:false,formatter:myformatter,parser:myparser" />
									<input id="searchRefNo" name="searchRefNo" class="easyui-textbox" label="참조번호" labelWidth="60px" labelAlign="right" style="width:180px" data-options="required:false" tabindex="2"/>
								</div>
								<div align="right" style="width:30%;float:right">
									<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()">조회</a>
								</div>
							</div>	

							<div class="easyui-layout" data-options="fit:true" >

								<!-- GRID -->
								<div data-options="region:'center'" style="width:100%;padding:0px">
							
									<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">
						
										<div id="grid_div" title="검색결과" style="width:'auto';height:'auto';" data-options="selected:false">
											<table id="dg" class="easyui-datagrid" style="width:100%; height:500px;"
															method="get" toolbar="#tb" pagination="false"
															view="scrollview"
															rownumbers="true" fitColumns="true" singleSelect="true">
												<thead>
													<tr>
														<th field="actgTrDt" width="10%" sortable="false" data-options="align:'center',formatter:formatDate"><center>회계일자</center></th>
														<th field="actgTrSrno" width="7%" sortable="false" data-options="align:'center'"><center>일련번호</center></th>
														<th field="bzTcd" width="12%" sortable="false" data-options="align:'center'"><center>업무구분</center></th>
														<th field="refNo" width="15%" sortable="false" data-options="align:'center'"><center>참조번호</center></th>
														<th field="prcTcd" width="8%" sortable="false" data-options="align:'center'"><center>처리구분</center></th>
														<th field="orgActgTrDt" width="10%" sortable="false" data-options="align:'center',formatter:formatDate"><center>원회계일자</center></th>
														<th field="orgActgTrSrno" width="10%" sortable="false" data-options="align:'center'"><center>원일련번호</center></th>
														<th field="statTcd" width="9%" sortable="false" data-options="align:'center',formatter:formatStatTcd"><center>상태구분</center></th>
														<th field="regiDt" width="10%" sortable="false" data-options="align:'center',formatter:formatDate"><center>등록일자</center></th>
														<th field="regiTm" width="10%" sortable="false" data-options="align:'center',formatter:formatTime"><center>등록시간</center></th>
													</tr>
												</thead>
											</table>
										</div>
										<div id="input_div" title="상세내용" style="width:'auto';height:'200px';overflow:scroll;" data-options="selected:false">
											<table id="subdg" class="easyui-datagrid" style="width:100%;"
															method="get" pagination="false"
															rownumbers="true" fitColumns="true" singleSelect="true">
												<thead>
													<tr>
														<th rowspan="2" field="oppBrno" width="12%" sortable="false" data-options="align:'center'"><center>관리점번호</center></th>
														<!-- 
														<th rowspan="2" field="bankCd" width="7%" sortable="false" data-options="align:'center'"><center>은행코드</center></th>
														<th rowspan="2" field="basicRate" width="5%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>매매기준율</center></th>
														<th rowspan="2" field="exrRate" width="5%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>적용환율</center></th>
														-->
														<th colspan="4">차변</th>
													 	<th colspan="4">대변</th>
													</tr>
													<tr>
														<th field="dacctCd" width="11%" sortable="false" data-options="align:'left'"><center>계정</center></th>
														<th field="dcurrCd" width="11%" sortable="false" data-options="align:'center'"><center>통화</center></th>
														<th field="dfrc" width="11%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>외화</center></th>
														<th field="dwon" width="11%" sortable="false" data-options="align:'right',formatter:formatInteger"><center>원화</center></th>

														<th field="cacctCd" width="11%" sortable="false" data-options="align:'left'"><center>계정</center></th>
														<th field="ccurrCd" width="11%" sortable="false" data-options="align:'center'"><center>통화</center></th>
														<th field="cfrc" width="11%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>외화</center></th>
														<th field="cwon" width="11%" sortable="false" data-options="align:'right',formatter:formatInteger"><center>원화</center></th>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								</div>
							</div> <!-- end of grid_accordion -->

							<div id="footer" align="right" style="padding:5px;">
								<%@ include file="/WEB-INF/jsp/footer/footer_btn.jsp"%>
							</div>
						</div> <!-- END OF RIGHT CONTENT -->
					</div>	<!--  main_easyui_layout  -->
				</div>	<!-- center_content -->
			</div> <!-- main_content_div -->

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<!-- end of body-->
	</div>
	
	<!-- SCRIPT -->
	<script type="text/javascript">
		var url;
		var rawData;
		var restfulType,targetUrl,param;
		var defaultTargetUrl="${pageContext.request.contextPath}/rest/exchange";
		var defaultRestfulType="POST";
				
		function formClear(){
			
		}
				
		function setMaxLength(){
					
			// MAXLENGTH
			$("#searchRefNo").textbox('textbox').attr('maxlength', 15);

		}
				
		function setTextBoxCss(){

			// TEXTBOX 입력시 무조건 대문자화
		}
				
		function setTextBoxDisable(textBoxName){

		}
		
		function setTextBoxEnable(){

		}
				
		function getRawData(){
			
		}
				
		function searchData(){
					
			var searchStartDate = $('#searchStartDate').val().replace(/-/g, '');
			var searchEndDate = $('#searchEndDate').val().replace(/-/g, '');
			var searchRefNo = $('#searchRefNo').val();
			var url;

			if(searchStartDate=='' || searchStartDate.length!=8){
				searchStartDate = getToday();
			}
			if(searchEndDate=='' || searchEndDate.length!=8){
				searchEndDate = getToday();
			}
			
			console.log("searchStartDate:"+searchStartDate);
			console.log("searchEndDate:"+searchEndDate);
			console.log("searchRefNo:"+searchRefNo);
			
			// 검색 날짜 검증
			if(searchStartDate > searchEndDate){
				$.messager.show({    // show error message
					title: 'Error',
					msg: '기준일자의 시작일이 종료일 이후 날짜입니다. 다시 입력해주세요.'
				});	
				$('#searchStartDate').textbox('textbox').focus();

				return;
			}

			// DATAGRID LOAD
			$('#dg').datagrid({
				url: '${pageContext.request.contextPath}/rest/accountingGlMasterList?startDate='+searchStartDate+'&endDate='+searchEndDate+'&refNo='+searchRefNo,
				onLoadSuccess:function(){
							
					var rows = $('#dg').datagrid('getRows').length; 
					if(rows==0){
						$.messager.show({    // show error message
							title: 'Error',
							msg: '조회 결과가 없습니다. 입력값을 확인하세요'
						});
					}
							
					setButtonDisable();
							
				},
				onLoadError:function(){
					$.messager.show({    // show error message
						title: 'Error',
						msg: '조회 중 에러가 발생했습니다.'
					});
				}
			});

		}

		function newData(){

			formClear();
					
			setMaxLength();
					
			setButtonDisable();
					
			targetUrl="${pageContext.request.contextPath}/rest/accountingGlMasterList";
			restfulType = "GET";
					
		}

		function editData(){
		}
				
		function saveData(){
		}

		function cancelData(){
		}
		
		function initSearch(){

			console.log("TODAY:"+getFormatDate());
			$('#searchStartDate').textbox('setValue', getFormatDate());
			$('#searchEndDate').textbox('setValue', getFormatDate());
			$('#searchRefNo').textbox('clear');

		}
		
		function searchDetail(){
			var row = $('#dg').datagrid('getSelected');
			
			if (row){
				
				var actgTrDt = row.actgTrDt;
				var actgTrSrno = row.actgTrSrno;	
				var refNo = row.refNo;				
				
				// DATAGRID LOAD
				$('#subdg').datagrid({
					url: '${pageContext.request.contextPath}/rest/accountingGlDetailList?actgTrDt='+actgTrDt+'&actgTrSrno='+actgTrSrno,
					onLoadSuccess:function(){
								
						var rows = $('#subdg').datagrid('getRows').length; 
						if(rows==0){
							$.messager.show({    // show error message
								title: 'Error',
								msg: '조회 결과가 없습니다. 입력값을 확인하세요'
							});
						}
								
						setButtonDisable();
								
					},
					onLoadError:function(){
						$.messager.show({    // show error message
							title: 'Error',
							msg: '조회 중 에러가 발생했습니다.'
						});
					}
				});
				
			}
		}
		
		// TEXTBOX enter event
		$(document).ready(function(){

			// GRID Double Click Event
		   	$('#dg').datagrid({
				onDblClickRow: function(index,row){

					searchDetail();
					setInputDivSizeType2('openSubDg');
				}
		   	});
			
			 // SORTER
			$('#dg').datagrid({
				remoteSort: false,
				columns: [[
					{field:'actgTrDt',		title:'회계일자',	width:'10%',sortable:true,halign:'center', align:'center',	formatter:formatDate, 		sorter:sorter },
					{field:'actgTrSrno',	title:'일련번호',	width:'7%',	sortable:true,halign:'center', align:'center', 								sorter:sorter },
					{field:'bzTcd',			title:'업무구분',	width:'12%',sortable:true,halign:'center', align:'center',								sorter:sorter },
					{field:'refNo',			title:'참조번호',	width:'15%',sortable:true,halign:'center', align:'center', 								sorter:sorter },
					{field:'prcTcd',		title:'처리구분',	width:'8%',	sortable:true,halign:'center', align:'center',								sorter:sorter },
					{field:'orgActgTrDt',	title:'원회계일자',width:'10%',sortable:true,halign:'center', align:'center',	formatter:formatDate, 		sorter:sorter },
					{field:'orgActgTrSrno',	title:'원일련번호',width:'10%',sortable:true,halign:'center', align:'center', 								sorter:sorter },
					{field:'statTcd',		title:'상태구분',	width:'9%',	sortable:true,halign:'center', align:'center',	formatter:formatStatTcd, 	sorter:sorter },
					{field:'regiDt',		title:'등록일자',	width:'10%',sortable:true,halign:'center', align:'center',	formatter:formatDate, 		sorter:sorter },
					{field:'regiTm',		title:'등록시간',	width:'10%',sortable:true,halign:'center', align:'center',	formatter:formatTime, 		sorter:sorter }
				]]
			});
			
		   	setInputDivSizeType2('close');

			setMenuPannel();
			
		});
					
		window.onload = setTimeout(initData, 100);
		window.onload = setTimeout(initSearch, 200);
		window.onload = setTimeout(setButtonDisable, 300);
		$('#main_content_div').css("display","block");
			
		var minHeight=700;
		var minWidth=970;
		var defaultInputDivHeight=300;
		var defaultGridDivHeight=300;
		var minGridDivHeight=150;
				
	</script>	
</body>
</html>
