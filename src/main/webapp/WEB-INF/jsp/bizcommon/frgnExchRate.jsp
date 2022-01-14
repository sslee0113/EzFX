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

				<div id="main_easyui_layout" class="easyui-layout" style="width:100%;">
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
								<input id="searchStartDate" name="searchStartDate" class="easyui-datebox" label="기준일자" labelWidth="80px" labelAlign="right" style="width:180px" data-options="required:false,formatter:myformatter,parser:myparser" />
								~
								<input id="searchEndDate" name="searchEndDate" class="easyui-datebox" style="width:100px" data-options="required:false,formatter:myformatter,parser:myparser" />
								<input id="searchQuotSeq" name="searchQuotSeq" class="easyui-numberbox" label="고시회차" labelWidth="80px" labelAlign="right" style="width:120px" data-options="required:false" />
							</div>
							<div align="right" style="width:30%;float:right">
								<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
							</div>
						</div>	

						<div class="easyui-layout" data-options="fit:true" >
						
							<!-- GRID -->
							<div data-options="region:'center'" style="width:100%;padding:0px">
							
								<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">

									<div id="grid_div" title="검색결과" style="overflow:auto;padding:5px;width:'auto';height:650px;doSize:true;">
										<table id="dg" class="easyui-datagrid" style="width:100%;"
													view="scrollview"
													method="get" toolbar="#toolbar" pagination="false"
													rownumbers="true" fitColumns="true" singleSelect="true">
											<thead>
												<tr>
													<th field="valDate" width="10%" sortable="false" data-options="align:'center',formatter:formatDate"><center>고시일자</center></th>
													<th field="currCode" width="9%" sortable="false" data-options="align:'center'"><center>고시통화코드</center></th>
													<th field="quotSeq" width="9%" sortable="false" data-options="align:'right'"><center>고시회차</center></th>
													<th field="midRate" width="9%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>매매기준율</center></th>
													<th field="ttSellRate" width="9%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>전신환매도율</center></th>
													<th field="ttBuyRate" width="9%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>전신환매입율</center></th>
													<th field="cashSellRate" width="9%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>현찰매도율</center></th>
													<th field="cashBuyRate" width="9%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>현찰매입율</center></th>
													<th field="coinSellRate" width="9%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>주화매도율</center></th>
													<th field="coinBuyRate" width="9%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>주화매입율</center></th>
													<th field="usdCrosRate" width="9%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>대미환산율</center></th>
												</tr>
											</thead>
										</table>
									</div>
									<!-- end of 검색결과 -->
									<div id="input_div" title="입력화면" style="width:100%;height:320px;padding:5px;" 
										data-options=" tools:[{ iconCls:'icon-clear',
																handler:function(){
																	setInputDivSizeType2('close');
																}}]">
									
										<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
											<div align="left" style="width:30%;float:left">
												<div style="margin-bottom:2px">
													<input id="valDate" name="valDate" class="easyui-numberbox" label="고시일자" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:true,min:0,max:99999999" />
												</div>
												<div style="margin-bottom:2px">
													<input id="midRate" name="midRate" class="easyui-numberbox" label="매매기준율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,min:0,max:9999,precision:2,groupSeparator:','" />
												</div>
												<div style="margin-bottom:2px">
													<input id="ttSellRate" name="ttSellRate" class="easyui-numberbox" label="전신환매도율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,precision:2,groupSeparator:','" />
												</div>
												<div style="margin-bottom:2px">
													<input id="cashSellRate" name="cashSellRate" class="easyui-numberbox" label="현찰매도율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,precision:2,groupSeparator:','" />
												</div>
												<div style="margin-bottom:2px">
													<input id="coinSellRate" name="coinSellRate" class="easyui-numberbox" label="주화매도율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,precision:2,groupSeparator:','" />
												</div>
												<div style="margin-bottom:2px">
													<input id="firstDate" name="firstDate" class="easyui-textbox" label="등록일" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" />
												</div>
											</div>
											<div align="left" style="width:30%;float:left">
												<div style="margin-bottom:2px">
													<input id="currCode" name="currCode" class="easyui-textbox" label="고시통화코드" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:true" />
												</div>
												<div style="margin-bottom:2px">
													<input id="usdCrosRate" name="usdCrosRate" class="easyui-numberbox" label="대미환산율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,precision:6,groupSeparator:','" />
												</div>
												<div style="margin-bottom:2px">
													<input id="ttBuyRate" name="ttBuyRate" class="easyui-numberbox" label="전신환매입율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,precision:2,groupSeparator:','" />
												</div>
												<div style="margin-bottom:2px">
													<input id="cashBuyRate" name="cashBuyRate" class="easyui-numberbox" label="현찰매입율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,precision:2,groupSeparator:','" />
												</div>
												<div style="margin-bottom:2px">
													<input id="coinBuyRate" name="coinBuyRate" class="easyui-numberbox" label="주화매입율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,precision:2,groupSeparator:','" />
												</div>
											</div>
											<div align="left" style="width:30%;float:left">
												<div style="margin-bottom:2px">
													<input id="quotSeq" name="quotSeq" class="easyui-numberbox" label="고시회차" labelWidth="130px" labelAlign="right" style="width:160px" data-options="required:true,min:0,max:99999" />
												</div>
											</div>
											<!-- 
												<div style="margin-bottom:2px">
													<input id="valDate" name="valDate" class="easyui-numberbox" label="고시일자" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:true,min:0,max:99999999" />
													<input id="currCode" name="currCode" class="easyui-textbox" label="고시통화코드" labelWidth="160px" labelAlign="right" style="width:210px" data-options="required:true" />
													<input id="quotSeq" name="quotSeq" class="easyui-numberbox" label="고시회차" labelWidth="160px" labelAlign="right" style="width:190px" data-options="required:true,min:0,max:99999" />
												</div>
												<div style="margin-bottom:2px">
													<input id="midRate" name="midRate" class="easyui-numberbox" label="매매기준율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,min:0,max:9999" />
													<input id="usdCrosRate" name="usdCrosRate" class="easyui-numberbox" label="대미환산율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" />
												</div>
												<div style="margin-bottom:2px">
													<input id="ttSellRate" name="ttSellRate" class="easyui-numberbox" label="전신환매도율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" />
													<input id="ttBuyRate" name="ttBuyRate" class="easyui-numberbox" label="전신환매입율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" />
												</div>
												<div style="margin-bottom:2px">
													<input id="cashSellRate" name="cashSellRate" class="easyui-numberbox" label="현찰매도율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" />
													<input id="cashBuyRate" name="cashBuyRate" class="easyui-numberbox" label="현찰매입율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" />
												</div>
												<div style="margin-bottom:2px">
													<input id="coinSellRate" name="coinSellRate" class="easyui-numberbox" label="주화매도율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" />
													<input id="coinBuyRate" name="coinBuyRate" class="easyui-numberbox" label="주화매입율" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" />
												</div>
												
												<div style="margin-bottom:2px">
													<input id="firstDate" name="firstDate" class="easyui-textbox" label="등록일" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" />
												</div>
											 -->
												<div style="margin-bottom:2px;display:none">
													<select class="easyui-combobox" id="staCd" name="staCd" label="상태구분코드" labelWidth="130px" labelAlign="right" style="width:200px;">
													<option value="0">정상</option>
													<option value="9">취소</option>
													</select>
												</div>
										</form>
									</div>
									<!-- end of 입력화면 -->
								</div>
								<!-- end of 'easyui-accordion' -->

							</div> <!-- END OF GRID -->

						</div> <!--  end of easyui-layout -->

						<div id="footer" align="right" style="padding:5px;">
							<%@ include file="/WEB-INF/jsp/footer/footer_btn.jsp"%>
						</div>
					</div> <!-- END OF RIGHT CONTENT -->
        
				</div>
				</div>
			</div> <!-- end of "center_content" -->

			<!-- SCRIPT -->
			<script type="text/javascript">
				var url;
				var rawData;
				var restfulType,targetUrl,param;
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/Frgnexchrate";
				var defaultRestfulType="POST";
				
				
				function initSearch(){

					console.log("TODAY:"+getFormatDate());
					$('#searchStartDate').textbox('setValue', getFormatDate());
					$('#searchEndDate').textbox('setValue', getFormatDate());

				}
				
				function formClear(){
					
					$('#valDate').textbox('clear');
					$('#currCode').textbox('clear');
					$('#quotSeq').textbox('clear');
					$('#midRate').textbox('clear');
					$('#ttSellRate').textbox('clear');
					$('#ttBuyRate').textbox('clear');
					$('#cashSellRate').textbox('clear');
					$('#cashBuyRate').textbox('clear');
					$('#coinSellRate').textbox('clear');
					$('#coinBuyRate').textbox('clear');
					$('#usdCrosRate').textbox('clear');
					$('#staCd').textbox('setValue','정상');
					$('#firstDate').textbox('clear');
					
				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$('#valDate').textbox('textbox').attr('maxlength',8);
					$('#currCode').textbox('textbox').attr('maxlength',3);
					$('#quotSeq').textbox('textbox').attr('maxlength',5);

				}
				
				function setTextBoxCss(){

					// TEXTBOX 입력시 무조건 대문자화
					$('#currCode').textbox('textbox').css('text-transform','uppercase');

				}
				
				function setTextBoxDisable(textBoxName){
					
					// Disable
					if(textBoxName=='all' || textBoxName=='valDate'){
						$('#valDate').textbox('disable');	
					}
					if(textBoxName=='all' || textBoxName=='currCode'){
						$('#currCode').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='quotSeq'){
						$('#quotSeq').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='midRate'){
						$('#midRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='ttSellRate'){
						$('#ttSellRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='ttBuyRate'){
						$('#ttBuyRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='cashSellRate'){
						$('#cashSellRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='cashBuyRate'){
						$('#cashBuyRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='coinSellRate'){
						$('#coinSellRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='coinBuyRate'){
						$('#coinBuyRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='usdCrosRate'){
						$('#usdCrosRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='firstDate'){
						$('#firstDate').textbox('disable');
					}
					
					// SEARCH TEXTBOX
					/*
					if(textBoxName=='all' || textBoxName=='searchStartDate'){
						$("#searchStartDate").textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='searchEndDate'){
						$("#searchEndDate").textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='searchQuotSeq'){
						$("#searchQuotSeq").textbox('disable');
					}
					*/
				}
				
				function setTextBoxEnable(){
					// Enable
					$('#valDate').textbox('enable');	
					$('#currCode').textbox('enable');
					$('#quotSeq').textbox('enable');
					$('#midRate').textbox('enable');
					$('#ttSellRate').textbox('enable');
					$('#ttBuyRate').textbox('enable');
					$('#cashSellRate').textbox('enable');
					$('#cashBuyRate').textbox('enable');
					$('#coinSellRate').textbox('enable');
					$('#coinBuyRate').textbox('enable');
					$('#usdCrosRate').textbox('enable');
					//$('#firstDate').textbox('enable');
				}
				
				
				function getRawData(){
					rawData = new Object();
					rawData.valDate       = $('#valDate').val().replace(/-/g,'');
					rawData.currCode      = $('#currCode').val().toUpperCase();
					rawData.quotSeq       = $('#quotSeq').val();
					rawData.midRate       = $('#midRate').val();
					rawData.ttSellRate    = $('#ttSellRate').val();
					rawData.ttBuyRate     = $('#ttBuyRate').val();
					rawData.cashSellRate  = $('#cashSellRate').val();
					rawData.cashBuyRate   = $('#cashBuyRate').val();
					rawData.coinSellRate  = $('#coinSellRate').val();
					rawData.coinBuyRate   = $('#coinBuyRate').val();
					rawData.usdCrosRate   = $('#usdCrosRate').val();
					rawData.staCd         = $('#staCd').val();
									
					return rawData;
				}
				
				function searchData(){

					var searchStartDate = $('#searchStartDate').val().replace(/-/g, '');
					var searchEndDate = $('#searchEndDate').val().replace(/-/g, '');
					var searchQuotSeq = $('#searchQuotSeq').val();
					var url;
					
					if(searchStartDate=='' || searchStartDate.length!=8){
						searchStartDate = getToday();
					}
					if(searchEndDate=='' || searchEndDate.length!=8){
						searchEndDate = getToday();
					}
					if(searchQuotSeq=='' || searchQuotSeq.length==0){
						searchQuotSeq = 0;
					}
					
					console.log("searchStartDate:"+searchStartDate);
					console.log("searchEndDate:"+searchEndDate);
					console.log("searchQuotSeq:"+searchQuotSeq);
					
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
						url: '${pageContext.request.contextPath}/rest/searchListFrgnExchRate?startDate='+searchStartDate+'&endDate='+searchEndDate+'&quotSeq='+searchQuotSeq
					});
					
				}

				function newData(){

					formClear();
					
					setTextBoxEnable();
					setTextBoxDisable('firstDate');
					setMaxLength();
					
					setButtonDisable();
//					setButtonEnable('initBtn');
//					setButtonEnable('saveBtn');
					
					targetUrl="${pageContext.request.contextPath}/rest/Frgnexchrate";
					restfulType = "POST";
					
					$('#valDate').textbox('setValue', getFormatDate());
					
				}

				function editData(){
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$('#fm').form('load',row);
						
						setButtonDisable();
						setTextBoxDisable('all');
						/*
						setButtonEnable('initBtn');
						if($('#firstDate').val()==''){
							setButtonEnable('saveBtn');
						}else{
							setButtonEnable('editBtn');
						}
						setButtonEnable('cancelBtn');
						
						setTextBoxEnable();
						setTextBoxDisable('valDate');
						setTextBoxDisable('currCode');
						setTextBoxDisable('quotSeq');
						setTextBoxDisable('firstDate');
						*/

					}
				}
				
				function saveData(){
					
					$.messager.confirm('Confirm','환율 정보를 저장하시겠습니까?',function(r){
						if (r){
							rawData = getRawData();
							console.log(JSON.stringify(rawData));
							
							targetUrl="${pageContext.request.contextPath}/rest/Frgnexchrate";
							
							// 수정과 신규를 구분함
							if($('#firstDate').val()!=''){
								restfulType = "PUT";
							}else{
								restfulType = "POST";
							}

							console.log("rawData.valDate="+rawData.valDate);
							console.log("rawData.currCode="+rawData.currCode);
							console.log("rawData.quotSeq="+rawData.quotSeq);
							console.log("targetUrl="+targetUrl);
							console.log("restfulType="+restfulType);
							
							jQuery.ajax({
								type:restfulType,
								url:targetUrl,
								contentType: 'application/json',
								data: JSON.stringify(rawData),
								dataType:"json",
								success:function(){
									$('#dg').datagrid('reload');    // reload the user data

									initData();

									$.messager.show({    // show error message
										title: 'Message',
										msg: '정상처리되었습니다.'
									});
								},
								error:function(request,status,error){
									$.messager.show({    // show error message
										title: 'Error',
										timeout:10000,
										msg: "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error
									});
								}    		
							});	
						}
					});
				}

				function cancelData(){
					var selectedValDate;
					var selectedCurrCode;
					var selectedQuotSeq;
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$.messager.confirm('Confirm','환율 정보를 삭제하시겠습니까?',function(r){
							if (r){
								
								selectedValDate = getSelectedValue('#dg', 'valDate');	
								selectedCurrCode = getSelectedValue('#dg', 'currCode');	
								selectedQuotSeq = getSelectedValue('#dg', 'quotSeq');	
								
								jQuery.ajax({
									type:"DELETE",
									url:"${pageContext.request.contextPath}/rest/Frgnexchrate?valDate="+selectedValDate+"&currCode="+selectedCurrCode+"&quotSeq="+selectedQuotSeq,
									contentType: 'application/json',
									dataType:"json",
									success:function(){
										//formClear();
										initData();
										$.messager.show({    // show error message
											title: 'Message',
											msg: '정상처리되었습니다.'
										});
										
										if($('#searchQuotSeq').val()==''){
											$('#dg').datagrid('reload');    // reload the user data
										}else{
											var row = $('#dg').datagrid('getSelected');
											var rowIndex = $('#dg').datagrid('getRowIndex', row);
											$('#dg').datagrid('deleteRow', rowIndex);    // clear the user data
										}
									},
									error:function(request,status,error){
										$.messager.show({    // show error message
											title: 'Error',
											timeout:10000,
											msg: "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error
										});
									}  
								});			
							}
						});
					}
				}
				
				/** ezfx.js 에 선언했는데 왜 못찾지 ㅡㅡa **/
				/** GRID FORMATTER **/
				function formatDate(val,row){
					return getFormatDate(val);
				}
				
				// TEXTBOX enter event
				
				$(document).ready(function(){

					// TEXTBOX에서 엔터 입력시 조회실행
					/*
					var s = $('#searchStartDate');
					s.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					var t = $('#searchEndDate');
					t.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					*/
					
					var u = $('#searchQuotSeq');
					u.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					
					// GRID Double Click Event
				   	$('#dg').datagrid({
						onDblClickRow: function(index,row){
							editData();

							setInputDivSizeType2('open');
							    
						},
						onClickRow: function(index,row){
							editData();
						}
					})
					
					// SORTER
					/*
					$('#dg').datagrid({
						remoteSort: false,
						columns: [[
							{field:'valDate',title:'고시일자',width:'10%',sortable:true,align:'center',formatter:formatDate, sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'currCode',title:'고시통화코드',width:'9%',sortable:true,align:'center', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'quotSeq',title:'고시회차',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'midRate',title:'매매기준율',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'ttSellRate',title:'전신환매도율',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'ttBuyRate',title:'전신환매입율',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'cashSellRate',title:'현찰매도율',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'cashBuyRate',title:'현찰매입율',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'coinSellRate',title:'주화매도율',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'coinBuyRate',title:'주화매입율',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'usdCrosRate',title:'대미환산율',width:'9%',sortable:true,align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } }
						]]
					});
					*/
					
					// SEARCH
					searchData();
					
					setInputDivSizeType2('close');
					
					
					$(function(){
					    $(window).resize(function(){
					        $('#main_easyui_layout').panel('resize',{width:$(this).parent().width()});
					        $('#contents_div').panel('resize',{width:$(this).parent().width()});
					        $('#grid_accordion').panel('resize',{width:$(this).parent().width()});
							$('#grid_div').panel('resize',{width:$(this).parent().width()});
					    })
					})
					
				})

				window.onload = setTimeout(initData, 200);
				window.onload = setTimeout(initSearch, 300);
				window.onload = setTimeout(setButtonDisable, 500);

				$('#main_content_div').css("display","block");
				
				var minHeight=700;
				var minWidth=970;
				var defaultInputDivHeight=240;
				var defaultGridDivHeight=300;
				var minGridDivHeight=130;

			</script>	
    
			<!-- END OF SCRIPT -->

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<!-- end of body-->
	</div>
</body>
</html>
