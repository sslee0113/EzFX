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
								<input id="searchCifNo" name="searchCifNo" class="easyui-textbox" label="고객번호" labelWidth="80px" labelAlign="right" style="width:180px" data-options="required:false" />
								<input id="searchBrnNo" name="searchBrnNo" class="easyui-textbox" label="관리점번호" labelWidth="80px" labelAlign="right" style="width:120px" data-options="required:false" />
								<!--
								<input id="searchKorName" name="searchKorName" class="easyui-textbox" label="고객한글명" labelWidth="80px" labelAlign="right" style="width:250px" data-options="required:false" />
								-->
								<input id="searchEngFirstName" name="searchEngFirstName" class="easyui-textbox" label="고객영문명" labelWidth="80px" labelAlign="right" style="width:250px" data-options="required:false" />
							</div>
							<div align="right" style="width:30%;float:right">
								<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
							</div>
						</div>	
						<div class="easyui-layout" data-options="fit:true" >
						
							<!-- GRID -->
							<div data-options="region:'center'" style="width:100%;padding:0px">
							
								<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">

									<div id="grid_div" title="검색결과" style="overflow:auto;padding:5px;width:'auto';height:670px;doSize:true;">
										<table id="dg" class="easyui-datagrid" 
													url = ""
													view="scrollview" style="width:100%;"
													method="get" toolbar="#toolbar" pagination="false"
													rownumbers="true" fitColumns="true" singleSelect="true">
											<thead>
												<tr>
													<th field="cifNo" width="15%" sortable="false" ><center>고객번호</center></th>
													<th field="brnNo" width="10%" sortable="false" ><center>점번호</center></th>
													<th field="telNo" width="10%" sortable="false" ><center>전화번호</center></th>
													<th field="korLastName" width="25%" sortable="false" data-options="formatter:mergeKorName"><center>한글명</center></th>
													<th field="engLastName" width="25%" sortable="false" data-options="formatter:mergeEngName"><center>고객영문명</center></th>
													<th field="orCifFlag" width="15%" sortable="false" data-options="align:'center'"><center>당발송금고객여부</center></th>
												</tr>
											</thead>
										</table>
									</div>
									<!-- end of 검색결과 -->
									<div id="input_div" title="입력화면" style="width:'auto';height:500px;padding:5px;" 
										data-options=" tools:[{ iconCls:'icon-clear',
																handler:function(){
																	setInputDivSizeType2('close');
																}}]">
							
										<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="cifNo" name="cifNo" class="easyui-numberbox" label="고객번호" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true,min:0,max:999999999999" tabindex="1"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="residentCd" class="easyui-combobox" name="residentCd" style="width:250px;"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="korLastName" name="korLastName" class="easyui-textbox" label="한글성명(성)" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:true,validType:'length[1,50]'" tabindex="5"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="engLastName" name="engLastName" class="easyui-textbox" label="영문성명(성)" labelWidth="130px" labelAlign="right" style="width:350px" data-options="required:true,validType:'length[1,50]'" tabindex="7"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="habitationCd" class="easyui-combobox" name="habitationCd" style="width:230px;"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="telNo" name="telNo" class="easyui-textbox" label="전화번호" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" tabindex="11"/>
												</div>
											</div>
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="brnNo" name="brnNo" class="easyui-numberbox" label="관리점번호" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:false,min:0,max:9999" tabindex="2"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="residentNo" name="residentNo" class="easyui-textbox" label="실명번호" labelWidth="130px" labelAlign="right" style="width:270px" data-options="required:true" tabindex="4"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="korFirstName" name="korFirstName" class="easyui-textbox" label="한글성명(이름)" labelWidth="130px" labelAlign="right" style="width:350px" data-options="required:true,validType:'length[1,50]'" tabindex="6"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="engFirstName" name="engFirstName" class="easyui-textbox" label="영문성명(이름)" labelWidth="130px" labelAlign="right" style="width:350px" data-options="required:true,validType:'length[1,50]'" tabindex="8"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="nationalCode" class="easyui-combobox" name="nationalCode" style="width:200px;"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="cellNo" name="cellNo" class="easyui-textbox" label="핸드폰번호" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" tabindex="12"/>
												</div>
											</div>
											<div align="left" style="width:100%">
												<div style="margin-bottom:2px">
													<div style="float:left;margin-bottom:2px">
														<input id="zipCode" name="zipCode" class="easyui-textbox"  label="우편번호" labelWidth="130px" labelAlign="right" style="width:180px" data-options="required:false" tabindex="13"/>
													</div>
													<div style="float:left;padding-left:3px">
														<%@ include file="/WEB-INF/jsp/inc/zipcodeWindow.jsp"%>
													</div>
												</div>
												<div class="easyui-layout" style="width:100%;height:2px"></div>
												<div style="margin-bottom:2px">
													<input id="addr1" name="addr1" class="easyui-textbox" label="한글주소1" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:false" tabindex="14"/>
												</div>	
												<div style="margin-bottom:2px">
													<input id="addr2" name="addr2" class="easyui-textbox" label="한글주소2" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:false" tabindex="15"/>
												</div>	
											</div>
											<div align="left" style="width:100%;height:10px">
												&nbsp;
											</div>
											<div align="left" style="width:100%">
												<div style="margin-bottom:2px">
													<input id="orCifFlag" class="easyui-combobox" name="orCifFlag" style="width:200px;"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="orEngAddr1" name="orEngAddr1" class="easyui-textbox" label="송금영문주소1" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:false,validType:'length[1,65]'" tabindex="18"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="orEngAddr2" name="orEngAddr2" class="easyui-textbox" label="송금영문주소2" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:false,validType:'length[1,65]'" tabindex="19"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="orEngAddr3" name="orEngAddr3" class="easyui-textbox" label="송금영문주소3" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:false,validType:'length[1,65]'" tabindex="20"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="orEngAddr4" name="orEngAddr4" class="easyui-textbox" label="송금영문주소4" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:false,validType:'length[1,65]'" tabindex="21"/>
												</div>
											</div>
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="firstDate" name="firstDate" class="easyui-textbox" label="최초등록일자" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="22"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="firstTime" name="firstTime" class="easyui-textbox" label="최초등록시간" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="24"/>
												</div>
											</div>
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="lastDate" name="lastDate" class="easyui-textbox" label="최종변경일자" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="23"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="lastTime" name="lastTime" class="easyui-textbox" label="최종변경시간" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="25"/>
												</div>
											</div>
											
											<div style="margin-bottom:2px;display:none">
												<select class="easyui-combobox" id="staCd" name="staCd" label="상태구분코드" labelWidth="130px" labelAlign="right" style="width:200px;" data-options="panelHeight:50">
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
				</div> <!-- END OF main_easyui_layout -->
				</div>
			</div> <!-- end of "center_content" -->

			<!-- SCRIPT -->
			<script type="text/javascript">
				var url;
				var rawData;
				var restfulType,targetUrl,param;
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/Customer";
				var defaultRestfulType="POST";
				
				function formClear(){
					
					$('#cifNo').textbox('clear');
					$('#brnNo').textbox('clear');
					$('#residentCd').combobox('setValue','1');
					$('#residentNo').textbox('clear');
					$('#engFirstName').textbox('clear');
					$('#engLastName').textbox('clear');
					$('#korFirstName').textbox('clear');
					$('#korLastName').textbox('clear');
					$('#habitationCd').combobox('setValue', '2');
					$('#nationalCode').combobox('setValue', 'KR');
					$('#telNo').textbox('clear');
					$('#cellNo').textbox('clear');
					$('#zipCode').textbox('clear');
					$('#addr1').textbox('clear');
					$('#addr2').textbox('clear');
					$('#orCifFlag').textbox('setValue', 'N');
					$('#orEngAddr1').textbox('clear');
					$('#orEngAddr2').textbox('clear');
					$('#orEngAddr3').textbox('clear');
					$('#orEngAddr4').textbox('clear');
					$('#staCd').textbox('setValue','정상');
					$('#firstDate').textbox('clear');
					$('#firstTime').textbox('clear');
					$('#lastDate').textbox('clear');
					$('#lastTime').textbox('clear');

					$('#searchZipcode').textbox('clear');
					$('#searchProvince').textbox('clear');
					$('#searchRoadName').textbox('clear');
					$('#searchMainBuildingNo').textbox('clear');
					
					$('#zipcodeDg').datagrid('loadData', {"total":0,"rows":[]});
				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$("#cifNo").textbox('textbox').attr('maxlength',12);
					$('#brnNo').textbox('textbox').attr('maxlength',4);
					$('#engFirstName').textbox('textbox').attr('maxlength',50);
					$('#engLastName').textbox('textbox').attr('maxlength',50);
					$('#korFirstName').textbox('textbox').attr('maxlength',50);
					$('#korLastName').textbox('textbox').attr('maxlength',50);
					$('#telNo').textbox('textbox').attr('maxlength',13);
					$('#cellNo').textbox('textbox').attr('maxlength',13);
					$('#zipCode').textbox('textbox').attr('maxlength',7);
					$('#orEngAddr1').textbox('textbox').attr('maxlength',65);
					$('#orEngAddr2').textbox('textbox').attr('maxlength',65);
					$('#orEngAddr3').textbox('textbox').attr('maxlength',65);
					$('#orEngAddr4').textbox('textbox').attr('maxlength',65);
					
					$("#searchCifNo").textbox('textbox').attr('maxlength',12);
					$("#searchBrnNo").textbox('textbox').attr('maxlength',50);
					$("#searchEngFirstName").textbox('textbox').attr('maxlength',50);
//					$("#searchKorName").textbox('textbox').attr('maxlength',50);

				}
				
				function setTextBoxCss(){

					// TEXTBOX 입력시 무조건 대문자화

				}
				
				function setTextBoxDisable(textBoxName){
					// Disable
					if(textBoxName=='all' || textBoxName=='cifNo'){
					  $('#cifNo').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='brnNo'){
					  $('#brnNo').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='residentCd'){
					  $('#residentCd').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='residentNo'){
					  $('#residentNo').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='engFirstName'){
					  $('#engFirstName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='engLastName'){
					  $('#engLastName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='korFirstName'){
					  $('#korFirstName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='korLastName'){
					  $('#korLastName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='habitationCd'){
					  $('#habitationCd').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='nationalCode'){
					  $('#nationalCode').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='telNo'){
					  $('#telNo').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='cellNo'){
					  $('#cellNo').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='zipCode'){
					  $('#zipCode').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='addr1'){
					  $('#addr1').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='addr2'){
					  $('#addr2').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='orCifFlag'){
					  $('#orCifFlag').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='orEngAddr1'){
					  $('#orEngAddr1').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='orEngAddr2'){
					  $('#orEngAddr2').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='orEngAddr3'){
					  $('#orEngAddr3').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='orEngAddr4'){
					  $('#orEngAddr4').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='staCd'){
					  $('#staCd').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='firstDate'){
					  $('#firstDate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='firstTime'){
					  $('#firstTime').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='lastDate'){
					  $('#lastDate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='lastTime'){
					  $('#lastTime').textbox('disable');
					}
					
					/*
					// SEARCH TEXTBOX
					if(textBoxName=='all' || textBoxName=='searchCifNo'){
						$("#searchCifNo").textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='searchBrnNo'){
						$("#searchBrnNo").textbox('disable');
					}
//					if(textBoxName=='all' || textBoxName=='searchKorName'){
//						$("#searchKorName").textbox('disable');
//					}
					if(textBoxName=='all' || textBoxName=='searchEngFirstName'){
						$("#searchEngFirstName").textbox('disable');
					}
					*/
				}
				
				function setTextBoxEnable(){
					// Enable
					$('#cifNo').textbox('enable');
					$('#brnNo').textbox('enable');
					$('#residentCd').textbox('enable');
					$('#residentNo').textbox('enable');
					$('#engFirstName').textbox('enable');
					$('#engLastName').textbox('enable');
					$('#korFirstName').textbox('enable');
					$('#korLastName').textbox('enable');
					$('#habitationCd').textbox('enable');
					$('#nationalCode').textbox('enable');
					$('#telNo').textbox('enable');
					$('#cellNo').textbox('enable');
					$('#zipCode').textbox('enable');
					$('#addr1').textbox('enable');
					$('#addr2').textbox('enable');
					$('#orCifFlag').textbox('enable');
					$('#orEngAddr1').textbox('enable');
					$('#orEngAddr2').textbox('enable');
					$('#orEngAddr3').textbox('enable');
					$('#orEngAddr4').textbox('enable');
					//$('#staCd').textbox('enable');
					//$('#firstDate').textbox('enable');
					//$('#firstTime').textbox('enable');
					//$('#lastDate').textbox('enable');
					//$('#lastTime').textbox('enable');
				}
				
				function getRawData(){
					rawData = new Object();
					rawData.cifNo 			= $('#cifNo').val();
					rawData.brnNo 			= $('#brnNo').val();
					rawData.residentCd  	= $('#residentCd').val();
					rawData.residentNo  	= $('#residentNo').val();
					rawData.engFirstName  	= $('#engFirstName').val();
					rawData.engLastName 	= $('#engLastName').val();
					rawData.korFirstName  	= $('#korFirstName').val();
					rawData.korLastName 	= $('#korLastName').val();
					rawData.habitationCd  	= $('#habitationCd').val();
					rawData.nationalCode 	= $('#nationalCode').val();
					rawData.telNo 			= $('#telNo').val();
					rawData.cellNo  		= $('#cellNo').val();
					rawData.zipCode 		= $('#zipCode').val();
					rawData.addr1 			= $('#addr1').val();
					rawData.addr2 			= $('#addr2').val();
					rawData.orCifFlag 		= $('#orCifFlag').val();
					rawData.orEngAddr1  	= $('#orEngAddr1').val();
					rawData.orEngAddr2  	= $('#orEngAddr2').val();
					rawData.orEngAddr3  	= $('#orEngAddr3').val();
					rawData.orEngAddr4  	= $('#orEngAddr4').val();
					rawData.staCd 			= $('#staCd').val();
					
					return rawData;
				}
				
					function checkValidation(){
					
					// 필수체크
					var residentNo = $('#residentNo').val();
					if(residentNo==''){
						showErrMsg('<font color=red>실명번호</font>는 필수 입력사항입니다.');
						return false;
					}

				}
				
				function searchData(){
					
					var searchCifNo = $('#searchCifNo').val();
					var searchBrnNo = $('#searchBrnNo').val();
					var searchEngFirstName = $('#searchEngFirstName').val();
					var searchCifNoLen = searchCifNo.length;
					var searchBrnNoLen = searchBrnNo.length;
					var searchEngFirstNameLen = searchEngFirstName.length;
					console.log("searchCifNo:"+searchCifNo);
					console.log("searchCifNo.length:"+searchCifNoLen);
					console.log("searchBrnNo:"+searchBrnNo);
					console.log("searchBrnNo.length:"+searchBrnNoLen);
					console.log("searchEngFirstName:"+searchEngFirstName);
					console.log("searchEngFirstName.length:"+searchEngFirstNameLen);
					
					var url = '${pageContext.request.contextPath}/rest/searchListCustomer?cifNo='+searchCifNo+'&brnNo='+searchBrnNo+'&engFirstName='+searchEngFirstName;
						
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
					$('#addr1').textbox('readonly',true);
					setMaxLength();
					
					setButtonDisable();
					setButtonEnable('initBtn');
					setButtonEnable('saveBtn');
					
					targetUrl="${pageContext.request.contextPath}/rest/customer";
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
						setTextBoxDisable('cifNo');
						setTextBoxDisable('firstDate');
						setTextBoxDisable('lastDate');
						$('#addr1').textbox('readonly',true);

					}
				}
				
				function saveData(){
					
					// 필수입력값 검증
					if(checkValidation()==false){
						return;
					}
					
					$.messager.confirm('Confirm','외환고객 정보를 저장하시겠습니까?',function(r){
						if (r){
							rawData = getRawData();
							console.log(JSON.stringify(rawData));
							
							targetUrl="${pageContext.request.contextPath}/rest/Customer";
							
							// 수정과 신규를 구분함
							if($('#firstDate').val()!=''){
								restfulType = "PUT";
							}else{
								restfulType = "POST";
							}

							console.log("rawData.cifNo="+rawData.cifNo);
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
					var selectedCifNo;
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$.messager.confirm('Confirm','외환고객 정보를 삭제하시겠습니까?',function(r){
							if (r){
								
								selectedCifNo = getSelectedValue('#dg', 'cifNo');	
								
								jQuery.ajax({
									type:"DELETE",
									url:"${pageContext.request.contextPath}/rest/Customer/" + selectedCifNo,
									contentType: 'application/json',
									dataType:"json",
									success:function(){
										//formClear();
										initData();
										$.messager.show({    // show error message
											title: 'Message',
											msg: '정상처리되었습니다.'
										});
										
										if($('#searchCifNo').val()==''){
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
				
				/** GRID FORMATTER **/
				function mergeKorName(val,row){
					console.log("korLastName:"+val+", row:"+row['korFirstName']);
					
					return val + row['korFirstName'];
				}
				function mergeEngName(val,row){
					console.log("engLastName:"+val+", row:"+row['engFirstName']);

					return val + " " + row['engFirstName'];
				}
				
				// TEXTBOX enter event
				$(document).ready(function(){

					// TEXTBOX에서 엔터 입력시 조회실행
					var t = $('#searchCifNo');
					t.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});

					var u = $('#searchBrnNo');
					u.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});

					var w = $('#searchEngFirstName');
					w.textbox('textbox').bind('keydown', function(e){
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
					$('#dg').datagrid({
						remoteSort: false,
						columns: [[
							{field:'cifNo',			title:'고객번호',			width:'15%',halign:'center', align:'center', 	sortable:true, 								sorter:sorter },
							{field:'brnNo',			title:'점번호',			width:'10%',halign:'center', align:'center', 	sortable:true, 								sorter:sorter },
							{field:'telNo',			title:'전화번호',			width:'10%',halign:'center', align:'center', 	sortable:true, 								sorter:sorter },
							{field:'korLastName',	title:'한글명',			width:'25%',halign:'center', align:'left', 		sortable:true,	formatter:mergeKorName, 	sorter:sorter },
							{field:'engLastName',	title:'고객영문명',			width:'25%',halign:'center', align:'left', 		sortable:true,	formatter:mergeEngName, 	sorter:sorter },
							{field:'orCifFlag',		title:'당발송금고객여부',		width:'15%',halign:'center', align:'center', 	sortable:true,								sorter:sorter }
						]]
					});
					
				   	$('#residentCd').combobox({
				   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=RESIDENT_CD',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '실명번호구분',
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
				   	
				   	$('#habitationCd').combobox({
				   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=HABITATION_CD',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '거주구분코드',
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
				   	
				   	$('#nationalCode').combobox({
				   		url:'${pageContext.request.contextPath}/rest/ctryCodeList',
						method:'get',
						valueField:'value',
						textField:'text',
						label: '국적',
						labelWidth: '130px',
						labelPosition: 'left',
						labelAlign: 'right',
						panelHeight:'auto',
				   		editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
				   	
				   	$('#orCifFlag').combobox({
				   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=OR_CIF_FLAG',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '당발송금고객여부',
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
					
					setInputDivSizeType2('close');
				   	zipcodeWindowClose();
				   	searchData();
				})
				
				window.onload = setTimeout(initData, 10);
				$('#main_content_div').css("display","block");
				
				
				var minHeight=700;
				var minWidth=970;
				var defaultInputDivHeight=410;
				var defaultGridDivHeight=300;
				var minGridDivHeight=150;
				
				
			</script>	
    
			<!-- END OF SCRIPT -->

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<!-- end of body-->
	</div>
</body>
</html>
