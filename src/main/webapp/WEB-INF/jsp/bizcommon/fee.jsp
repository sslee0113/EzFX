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
						<div id="searchCondition" class="easyui-panel" title="검색조건" style="width:100%	;height:100px;padding:7px;">
							<div style="width:100%'">
								<div align="left" style="width:85%;float:left">
									<input id="searchRmtKdcd" class="easyui-combobox" name="searchRmtKdcd" style="width:160px;" tabindex="1"/>
									
									<input id="searchNtcd" class="easyui-combobox" name="searchNtcd" style="width:120px;" tabindex="2" 
														data-options=" url:'${pageContext.request.contextPath}/rest/ctryCodeList',
																		method:'get',
																		valueField:'value',
																		textField:'text',
																		label: '국가코드',
																		labelWidth: '65px',
																		labelPosition: 'left',
																		labelAlign: 'right',
																		required: 'true',
																		panelHeight: 122
																		" />
									<input id="searchCrcd" class="easyui-combobox" name="searchCrcd" style="width:130px;" tabindex="3"
														data-options=" url:'${pageContext.request.contextPath}/rest/currCodeList',
															method:'get',
															valueField:'value',
															textField:'text',
															label: '통화코드',
															labelWidth: '65px',
															labelPosition: 'left',
															labelAlign: 'right',
															required: 'true',
															panelHeight: 122
															" />
								</div>
								<!--
								<div align="right" style="width:14%;float:right">
									<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
								</div>
								-->
							</div>
							<div class="easyui-layout" style="width:99%;height:2px"></div>
							<div style="width:85%;float:left">
								<div style="margin-bottom:2px">
									<input id="searchAplStrtDt" name="searchAplStrtDt" class="easyui-datebox" label="적용시작일자" labelWidth="90px" labelAlign="right" style="width:190px" data-options="required:false,formatter:myformatter,parser:myparser" tabindex="4"/>
									~
									<input id="searchAplEndDt" name="searchAplEndDt" class="easyui-datebox" label="적용종료일자" labelWidth="90px" labelAlign="right" style="width:190px" data-options="required:false,formatter:myformatter,parser:myparser" tabindex="5" />
									<input id="searchAplStrtAmt" name="searchAplStrtAmt" class="easyui-numberbox" label="대상금액(시작)" labelWidth="100px" labelAlign="right" style="width:150px;text-align:right" data-options="required:false,groupSeparator:','" tabindex="6"/>
									~
									<input id="searchAplEndAmt" name="searchAplEndAmt" class="easyui-numberbox" label="대상금액(종료)" labelWidth="100px" labelAlign="right" style="width:150px;text-align:right" data-options="required:false,groupSeparator:','" tabindex="7"/>
								</div>
							</div>
							<div align="right" style="width:14%;float:right">
								<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
							</div>
						</div>	
						<div class="easyui-layout" data-options="fit:true" >
						
							<!-- GRID -->
							<div data-options="region:'center'" style="width:100%;padding:0px">
							
								<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">

									<div id="grid_div" title="검색결과" style="overflow:auto;padding:5px;width:'auto';height:670px;doSize:true;">
										<table id="dg" class="easyui-datagrid" style="width:100%;"
													url = ""
													view="scrollview"
													method="get" toolbar="#toolbar" pagination="false"
													rownumbers="true" fitColumns="true" singleSelect="true">
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
													<input id="rmtKdcd" class="easyui-combobox" name="rmtKdcd" style="width:230px;" tabindex="8"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="crcd" class="easyui-combobox" name="crcd" style="width:200px;" tabindex="10"
														data-options=" url:'${pageContext.request.contextPath}/rest/ctryCurrCodeList',
																		method:'get',
																		valueField:'value',
																		textField:'text',
																		label: '통화코드',
																		labelWidth: '130px',
																		labelPosition: 'left',
																		labelAlign: 'right',
																		required: 'true',
																		panelHeight: 122
																		" />
												</div>
												<div style="margin-bottom:2px">
													<input id="aplStrtAmt" name="aplStrtAmt" class="easyui-numberbox" label="대상금액" labelWidth="130px" labelAlign="right" style="width:220px;text-align:right" data-options="required:false,groupSeparator:','" tabindex="12"/>
													~
													<input id="aplEndAmt" name="aplEndAmt" class="easyui-numberbox" style="width:90px;text-align:right" data-options="required:false,groupSeparator:','" tabindex="13"/>
												</div>
											</div>
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="ntcd" class="easyui-combobox" name="ntcd" style="width:190px;" tabindex="9" 
														data-options=" url:'${pageContext.request.contextPath}/rest/ctryCodeList',
																		method:'get',
																		valueField:'value',
																		textField:'text',
																		label: '국가코드',
																		labelWidth: '130px',
																		labelPosition: 'left',
																		labelAlign: 'right',
																		required: 'true',
																		panelHeight: 122
																		" />
												</div>
												<div style="margin-bottom:2px">
													<input id="aplStrtDt" name="aplStrtDt" class="easyui-datebox" label="적용일자" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:false,formatter:myformatter,parser:myparser" tabindex="10" />
													~
													<input id="aplEndDt" name="aplEndDt" class="easyui-datebox" style="width:100px" data-options="required:false,formatter:myformatter,parser:myparser" tabindex="11" />
												</div>
												<div style="margin-bottom:2px">
													<input id="feeCrcd" class="easyui-combobox" name="feeCrcd" style="width:200px;" tabindex="14"
															data-options=" url:'${pageContext.request.contextPath}/rest/currCodeList',
																method:'get',
																valueField:'value',
																textField:'text',
																label: '통화코드',
																labelWidth: '130px',
																labelPosition: 'left',
																labelAlign: 'right',
																required: 'true',
																panelHeight: 122
																" />
													<input id="feeAmt" name="feeAmt" class="easyui-numberbox" style="width:90px;text-align:right" data-options="required:false,groupSeparator:','" tabindex="15"/>
												</div>
											</div>
											<div align="left" style="width:100%;height:10px">
												&nbsp;
											</div>
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="firstDate" name="firstDate" class="easyui-textbox" label="최초등록일자" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="16"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="firstTime" name="firstTime" class="easyui-textbox" label="최초등록시간" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="18"/>
												</div>
											</div>
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="lastDate" name="lastDate" class="easyui-textbox" label="최종변경일자" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="17"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="lastTime" name="lastTime" class="easyui-textbox" label="최종변경시간" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="19"/>
												</div>
											</div>
											<div style="margin-bottom:2px;display:none">
												<input id="feeCd" name="feeCd" class="easyui-textbox" label="수수료코드" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="20"/>
											</div>
											
											<!--
											<div style="margin-bottom:2px;display:none">
												<select class="easyui-combobox" id="staCd" name="staCd" label="상태구분코드:" labelWidth="130px" labelAlign="right" style="width:200px;" data-options="panelHeight:50">
													<option value="0">정상</option>
													<option value="9">취소</option>
												</select>
											</div>
											-->
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
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/Fee";
				var defaultRestfulType="POST";
				
				function formClear(){
					
					$('#feeCd').textbox('clear');
					$('#rmtKdcd').combobox('setValue', '1');
					$('#ntcd').textbox('clear');
					$('#crcd').textbox('clear');
					$('#aplStrtDt').textbox('clear');
					$('#aplEndDt').textbox('clear');
					$('#aplStrtAmt').textbox('clear');
					$('#aplEndAmt').textbox('clear');
					$('#feeCrcd').textbox('setValue', 'KRW');
					$('#feeAmt').textbox('clear');
//					$('#firstUserId').textbox('clear');
					$('#firstDate').textbox('clear');
					$('#firstTime').textbox('clear');
//					$('#lastUserId').textbox('clear');
					$('#lastDate').textbox('clear');
					$('#lastTime').textbox('clear');
					
					$('#searchRmtKdcd').combobox('setValue', '1');
					$('#searchNtcd').textbox('clear');
					$('#searchCrcd').textbox('clear');
					$('#searchAplStrtDt').textbox('clear');
					$('#searchAplEndDt').textbox('clear');
					$('#searchAplStrtAmt').textbox('clear');
					$('#searchAplEndAmt').textbox('clear');

				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$("#aplStrtAmt").textbox('textbox').attr('maxlength', 10);
					$("#aplEndAmt").textbox('textbox').attr('maxlength', 10);
					$("#feeAmt").textbox('textbox').attr('maxlength', 10);

				}
				
				function setTextBoxCss(){

					// TEXTBOX 입력시 무조건 대문자화
					$('#ntcd').textbox('textbox').css('text-transform','uppercase');
					$('#crcd').textbox('textbox').css('text-transform','uppercase');
					$('#feeCrcd').textbox('textbox').css('text-transform','uppercase');

				}
				
				function setTextBoxDisable(textBoxName){
					if(textBoxName=='all' || textBoxName=='rmtKdcd'){
					  $('#rmtKdcd').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='ntcd'){
					  $('#ntcd').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='crcd'){
					  $('#crcd').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='aplStrtDt'){
					  $('#aplStrtDt').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='aplEndDt'){
					  $('#aplEndDt').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='aplStrtAmt'){
					  $('#aplStrtAmt').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='aplEndAmt'){
					  $('#aplEndAmt').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='feeCrcd'){
					  $('#feeCrcd').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='feeAmt'){
					  $('#feeAmt').textbox('disable');
					}
//					if(textBoxName=='all' || textBoxName=='firstUserId'){
//					  $('#firstUserId').textbox('disable');
//					}
					if(textBoxName=='all' || textBoxName=='firstDate'){
					  $('#firstDate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='firstTime'){
					  $('#firstTime').textbox('disable');
					}
//					if(textBoxName=='all' || textBoxName=='lastUserId'){
//					  $('#lastUserId').textbox('disable');
//					}
					if(textBoxName=='all' || textBoxName=='lastDate'){
					  $('#lastDate').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='lastTime'){
					  $('#lastTime').textbox('disable');
					}
				}
				
				function setTextBoxEnable(){
					$('#rmtKdcd').textbox('enable');
					$('#ntcd').textbox('enable');
					$('#crcd').textbox('enable');
					$('#aplStrtDt').textbox('enable');
					$('#aplEndDt').textbox('enable');
					$('#aplStrtAmt').textbox('enable');
					$('#aplEndAmt').textbox('enable');
					$('#feeCrcd').textbox('enable');
					$('#feeAmt').textbox('enable');
				}
				
				function getRawData(){
					rawData = new Object();
					rawData.feeCd = $('#feeCd').val();
					rawData.rmtKdcd = $('#rmtKdcd').val();
					rawData.ntcd = $('#ntcd').val().toUpperCase();
					rawData.crcd = $('#crcd').val().toUpperCase();
					rawData.aplStrtDt = $('#aplStrtDt').val().replace(/-/g, '');
					rawData.aplEndDt = $('#aplEndDt').val().replace(/-/g, '');
					rawData.aplStrtAmt = $('#aplStrtAmt').val();
					rawData.aplEndAmt = $('#aplEndAmt').val();
					rawData.feeCrcd = $('#feeCrcd').val().toUpperCase();
					rawData.feeAmt = $('#feeAmt').val();
					
					return rawData;
				}
				
				function searchData(){
					
					var searchRmtKdcd = $('#searchRmtKdcd').val();
					var searchNtcd = $('#searchNtcd').val();
					var searchCrcd = $('#searchCrcd').val();
					var searchAplStrtDt = $('#searchAplStrtDt').val().replace(/-/g, '');
					var searchAplEndDt = $('#searchAplEndDt').val().replace(/-/g, '');
					var searchAplStrtAmt = $('#searchAplStrtAmt').val();
					var searchAplEndAmt = $('#searchAplEndAmt').val();

					var searchRmtKdcdLength = searchRmtKdcd.length;
					var searchNtcdLength = searchNtcd.length;
					var searchCrcdLength = searchCrcd.length;
					var searchAplStrtDtLength = searchAplStrtDt.length;
					var searchAplEndDtLength = searchAplEndDt.length;
					var searchAplStrtAmtLength = searchAplStrtAmt.length;
					var searchAplEndAmtLength = searchAplEndAmt.length;
					
					console.log("searchRmtKdcd: " + searchRmtKdcd);
					console.log("searchNtcd: " + searchNtcd);
					console.log("searchCrcd: " + searchCrcd);
					console.log("searchAplStrtDt: " + searchAplStrtDt);
					console.log("searchAplEndDt: " + searchAplEndDt);
					console.log("searchAplStrtAmt: " + searchAplStrtAmt);
					console.log("searchAplEndAmt: " + searchAplEndAmt);
					
					if(searchAplStrtAmt == '' && searchAplEndAmt == '' || searchAplStrtAmt != '' && searchAplEndAmt != ''){
						
						if(eval(searchAplStrtAmt) > eval(searchAplEndAmt)){
							showErrMsg("<font color=red>적용종료금액</font>은 <font color=red>적용시작금액</font>보다 값이 커야합니다.");
							return false;
						}
						
						var url = '${pageContext.request.contextPath}/rest/searchListFee?rmtKdcd='+searchRmtKdcd+'&ntcd='+searchNtcd+'&crcd='+searchCrcd+'&aplStrtDt='+searchAplStrtDt+'&aplEndDt='+searchAplEndDt+'&aplStrtAmt='+searchAplStrtAmt+'&aplEndAmt='+searchAplEndAmt;
							
						$('#dg').datagrid({
							url:url,
							onLoadSuccess:function(){
								
								var rows = $('#dg').datagrid('getRows').length; 
								if(rows==0){
									
									showErrMsg('조회 결과가 없습니다. 입력값을 확인하세요');
								}
								
								setButtonDisable();
								setButtonEnable('initBtn');
								setButtonEnable('saveBtn');
								
							},
							onLoadError:function(){
								
								showErrMsg('조회 중 에러가 발생했습니다.');
							}
						});
					}
					else{
						showErrMsg('대상금액 범위를 입력해주세요.');
						return false;
					}
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
					
					targetUrl="${pageContext.request.contextPath}/rest/Fee";
					restfulType = "POST";
					
				}

				function editData(){

					setButtonDisable();
					setButtonEnable('initBtn');
					setButtonEnable('editBtn');
					setButtonEnable('cancelBtn');
					
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$('#fm').form('load',row);
					}
				}
				
				function saveData(){
					
					$.messager.confirm('Confirm','송금수수료를 저장하시겠습니까?',function(r){
						
						// 필수입력값 검증
						if(checkValidation()==false){
							return;
						}
						
						if (r){
							rawData = getRawData();
							console.log(JSON.stringify(rawData));
							
							targetUrl="${pageContext.request.contextPath}/rest/Fee";
							
							// 수정과 신규를 구분함
							if($('#firstDate').val()!=''){
								restfulType = "PUT";
							}else{
								restfulType = "POST";
							}

							jQuery.ajax({
								type:restfulType,
								url:targetUrl,
								contentType: 'application/json',
								data: JSON.stringify(rawData),
								dataType:"json",
								success:function(){
									$('#dg').datagrid('reload');    // reload the user data

									initData();

									showInfMsg('정상처리되었습니다.');
								},
								error:function(request,status,error){
									
									showErrMsg(getPureErrMsg(request));
								}    		
							});	
						}
					});
				}

				function cancelData(){

				}
				
				function checkValidation(){
					
					// 필수체크
					var rmtKdcd = $('#rmtKdcd').val();
					if(rmtKdcd==''){
						showErrMsg('<font color=red>송금종류코드</font>는 필수 선택사항입니다.');
						return false;
					}
					
					var ntcd = $('#ntcd').val();
					if(ntcd==''){
						showErrMsg('<font color=red>국가코드</font>는 필수 선택사항입니다.');
						return false;
					}
					
					var crcd = $('#crcd').val();
					if(crcd==''){
						showErrMsg('<font color=red>통화코드</font>는 필수 선택사항입니다.');
						return false;
					}
					
					var aplStrtDt = $('#aplStrtDt').val();
					if(aplStrtDt==''){
						showErrMsg('<font color=red>적용시작일자</font>는 필수 입력사항입니다.');
						return false;
					}
					
					var aplEndDt = $('#aplEndDt').val();
					if(aplEndDt==''){
						showErrMsg('<font color=red>적용종료일자</font>는 필수 입력사항입니다.');
						return false;
					}
					
					var aplStrtAmt = $('#aplStrtAmt').val();
					if(aplStrtAmt==''){
						showErrMsg('<font color=red>적용시작금액</font>은 필수 입력사항입니다.');
						return false;
					}
					
					var aplEndAmt = $('#aplEndAmt').val();
					if(aplEndAmt==''){
						showErrMsg('<font color=red>적용종료금액</font>은 필수 입력사항입니다.');
						return false;
					}
					if(eval(aplStrtAmt) > eval(aplEndAmt)){
						showErrMsg("<font color=red>적용종료금액</font>은 <font color=red>적용시작금액</font>보다 값이 커야합니다.");
						return false;
					}
					
					var feeCrcd = $('#feeCrcd').val();
					if(feeCrcd==''){
						showErrMsg('<font color=red>수수료통화</font>는 필수 선택사항입니다.');
						return false;
					}
					var feeAmt = $('#feeAmt').val();
					if(feeAmt==''){
						showErrMsg('<font color=red>수수료금액</font>은 필수 입력사항입니다.');
						return false;
					}

				}
				
				function commonCode(){
					
					$('#searchRmtKdcd').combobox({
				   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=RMT_KDCD',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '송금종류',
						labelWidth: '65px',
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
					
					$('#searchNtcd').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
				   	
				   	$('#searchCrcd').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
					
					$('#rmtKdcd').combobox({
				   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=RMT_KDCD',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '송금종류',
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
					
					
				}
				
				// TEXTBOX enter event
				$(document).ready(function(){

					// TEXTBOX에서 엔터 입력시 조회실행
					var t = $('#searchAplStrtAmt');
					t.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});
					
					var u = $('#searchAplEndAmt');
					u.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});

					// GRID Double Click Event
				   	$('#dg').datagrid({
						onDblClickRow: function(index,row){
							setInputDivSizeType2('open2');
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
							{field:'rmtKdcd',	title:'송금종류코드',	width:'11%',sortable:true,halign:'center', align:'center', 								sorter:sorter },
							{field:'rmtKdcdName',title:'송금종류코드',	width:'11%',sortable:true,halign:'center', align:'center', 								sorter:sorter },
							{field:'ntcd',		title:'국가코드',		width:'11%',sortable:true,halign:'center', align:'center',  							sorter:sorter },
							{field:'crcd',		title:'통화코드',		width:'11%',sortable:true,halign:'center', align:'center',  							sorter:sorter },
							{field:'aplStrtDt',	title:'적용시작일자',	width:'11%',sortable:true,halign:'center', align:'center', 	formatter:formatDate, 		sorter:sorter },
							{field:'aplEndDt',	title:'적용종료일자',	width:'11%',sortable:true,halign:'center', align:'center', 	formatter:formatDate, 		sorter:sorter },
							{field:'aplStrtAmt',title:'적용시작금액',	width:'11%',sortable:true,halign:'center', align:'right', 	formatter:formatDecimal, 	sorter:sorter },
							{field:'aplEndAmt',	title:'적용종료금액',	width:'11%',sortable:true,halign:'center', align:'right', 	formatter:formatDecimal, 	sorter:sorter },
							{field:'feeCrcd',	title:'수수료통화',		width:'11%',sortable:true,halign:'center', align:'center',  							sorter:sorter },
							{field:'feeAmt',	title:'수수료금액',		width:'12%',sortable:true,halign:'center', align:'right', 	formatter:formatDecimal, 	sorter:sorter }
						]]
					});
				   	$('#dg').datagrid('hideColumn', 'rmtKdcd');
				   	
					commonCode();
				   	
				   	$('#ntcd').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
				   	
				   	$('#searchCrcd').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
				   	
				   	$('#crcd').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
				   	
				   	$('#feeCrcd').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
					
					$('#main_content').css('height',$(document).innerHeight()-170)
					
					setInputDivSizeType2('close2');
				   	zipcodeWindowClose();
				   	searchData();
				})
				
				window.onload = setTimeout(initData, 10);
				$('#main_content_div').css("display","block");
				
				
				var minHeight=700;
				var minWidth=970;
				var defaultInputDivHeight=300;
				var defaultGridDivHeight=200;
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
