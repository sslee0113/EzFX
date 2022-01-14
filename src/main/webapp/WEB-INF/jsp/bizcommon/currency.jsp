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
						<div id="searchCondition" class="easyui-panel" title="검색조건" style="width:100%;height:73px;padding:7px;">
							<div align="left" style="width:70%;float:left">
								<input id="searchCurrCode" name="searchCurrCode" class="easyui-textbox" label="통화코드" labelWidth="70px" labelAlign="right" style="width:110px" data-options="required:false" />
							</div>
							<div align="right" style="width:30%;float:right">
								<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
							</div>
						</div>	
						<div class="easyui-layout" data-options="fit:true" >
						
							<!-- GRID -->
							<div data-options="region:'west',split:true, title:'검색결과'" style="width:50%;padding:5px">
								<table id="dg" class="easyui-datagrid" style="width:100%;height:87%"
											url=""
											method="get"
											toolbar="#toolbar" pagination="false"
											rownumbers="true" fitColumns="true" singleSelect="true">
									<thead>
										<tr>
											<th field="currCode" width="25%" sortable="false" align="center"><center>통화코드</center></th>
											<th field="engName" width="25%" sortable="false" ><center>통화영문명</center></th>
											<th field="korName" width="25%" sortable="false" ><center>통화한글명</center></th>
											<th field="currUnit" width="25%" sortable="false" align="right"><center>환율단위</center></th>
										</tr>
									</thead>
								</table>
								<!--
								<div id="toolbar" >
									<div style="margin-bottom:2px">
										<select class="easyui-combobox" id="searchMode" name="searchMode" label="검색모드:" labelWidth="70px" labelAlign="right" style="width:170px;" >
											<option value="ALL">전체조회</option>
											<option value="CURRCODE">특정통화</option>
										</select>
										<input id="searchCurrCode" name="searchCurrCode" class="easyui-textbox" label="통화코드:" labelWidth="70px" labelAlign="right" style="width:110px" data-options="required:false" />
									</div>
								</div>
								-->
							</div> <!-- END OF GRID -->

							<!-- VIEW -->
							<div data-options="region:'center', title:'입력화면'" style="width:50%;padding:10px">
							
								<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
									<div style="margin-bottom:2px">
										<input id="currCode" name="currCode" class="easyui-textbox" label="통화코드" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:true" />
									</div>
									<div style="margin-bottom:2px">
										<input id="engName" name="engName" class="easyui-textbox" label="통화영문명" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:true,validType:'length[1,40]'" />
									</div>
									<div style="margin-bottom:2px">
										<input id="korName" name="korName" class="easyui-textbox" label="통화한글명" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:true,validType:'length[1,40]'" />
									</div>
									<div style="margin-bottom:2px">
										<input id="quotFlag" class="easyui-combobox" name="quotFlag" style="width:200px;"/>
									</div>
									<div style="margin-bottom:2px">
										<input id="quotSeq" name="quotSeq" class="easyui-numberbox" label="고시순서" labelWidth="130px" labelAlign="right" style="width:160px" data-options="required:true,min:0,max:99" />
									</div>
									<div style="margin-bottom:2px">
										<input id="currUnit" name="currUnit" class="easyui-numberbox" label="환율단위" labelWidth="130px" labelAlign="right" style="width:160px" data-options="required:true,min:0,max:99999" />
									</div>
									<div style="margin-bottom:2px">
										<input id="undrPoint" name="undrPoint" class="easyui-numberbox" label="소수점이하의 자릿수" labelWidth="130px" labelAlign="right" style="width:160px" data-options="required:true,min:0,max:8" />
									</div>
									<div style="margin-bottom:2px">
										<input id="ttSprdRate" name="ttSprdRate" class="easyui-numberbox" label="전신환스프레드" labelWidth="130px" labelAlign="right" style="width:300px" data-options="required:true,min:0,max:99999999999999,precision:8" />
									</div>
									<div style="margin-bottom:2px">
										<input id="basicSprdRate" name="basicSprdRate" class="easyui-numberbox" label="현찰스프레드" labelWidth="130px" labelAlign="right" style="width:300px" data-options="required:true,min:0,max:99999999999999,precision:8" />
									</div>
									<div style="margin-bottom:2px">
										<input id="coinSprdRate" name="coinSprdRate" class="easyui-numberbox" label="주화스프레드" labelWidth="130px" labelAlign="right" style="width:300px" data-options="required:true,min:0,max:999999999999999,precision:8" />
									</div>
									<div style="margin-bottom:2px">
										<input id="firstDate" name="firstDate" class="easyui-textbox" label="등록일" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" />
									</div>
									<div style="margin-bottom:2px">
										<input id="lastDate" name="lastDate" class="easyui-textbox" label="최종변경일" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" />
									</div>

									<div style="margin-bottom:2px;display:none">
										<select class="easyui-combobox" id="staCd" name="staCd" label="상태구분코드" labelWidth="130px" labelAlign="right" style="width:200px;">
											<option value="0">정상</option>
											<option value="9">취소</option>
										</select>
									</div>

									<!-- 
									<div id="dlg-buttons" style="margin-top:10px">
										<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveData()" style="width:90px">Save</a>
										<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="initData()" style="width:90px">Cancel</a>
									</div>
									-->
								</form>

							</div> <!-- END OF VIEW -->

						</div> <!--  end of easyui-layout -->

						<div id="footer" align="right" style="padding:5px;">
							<%@ include file="/WEB-INF/jsp/footer/footer_btn.jsp"%>
						</div>

					</div> <!-- END OF RIGHT CONTENT -->
				</div> <!-- END OF main_easyui_layout -->
				</div>
			</div> <!-- end of "center_content" -->

			<!-- SCRIPT -->
			<script type="text/javascript">
				var url;
				var rawData;
				var restfulType,targetUrl,param;
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/Currency";
				var defaultRestfulType="POST";
				
				function formClear(){
					
					$('#currCode').textbox('clear');
					$('#engName').textbox('clear');
					$('#korName').textbox('clear');
					$('#quotFlag').combobox('setValue','Y');
					$('#quotSeq').textbox('clear');
					$('#currUnit').textbox('clear');
					$('#undrPoint').textbox('clear');
					$('#ttSprdRate').textbox('clear');
					$('#basicSprdRate').textbox('clear');
					$('#coinSprdRate').textbox('clear');
					$('#staCd').textbox('setValue','정상');
					$('#firstDate').textbox('clear');
					$('#lastDate').textbox('clear');
					
				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$("#currCode").textbox('textbox').attr('maxlength',3);
					$("#searchCurrCode").textbox('textbox').attr('maxlength',3);
					$("#undrPoint").textbox('textbox').attr('maxlength',1);

				}
				
				function setTextBoxCss(){

					// TEXTBOX 입력시 무조건 대문자화
					$('#currCode').textbox('textbox').css('text-transform','uppercase');
					$('#searchCurrCode').textbox('textbox').css('text-transform','uppercase');
				}
				
				function setTextBoxDisable(textBoxName){
					// Disable
					if(textBoxName=='all' || textBoxName=='currCode'){
						$('#currCode').textbox('disable');	
					}
					if(textBoxName=='all' || textBoxName=='engName'){
						$('#engName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='korName'){
						$('#korName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='quotFlag'){
						$('#quotFlag').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='quotSeq'){
						$('#quotSeq').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='currUnit'){
						$('#currUnit').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='undrPoint'){
						$('#undrPoint').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='ttSprdRate'){
						$('#ttSprdRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='basicSprdRate'){
						$('#basicSprdRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='coinSprdRate'){
						$('#coinSprdRate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='firstDate'){
						$('#firstDate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='lastDate'){
						$('#lastDate').textbox('disable');
					}
					/*
					if(textBoxName=='all' || textBoxName=='searchCurrCode'){
						$("#searchCurrCode").textbox('disable');
					}
					*/
				}
				
				function setTextBoxEnable(){
					// Enable
					$('#currCode').textbox('enable');	
					$('#engName').textbox('enable');
					$('#korName').textbox('enable');
					$('#quotFlag').textbox('enable');
					$('#quotSeq').textbox('enable');
					$('#currUnit').textbox('enable');
					$('#undrPoint').textbox('enable');
					$('#ttSprdRate').textbox('enable');
					$('#basicSprdRate').textbox('enable');
					$('#coinSprdRate').textbox('enable');
					//$('#firstDate').textbox('enable');
					//$('#lastDate').textbox('enable');
				}
				
				function getRawData(){
					rawData = new Object();
					rawData.currCode      = $('#currCode').val();
					rawData.engName       = $('#engName').val();
					rawData.korName       = $('#korName').val();
					rawData.quotFlag      = $('#quotFlag').val();
					rawData.quotSeq       = $('#quotSeq').val();
					rawData.currUnit      = $('#currUnit').val();
					rawData.undrPoint     = $('#undrPoint').val();
					rawData.ttSprdRate    = $('#ttSprdRate').val();
					rawData.basicSprdRate = $('#basicSprdRate').val();
					rawData.coinSprdRate  = $('#coinSprdRate').val();
					rawData.staCd         = $('#staCd').val();

					return rawData;
				}
				
				function searchData(){
					
					var searchCurrCode = $('#searchCurrCode').val().toUpperCase();
					var searchCurrCodeLen = searchCurrCode.length;
					console.log("searchCurrCode:"+searchCurrCode);
					console.log("searchCurrCode.length:"+searchCurrCodeLen);
					console.log("firstDate:" + $('#firstDate').val());
					
					var url = '${pageContext.request.contextPath}/rest/searchListCurrency?currCode='+searchCurrCode;

					console.log(url);
							
					$('#dg').datagrid({
						url:url,
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

					formClear();
					
					setTextBoxEnable();
					setTextBoxDisable('firstDate');
					setTextBoxDisable('lastDate');
					setMaxLength();
					
					setButtonDisable();
					setButtonEnable('initBtn');
					setButtonEnable('saveBtn');
					
					targetUrl="${pageContext.request.contextPath}/rest/Currency";
					restfulType = "POST";
					
				}

				function editData(){
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$('#fm').form('load',row);
						
						setButtonDisable();
						setButtonEnable('initBtn');
						if($('#firstDate').val()==''){
							setButtonEnable('saveBtn');
						}else{
							setButtonEnable('editBtn');
						}
						setButtonEnable('cancelBtn');
						
						setTextBoxEnable();
						setTextBoxDisable('currCode');
						setTextBoxDisable('firstDate');
						setTextBoxDisable('lastDate');

					}
				}
				
				function saveData(){
					
					$.messager.confirm('Confirm','통화코드를 저장하시겠습니까?',function(r){
						if (r){
							rawData = getRawData();
							console.log(JSON.stringify(rawData));
							
							targetUrl="${pageContext.request.contextPath}/rest/Currency";
							
							// 수정과 신규를 구분함
							if($('#firstDate').val()!=''){
								restfulType = "PUT";
							}else{
								restfulType = "POST";
							}

							console.log("rawData.currCode="+rawData.currCode);
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
										msg: "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error
									});
								}    		
							});	
						}
					});
				}

				function cancelData(){
					var selectedCurrCode;
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$.messager.confirm('Confirm','통화코드를 삭제하시겠습니까?',function(r){
							if (r){
								
								selectedCurrCode = getSelectedValue('#dg', 'currCode');	
								console.log(JSON.stringify(getRawData()));
								console.log("${pageContext.request.contextPath}/rest/Currency/"+ getRawData().currCode);
								console.log('selectedCurrCode');
								
								jQuery.ajax({
									type:"DELETE",
									url:"${pageContext.request.contextPath}/rest/Currency/" + selectedCurrCode,
									contentType: 'application/json',
									dataType:"json",
									success:function(){
										//formClear();
										initData();
										$.messager.show({    // show error message
											title: 'Message',
											msg: '정상처리되었습니다.'
										});
										
										if($('#searchCurrCode').val()==''){
											$('#dg').datagrid('reload');    // reload the user data
										}else{
											$('#dg').datagrid('deleteRow', 0);    // clear the user data
										}
									},
									error:function(request,status,error){
										$.messager.show({    // show error message
											title: 'Error',
											msg: "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error
										});
									}  
								});			
							}
						});
					}
				}
				
				// TEXTBOX enter event
				$(document).ready(function(){

					// TEXTBOX에서 엔터 입력시 조회실행
					var t = $('#searchCurrCode');
					t.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					
					// GRID Double Click Event
				   	$('#dg').datagrid({
						onDblClickRow: function(index,row){
							editData();
						},
						onClickRow: function(index,row){
							editData();
						}
					})
					
					// SORTER

					$('#dg').datagrid({
						remoteSort: false,
						columns: [[
							{field:'currCode',	title:'통화코드',	width:'25%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'engName',	title:'통화영문명',width:'25%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'korName',	title:'통화한글명',width:'25%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'currUnit',	title:'환율단위',	width:'25%',sortable:true,halign:'center', align:'center', sorter:sorter }
						]]
					});
					
				   	$('#quotFlag').combobox({
				   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=QUOT_FLAG',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '고시통화여부',
						labelWidth: '130px',
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
					
					$('#main_content').css('height',$(document).innerHeight()-170)
					
					setInputDivSizeType1();
					searchData();
				})

				window.onload = setTimeout(initData, 500);
				$('#main_content_div').css("display","block");	
				
				var minHeight=700;
				var minWidth=970;

			</script>	
    
			<!-- END OF SCRIPT -->

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<!-- end of body-->
	</div>
</body>
</html>
