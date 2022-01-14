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
							<div id="searchCondition_div" class="easyui-panel" title="검색조건" style="width:'auto';height:73px;padding:7px;">
								<div align="left" style="width:70%;float:left">
									<input id="searchStartDate" name="searchStartDate" class="easyui-datebox" label="거래일자" labelWidth="60px" labelAlign="right" style="width:160px" data-options="required:false,formatter:myformatter,parser:myparser" />
									~
									<input id="searchEndDate" name="searchEndDate" class="easyui-datebox" style="width:100px" data-options="required:false,formatter:myformatter,parser:myparser" />
									<input id="searchBrno" name="searchBrno" class="easyui-textbox" label="관리점" labelWidth="50px" labelAlign="right" style="width:90px" data-options="required:true" tabindex="2"/>
									<input id="searchEfmDscd" class="easyui-combobox" name="searchEfmDscd" style="width:100px" tabindex="3" />
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
											<table id="dg" class="easyui-datagrid" style="width:1300px;height:530px"
															method="get" toolbar="#tb" pagination="false"
															autoRowHeight="true"
															view="scrollview"
															rownumbers="true" fitColumns="true" singleSelect="true">
												<thead>
													<tr>
														<th field="refNo" width="10%" sortable="false" data-options="align:'center'"><center>참조번호</center></th>
														<th field="efmDscd" width="5%" sortable="false" data-options="align:'center'"><center>구분</center></th>
														<th field="brno" width="5%" sortable="false" data-options="align:'center'"><center>관리점</center></th>
														<th field="trDt" width="8%" sortable="false" data-options="align:'center',formatter:formatDate"><center>거래일자</center></th>
														<th field="crcd" width="7%" sortable="false" data-options="align:'center'"><center>통화코드</center></th>
														<th field="efmAmt" width="8%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>환전금액</center></th>
														<th field="pmnyAmt" width="8%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>지폐금액</center></th>
														<th field="cnAmt" width="7%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>주화금액</center></th>
														<th field="prmRt" width="5%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>우대율</center></th>
														<th field="custNo" width="7%" sortable="false" data-options="align:'center'"><center>고객번호</center></th>
														<th field="amtyDscd" width="7%" sortable="false" data-options="align:'center'"><center>거주구분</center></th>
														<th field="trMnbdPccd" width="8%" sortable="false" data-options="align:'center'"><center>거래주체</center></th>
														<th field="intdRscd" width="8%" sortable="false" data-options="align:'center'"><center>사유코드</center></th>
														<th field="frxcLdgrStcd" width="7%" sortable="false" data-options="align:'center'"><center>외환원장상태</center></th>
													</tr>
												</thead>
											</table>
										</div>	
										<form id="fm">
											<input id="refNo" name="refNo" type="hidden" class="easyui-textbox"/>
										</form>
									</div><!-- end of grid_accordion -->
								</div>
							</div> 
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
		var parRefNo;
		
		function formClear(){
			$('#searchEfmDscd').textbox('setText','전체');
		}
				
		function setMaxLength(){
					
			// MAXLENGTH
			$("#searchBrno").textbox('textbox').attr('maxlength', 4);

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
			var searchBrno = $('#searchBrno').val();
			var searchEfmDscd = $('#searchEfmDscd').val();
			var url


			if(searchStartDate=='' || searchStartDate.length!=8){
				searchStartDate = getToday();
			}
			if(searchEndDate=='' || searchEndDate.length!=8){
				searchEndDate = getToday();
			}
			
			console.log("searchStartDate:"+searchStartDate);
			console.log("searchEndDate:"+searchEndDate);
			console.log("searchBrno:"+searchBrno);
			console.log("searchEfmDscd:"+searchEfmDscd);
			
			
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
				url: '${pageContext.request.contextPath}/rest/exchangeSearchList?startDate='+searchStartDate+'&endDate='+searchEndDate+'&brno='+searchBrno+'&efmDscd='+searchEfmDscd+'&refNo=',
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
					
			targetUrl="${pageContext.request.contextPath}/rest/exchangeSearchList";
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
			$('#searchBrno').textbox('clear');
			$('#efmDscd').textbox('setValue', '전체');

		}
		
		function openNewWindow(){
			var row = $('#dg').datagrid('getSelected');
			
			if (row){
				$('#fm').form('load',row);
				
				setTextBoxDisable('all');
				$('#tradeType').textbox('enable');

				setButtonDisable();
				setButtonEnable('initBtn');

				$('#tradeType').combobox('setValue', '4-조회');
			}
		}
		
		function openChild(){
			parRefNo = $('#refNo').val();
			console.log("parRefNo:"+parRefNo);
			
//			winObj = window.open('exchangeBuy?refNo='+parRefNo,'','');
			winObj = window.open('exchangeBuy/'+parRefNo,'','');
		}
		
		// TEXTBOX enter event
		$(document).ready(function(){

			// GRID Double Click Event
		   	$('#dg').datagrid({
				onDblClickRow: function(index,row){
					
					openNewWindow();
					
					openChild();
					
				}
		   	});
			
		   	$('#searchEfmDscd').combobox({
		   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=EFM_DSCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '구분',
				labelWidth: '40px',
				labelPosition: 'left',
				labelAlign: 'right',
				required: 'true',
				panelHeight: 'auto',
		   		editable: false,
				keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
					down: function(e){
						$(this).combobox('showPanel');
						$.fn.combobox.defaults.keyHandler.down.call(this,e);
					}
				})
			});	
			
			// SORTER
			$('#dg').datagrid({
				remoteSort: false,
				columns: [[
					{field:'refNo',			title:'참조번호',		width:'10%',sortable:true,align:'center', 								sorter:sorter },
					{field:'efmDscd',		title:'구분',			width:'5%',	sortable:true,align:'center',	sorter:sorter },
					{field:'brno',			title:'관리점',		width:'5%',	sortable:true,align:'center', 								sorter:sorter },
					{field:'trDt',			title:'거래일자',		width:'8%',	sortable:true,align:'center',	formatter:formatDate, 		sorter:sorter },
					{field:'crcd',			title:'통화코드',		width:'7%',	sortable:true,align:'center', 								sorter:sorter },
					{field:'efmAmt',		title:'환전금액',		width:'8%',	sortable:true,align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'pmnyAmt',		title:'지폐금액',		width:'8%',	sortable:true,align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'cnAmt',			title:'주화금액',		width:'7%',	sortable:true,align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'prmRt',			title:'우대율',		width:'5%',	sortable:true,align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'custNo',		title:'고객번호',		width:'7%',	sortable:true,align:'center', 								sorter:sorter },
					{field:'amtyDscd',		title:'거주구분',		width:'7%',	sortable:true,align:'center', 	sorter:sorter },
					{field:'trMnbdPccd',	title:'거래주체',		width:'8%',	sortable:true,align:'center', 	sorter:sorter },
					{field:'intdRscd',		title:'사유코드',		width:'8%',	sortable:true,align:'center', 	sorter:sorter },
					{field:'frxcLdgrStcd',	title:'외환원장상태',	width:'7%',	sortable:true,align:'center',	sorter:sorter }
				]]
			});
			
		   	setInputDivSizeType3('grid_div');

			setMenuPannel();
			
		});
					
		window.onload = setTimeout(initData, 100);
		window.onload = setTimeout(initSearch, 200);
		window.onload = setTimeout(setButtonDisable, 300);
		$('#main_content_div').css("display","block");
			
		var minHeight=700;
		var minWidth=970;
				
	</script>	
</body>
</html>
