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
									<input id="searchActgTrDt" name="searchActgTrDt" class="easyui-datebox" label="거래일자" labelWidth="60px" labelAlign="right" style="width:160px" data-options="required:false,formatter:myformatter,parser:myparser" />
									<input id="searchBrno" name="searchBrno" class="easyui-textbox" label="관리점번호" labelWidth="75px" labelAlign="right" style="width:110px" data-options="required:false" tabindex="2"/>
								</div>
								<div align="right" style="width:30%;float:right">
									<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()">조회</a>
								</div>
							</div>	

							<div class="easyui-layout" data-options="fit:true" >

								<!-- GRID -->
								<div data-options="region:'center'" style="width:100%;padding:0px">
							
									<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">
										<div id="grid_div" title="검색결과" style="width:'auto';height:540px;" data-options="selected:false">
											<table id="dg" class="easyui-datagrid" style="width:100%; height:310px" 
															method="get" toolbar="#tb" pagination="false"
															view="scrollview"
															rownumbers="true" fitColumns="true" singleSelect="true">
												<thead>
													<tr>
														<th field="acsjCd" width="15%" sortable="false" data-options="align:'center'"><center>계정과목코드</center></th>
														<th field="acsjOputNm" width="30%" sortable="false" data-options="align:'left'"><center>계정과목명</center></th>
														<th field="currCd" width="10%" sortable="false" data-options="align:'center'"><center>통화</center></th>
														<th field="frc" width="15%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>외화금액</center></th>
														<th field="won" width="15%" sortable="false" data-options="align:'right',formatter:formatInteger"><center>원화금액</center></th>
														<th field="usdCros" width="15%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>미화환산금액</center></th>
													</tr>
												</thead>
											</table>
											<table id="subdg" class="easyui-datagrid" style="width:100%; height:180px" 
															method="get" toolbar="#tb" pagination="false"
															view="scrollview"
															rownumbers="true" fitColumns="true" singleSelect="true">
												<thead>
													<tr>
														<th field="currCd" width="25%" sortable="false" data-options="align:'center'"><center>통화</center></th>
														<th field="dr" width="25%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>대변</center></th>
														<th field="cr" width="25%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>차변</center></th>
														<th field="sum" width="25%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>차액</center></th>
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
			$("#searchBrno").textbox('textbox').attr('maxlength', 3);

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
					
			var searchActgTrDt = $('#searchActgTrDt').val().replace(/-/g, '');
			var searchBrno = $('#searchBrno').val();
			var url;

			if(searchActgTrDt=='' || searchActgTrDt.length!=8){
				searchActgTrDt = getToday();
			}
			
			console.log("searchActgTrDt:"+searchActgTrDt);
			console.log("searchBrno:"+searchBrno);
			
			// DATAGRID LOAD
			$('#dg').datagrid({
				url: '${pageContext.request.contextPath}/rest/bs?actgTrDt='+searchActgTrDt+'&brno='+searchBrno,
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
			})
			// DATAGRID LOAD
			$('#subdg').datagrid({
				url: '${pageContext.request.contextPath}/rest/bsSum?actgTrDt='+searchActgTrDt+'&brno='+searchBrno,
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
			});		}

		function newData(){

			formClear();
					
			setMaxLength();
					
			setButtonDisable();
					
			targetUrl="${pageContext.request.contextPath}/rest/bs";
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
			$('#searchActgTrDt').textbox('setValue', getFormatDate());
			$('#searchBrno').textbox('clear');

		}
		
		// TEXTBOX enter event
		$(document).ready(function(){

			// GRID Double Click Event
		   	$('#dg').datagrid({
				onDblClickRow: function(index,row){

//					searchDetail();
				}
		   	});
			
		 // SORTER
			$('#dg').datagrid({
				remoteSort: false,
				columns: [[
					{field:'acsjCd',	title:'계정과목코드',	width:'15%',sortable:true,halign:'center', align:'center', 								sorter:sorter},
					{field:'acsjOputNm',title:'계정과목명',	width:'30%',sortable:true,halign:'center', align:'left', 								sorter:sorter},
					{field:'currCd',	title:'통화',			width:'10%',sortable:true,halign:'center', align:'center', 								sorter:sorter},
					{field:'frc',		title:'외화금액',		width:'15%',sortable:true,halign:'center', align:'right',	formatter:formatDecimal, 	sorter:sorter},
					{field:'won',		title:'원화금액',		width:'15%',sortable:true,halign:'center', align:'right',	formatter:formatInteger, 	sorter:sorter},
					{field:'usdCros',	title:'미화환산금액',	width:'15%',sortable:true,halign:'center', align:'right',	formatter:formatDecimal, 	sorter:sorter}
				]]
			});

		   	setInputDivSizeType3('bsList');
			
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
