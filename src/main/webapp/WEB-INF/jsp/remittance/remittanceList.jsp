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
								<input id="searchStartDate" name="searchStartDate" class="easyui-datebox" label="거래일자" labelWidth="70px" labelAlign="right" style="width:180px" data-options="required:false,formatter:myformatter,parser:myparser" />
								<input id="searchEndDate" name="searchEndDate" class="easyui-datebox" style="width:100px" data-options="required:false,formatter:myformatter,parser:myparser" />
								<input id="searchRefNo" name="searchRefNo" class="easyui-textbox" label="참조번호" labelWidth="70px" labelAlign="right" style="width:205px" data-options="required:true" tabindex="2"/>
								<div align="right" style="width:30%;float:right">
									<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()">조회</a>
								</div>
							</div>	

							<div class="easyui-layout" data-options="fit:true" >

								<!-- GRID -->
								<div data-options="region:'center'" style="width:100%;padding:0px">
							
									<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">
						
										<div id="grid_div" title="검색결과" style="width:'auto';height:'auto';" data-options="selected:false">
											<table id="dg" class="easyui-datagrid" style="width:100%"
													method="get" toolbar="#tb" pagination="false"
													rownumbers="true" fitColumns="true" singleSelect="true">
												<thead>
													<tr>
														<th field="refNo" width="13%" sortable="false" data-options="align:'center'"><center>참조번호</center></th>
														<th field="trDt" width="13%" sortable="false" data-options="align:'center',formatter:formatDate"><center>거래일자</center></th>
														<th field="rmprCustNo" width="13%" sortable="false" data-options="align:'center'"><center>고객번호</center></th>
														<th field="rmprKrFirstNm" width="13%" sortable="false" data-options="align:'left'"><center>고객명</center></th>
														<th field="crcd" width="10%" sortable="false" data-options="align:'center'"><center>통화코드</center></th>
														<th field="owmnAmt" width="13%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>송금금액</center></th>
														<th field="aplExrt" width="13%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>적용환율</center></th>
														<th field="frxcLdgrStcd" width="12%" sortable="false" data-options="align:'center'"><center>외환원장상태</center></th>
													</tr>
												</thead>
											</table>
										</div>
										<form id="fm">
											<input id="refNo" name="refNo" type="hidden" class="easyui-textbox"/>
										</form>
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
	var defaultTargetUrl="${pageContext.request.contextPath}/rest/remittance";
	var defaultRestfulType="POST";
	var c1 = '1-정상/등록';
	var c3 = '3-취소';
	var c4 = '4-조회';
	var parRefNo;
				
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
				url: '${pageContext.request.contextPath}/rest/remittance?startDate='+searchStartDate+'&endDate='+searchEndDate+'&refNo='+searchRefNo,
				onLoadSuccess:function(){
							
					var rows = $('#dg').datagrid('getRows').length; 
					if(rows==0){
						$.messager.show({    // show error message
							title: 'Error',
							msg: '조회 결과가 없습니다. 입력값을 확인하세요'
						});
					}
							
					setButtonDisable();
					setButtonEnable('initBtn');
					setButtonEnable('saveBtn');
							
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
					
			setTextBoxEnable();
			setTextBoxDisable('firstDate');
			setTextBoxDisable('lastDate');
			setMaxLength();
					
			setButtonDisable();
			setButtonEnable('initBtn');
			setButtonEnable('saveBtn');
					
			targetUrl="${pageContext.request.contextPath}/rest/remittance";
			restfulType = "POST";
					
		}

		function editData(){
		}
				
		function saveData(){
		}

		function cancelData(){
		}
		
		function searchDetail(){
			var row = $('#dg').datagrid('getSelected');
			
			if (row){
				
				$('#isSearch').val('Y'); // 조회 시에는 금액선조회(preCalc)가 동작하지 않도록 하기 위해서
				$('#fm').form('load',row);
				setTimeout(function(row) {
					$('#isSearch').val('N');
				}, 500);
				
				setTextBoxDisable('all');
				$('#tradeType').textbox('enable');

				setButtonDisable();
				setButtonEnable('initBtn');

				$('#tradeType').combobox('setValue', c4);
			}
		}
		
		function initSearch(){

			console.log("TODAY:"+getFormatDate());
			$('#searchStartDate').textbox('setValue', getFormatDate());
			$('#searchEndDate').textbox('setValue', getFormatDate());

		}
		
		function openChild(){
			parRefNo = $('#refNo').val();
			console.log("parRefNo:"+parRefNo);
			
			winObj = window.open('remittance/'+parRefNo,'','');
		}

		// TEXTBOX enter event
		$(document).ready(function(){

			// GRID Double Click Event
		   	$('#dg').datagrid({
				onDblClickRow: function(index,row){
					
					searchDetail();
					
					openChild();
				}
		   	});
			
			// TEXTBOX에서 엔터 입력시 조회실행
			var t = $('#searchRefNo');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchData();
				}
			});	
			
			// SORTER
			$('#dg').datagrid({
				remoteSort: false,
				columns: [[
					{field:'refNo',			title:'참조번호',		width:'13%',sortable:true,align:'center', 								sorter:sorter },
					{field:'trDt',			title:'거래일자',		width:'13%',sortable:true,align:'center',	formatter:formatDate, 		sorter:sorter },
					{field:'rmprCustNo',	title:'고객번호',		width:'13%',sortable:true,align:'center', 								sorter:sorter },
					{field:'rmprKrFirstNm',	title:'고객명',		width:'13%',sortable:true,align:'left', 								sorter:sorter },
					{field:'crcd',			title:'통화코드',		width:'10%',sortable:true,align:'center', 								sorter:sorter },
					{field:'owmnAmt',		title:'송금금액',		width:'13%',sortable:true,align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'aplExrt',		title:'적용환율',		width:'13%',sortable:true,align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'frxcLdgrStcd',	title:'외환원장상태',	width:'12%',sortable:true,align:'center',							 	sorter:sorter }
				]]
			});
			
		   	setInputDivSizeType3('grid_div');

			setMenuPannel();
			
		});
					
		
		window.onload = setTimeout(initSearch, 200);
		$('#main_content_div').css("display","block");
			
		var minHeight=700;
		var minWidth=970;
				
	</script>	
</body>
</html>
