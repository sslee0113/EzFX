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

			<div class="center_content" >

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
								<input id="searchBrno" name="searchBrno" class="easyui-textbox" label="영업점번호" labelWidth="80px" labelAlign="right" style="width:120px" data-options="required:false" />
								<input id="searchKorName" name="searchKorName" class="easyui-textbox" label="영업점명" labelWidth="70px" labelAlign="right" style="width:250px" data-options="required:false" />
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
											<th field="brno" width="20%" sortable="false" ><center>영업점번호</center></th>
											<th field="fxBrnNo" width="20%" sortable="false" ><center>외환점번호</center></th>
											<th field="korName" width="20%" sortable="false" ><center>영업점명</center></th>
											<th field="telNo" width="20%" sortable="false" ><center>전화번호</center></th>
											<th field="faxNo" width="20%" sortable="false" ><center>팩스번호</center></th>
										</tr>
									</thead>
								</table>
								<!--
								<div id="toolbar" >
									<div style="margin-bottom:2px">
										<select class="easyui-combobox" id="searchMode" name="searchMode" label="검색모드" labelWidth="70px" labelAlign="right" style="width:170px;" >
											<option value="ALL">전체조회</option>
											<option value="CURRCODE">특정통화</option>
										</select>
										<input id="searchBrno" name="searchBrno" class="easyui-textbox" label="통화코드" labelWidth="70px" labelAlign="right" style="width:110px" data-options="required:false" />
									</div>
								</div>
								-->
							</div> <!-- END OF GRID -->

							<!-- VIEW -->
							<div data-options="region:'center', title:'입력화면'" style="width:50%;padding:10px">
							
								<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
									<div style="margin-bottom:2px">
										<input id="brno" name="brno" class="easyui-textbox" label="영업점번호" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:true,min:0,max:9999" />
									</div>
									<div style="margin-bottom:2px">
										<input id="korName" name="korName" class="easyui-textbox" label="영업점명" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:true,validType:'length[1,30]'" />
									</div>
									<div style="margin-bottom:2px">
										<input id="engName" name="engName" class="easyui-textbox" label="영업점영문명" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:true,validType:'length[1,30]'" />
									</div>
									<div style="margin-bottom:2px">
										<input id="fxBrnNo" name="fxBrnNo" class="easyui-numberbox" label="외환점번호" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:false,min:0,max:9999" />
									</div>
									<div style="margin-bottom:2px">
										<input id="telNo" name="telNo" class="easyui-textbox" label="전화번호" labelWidth="130px" labelAlign="right" style="width:220px" data-options="required:true" />
									</div>
									<div style="margin-bottom:2px">
										<input id="faxNo" name="faxNo" class="easyui-textbox" label="팩스번호" labelWidth="130px" labelAlign="right" style="width:220px" data-options="required:true" />
									</div>
									<div style="margin-bottom:2px">
										<input id="zipCode" name="zipCode" class="easyui-textbox" label="우편번호" labelWidth="130px" labelAlign="right" style="width:190px" data-options="required:true" />
									</div>
									<div style="margin-bottom:2px">
										<input id="addr" name="addr" class="easyui-textbox" label="주소" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:true" />
									</div>
									<div style="margin-bottom:2px">
										<input id="brnType" class="easyui-combobox" name="brnType" style="width:200px;"/>
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
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/Branch";
				var defaultRestfulType="POST";
				
				function formClear(){
					
					$('#brno').textbox('clear');
					$('#engName').textbox('clear');
					$('#korName').textbox('clear');
					$('#fxBrnNo').textbox('clear');
					$('#telNo').textbox('clear');
					$('#faxNo').textbox('clear');
					$('#zipCode').textbox('clear');
					$('#addr').textbox('clear');
					$('#brnType').combobox('setValue', '0');
					$('#staCd').textbox('setValue','정상');
					$('#firstDate').textbox('clear');
					$('#lastDate').textbox('clear');
					
				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$("#brno").textbox('textbox').attr('maxlength',4);
					$("#searchBrno").textbox('textbox').attr('maxlength',4);
					$('#engName').textbox('textbox').attr('maxlength',30);
					$('#korName').textbox('textbox').attr('maxlength',30);
					$('#fxBrnNo').textbox('textbox').attr('maxlength',4);
					$('#telNo').textbox('textbox').attr('maxlength',12);
					$('#faxNo').textbox('textbox').attr('maxlength',12);
					$('#zipCode').textbox('textbox').attr('maxlength',7);
					$('#addr').textbox('textbox').attr('maxlength',100);

				}
				
				function setTextBoxCss(){

					// TEXTBOX 입력시 무조건 대문자화

				}
				
				function setTextBoxDisable(textBoxName){
					// Disable
					if(textBoxName=='all' || textBoxName=='brno'){
						$('#brno').textbox('disable');	
					}
					if(textBoxName=='all' || textBoxName=='engName'){
						$('#engName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='korName'){
						$('#korName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='fxBrnNo'){
						$('#fxBrnNo').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='telNo'){
						$('#telNo').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='faxNo'){
						$('#faxNo').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='zipCode'){
						$('#zipCode').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='addr'){
						$('#addr').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='brnType'){
						$('#brnType').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='firstDate'){
						$('#firstDate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='lastDate'){
						$('#lastDate').textbox('disable');
					}
					
					/*
					// SEARCH TEXTBOX
					if(textBoxName=='all' || textBoxName=='searchBrno'){
						$("#searchBrno").textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='searchKorName'){
						$("#searchKorName").textbox('disable');
					}
					*/
				}
				
				function setTextBoxEnable(){
					// Disable
					$('#brno').textbox('enable');	
					$('#engName').textbox('enable');
					$('#korName').textbox('enable');
					$('#fxBrnNo').textbox('enable');
					$('#telNo').textbox('enable');
					$('#faxNo').textbox('enable');
					$('#zipCode').textbox('enable');
					$('#addr').textbox('enable');
					$('#brnType').textbox('enable');
					//$('#firstDate').textbox('enable');
					//$('#lastDate').textbox('enable');
				}
				
				function getRawData(){
					rawData = new Object();
					rawData.brno	= $('#brno').val();
					rawData.engName = $('#engName').val();
					rawData.korName = $('#korName').val();
					rawData.fxBrnNo = $('#fxBrnNo').val();
					rawData.telNo   = $('#telNo').val();
					rawData.faxNo   = $('#faxNo').val();
					rawData.zipCode = $('#zipCode').val();
					rawData.addr    = $('#addr').val();
					rawData.brnType = $('#brnType').val();
					rawData.staCd   = $('#staCd').val();

					return rawData;
				}
				
				function searchData(){
					
					var searchBrno = $('#searchBrno').val();
					var searchKorName = $('#searchKorName').val();
					var searchBrnoLen = searchBrno.length;
					var searchKorNameLen = searchKorName.length;
					console.log("searchBrno:"+searchBrno);
					console.log("searchBrno.length:"+searchBrnoLen);
					console.log("searchKorName:"+searchKorName);
					console.log("searchKorName.length:"+searchKorNameLen);
					
					var url = '${pageContext.request.contextPath}/rest/searchListBranch?brno='+searchBrno+'&korName='+searchKorName;
					
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
					
					targetUrl="${pageContext.request.contextPath}/rest/Branch";
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
						setTextBoxDisable('brno');
						setTextBoxDisable('firstDate');
						setTextBoxDisable('lastDate');

					}
				}
				
				function saveData(){
					
					$.messager.confirm('Confirm','영업점 정보를 저장하시겠습니까?',function(r){
						if (r){
							rawData = getRawData();
							console.log(JSON.stringify(rawData));
							
							targetUrl="${pageContext.request.contextPath}/rest/Branch";
							
							// 수정과 신규를 구분함
							if($('#firstDate').val()!=''){
								restfulType = "PUT";
							}else{
								restfulType = "POST";
							}

							console.log("rawData.brno="+rawData.brno);
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
					var selectedBrno;
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$.messager.confirm('Confirm','영업점 정보를 취소하시겠습니까?',function(r){
							if (r){
								
								selectedBrno = getSelectedValue('#dg', 'brno');	
								
								jQuery.ajax({
									type:"DELETE",
									url:"${pageContext.request.contextPath}/rest/Branch/" + selectedBrno,
									contentType: 'application/json',
									dataType:"json",
									success:function(){
										//formClear();
										initData();
										$.messager.show({    // show error message
											title: 'Message',
											msg: '정상처리되었습니다.'
										});
										
										if($('#searchBrno').val()==''){
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
					var t = $('#searchBrno');
					t.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					
					var u = $('#searchKorName');
					u.textbox('textbox').bind('keydown', function(e){
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
							{field:'brno',		title:'영업점번호',		width:'20%',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'fxBrnNo',	title:'외환점번호',		width:'20%',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'korName',	title:'영업점명',		width:'20%',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'telNo',		title:'전화번호',		width:'20%',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'faxNo',		title:'팩스번호',		width:'20%',halign:'center', align:'center', sortable:true, sorter:sorter }
						]]
					});
					
				   	$('#brnType').combobox({
				   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=BRN_TYPE',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '지점상태',
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
					newData();
					searchData();
					
				})

				//window.onload = setTimeout(initData, 500);
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
