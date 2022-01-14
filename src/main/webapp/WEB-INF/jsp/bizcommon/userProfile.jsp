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
									<input id="searchUsername" name="searchUsername" class="easyui-textbox" label="사용자명" labelWidth="65px" labelAlign="right" style="width:200px" data-options="required:false" />
									
									<!-- 
									<select id="searchRole" name="searchRole" label="권한" class="easyui-combobox" labelWidth="45px" labelAlign="right" style="width:160px" data-options="panelHeight:50" >
										<option value="ROLE_ADMIN">ROLE_ADMIN</option>
										<option value="ROLE_USER">ROLE_USER</option>
									</select>
									 -->									
									<input id="searchRole" class="easyui-combobox" name="searchRole" style="width:250px;"/>
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
											<table id="dg" class="easyui-datagrid" style="width:100%;"
														url=""
														view="scrollview"
														method="get" toolbar="#toolbar" pagination="false"
														rownumbers="true" fitColumns="true" singleSelect="true">
														<!-- 
												<thead>
													<tr>
														<th field="accountSeq" width="6%" sortable="false" >SEQ</th>
														<th field="userName" width="13%" sortable="false" >사용자명</th>
														<th field="fullName" width="14%" sortable="false" >설명</th>
														<th field="role" width="11%" sortable="false" >권한</th>
														<th field="badCount" width="13%" sortable="false" >로그인 실패 횟수</th>
														<th field="whiteIp" width="12%" sortable="false" >허용IP</th>
														<th field="startDate" width="15%" sortable="false" >등록일</th>
														<th field="modifyDate" width="15%" sortable="false" >수정일</th>
														<th field="posCd" width="12%" sortable="false" >직급코드</th>
														<th field="userPos" width="12%" sortable="false" >직급명</th>
														<th field="superUser" width="12%" sortable="false" >최고책임자여부</th>
														<th field="brno" width="12%" sortable="false" >소속지점코드</th>
														<th field="offrId" width="12%" sortable="false" >책임자ID</th>
														<th field="telNo" width="12%" sortable="false" >전화번호</th>
														<th field="cellNo" width="12%" sortable="false" >핸드폰번호</th>
													</tr>
												</thead>
														 -->
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
													<div style="display:none">
														<input id="accountSeq" name="accountSeq" class="easyui-numberbox" label="SEQ" labelWidth="125px" labelAlign="right" style="width:100%" />
													</div>
													<div style="margin-bottom:10px">
														<input id="userName" name="userName" class="easyui-textbox" label="사용자명" labelWidth="125px" labelAlign="right" style="width:280px" data-options="required:true,validType:'length[5,10]'" tabindex="1" />
													</div>
													
													<div style="display:none">
														<input id="password" name="password" class="easyui-textbox"/>
													</div>
													
													<div style="margin-bottom:10px">
														<input id="tempPassword" name="tempPassword" class="easyui-textbox" label="암호" labelWidth="125px" labelAlign="right" style="width:250px" tabindex="2" />
														<a href="#" class="easyui-linkbutton" label="암호" labelWidth="125px" labelAlign="right" style="width:120px" onclick="getTempPw()">임시 비밀번호 발급</a>
													</div>									
													
													<div style="margin-bottom:10px">
														<input id="fullName" name="fullName" class="easyui-textbox" required="true" label="설명" labelWidth="125px" labelAlign="right" style="width:280px" tabindex="4" />
													</div>
													<!-- 
													<div style="margin-bottom:10px">
														<select class="easyui-combobox" id="role" name="role" label="권한" labelWidth="125px" labelAlign="right" style="width:240px" data-options="panelHeight:50" tabindex="5">
															<option value="ROLE_ADMIN">ROLE_ADMIN</option>
															<option value="ROLE_USER">ROLE_USER</option>
														</select>
													</div>
													 -->
													
													<div style="margin-bottom:10px">
														<input id="role" class="easyui-combobox" name="role" style="width:250px;"/>
													</div>
													
													<div style="margin-bottom:10px">
														<input id="whiteIp" name="whiteIp" class="easyui-textbox" required="true" label="허용IP" labelWidth="125px" labelAlign="right" style="width:240px" tabindex="6" />
													</div>
													<div style="margin-bottom:10px">
														<input id="posCd" name="posCd" class="easyui-textbox" label="직급코드" labelWidth="125px" labelAlign="right" style="width:200px" tabindex="7" />
													</div>
												</div>
												<div align="left" style="width:50%;float:left">
													<div style="margin-bottom:10px">
														<input id="userPos" name="userPos" class="easyui-textbox" label="직급명" labelWidth="125px" labelAlign="right" style="width:200px" tabindex="8" />
													</div>
													<div style="margin-bottom:10px">
														<select class="easyui-combobox" id="superUser" name="superUser" label="최고책임자여부" labelWidth="125px" labelAlign="right" style="width:180px" data-options="panelHeight:50" tabindex="9">
															<option value="Y">Y</option>
															<option value="N">N</option>
														</select>
													</div>
													<div style="margin-bottom:10px">
														<input id="brno" name="brno" class="easyui-textbox" label="소속지점코드" labelWidth="125px" labelAlign="right" style="width:200px" tabindex="10" />
													</div>
													<div style="margin-bottom:10px">
														<input id="offrId" name="offrId" class="easyui-textbox" label="책임자ID" labelWidth="125px" labelAlign="right" style="width:280px" tabindex="11" />
													</div>
													<div style="margin-bottom:10px">
														<input id="telNo" name="telNo" class="easyui-textbox" label="전화번호" labelWidth="125px" labelAlign="right" style="width:240px" tabindex="12" />
													</div>
													<div style="margin-bottom:10px">
														<input id="cellNo" name="cellNo" class="easyui-textbox" label="핸드폰번호" labelWidth="125px" labelAlign="right" style="width:240px" tabindex="13" />
													</div>
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
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/userProfile";
				var defaultRestfulType="POST";
				
				function getRawData(){
					rawData = new Object();
					rawData.accountSeq = $('#accountSeq').val();
					rawData.userName = $('#userName').val();
					rawData.password = $('#password').val();
					rawData.fullName = $('#fullName').val();
					rawData.role = $('#role').val();
					rawData.whiteIp = $('#whiteIp').val();
					rawData.brno = $('#brno').val();
					rawData.offrId = $('#offrId').val();
					rawData.telNo = $('#telNo').val();
					rawData.cellNo = $('#cellNo').val();
					rawData.superUser = $('#superUser').val();
					rawData.posCd = $('#posCd').val();
					rawData.userPos = $('#userPos').val();
					
					return rawData;
				}
					
				function newData(){

					formClear();
					
					setTextBoxEnable();
					setTextBoxDisable('firstDate');
					setTextBoxDisable('lastDate');
					setMaxLength();
					console.log("newData");
					setButtonDisable();
					setButtonEnable('initBtn');
					setButtonEnable('saveBtn');
					
					targetUrl="${pageContext.request.contextPath}/rest/userProfile";
					restfulType = "POST";
					
					// READONLY Enable
					$('#userName').textbox('readonly',false);
					
				}

				function editData(){
					
					setButtonDisable();
					setButtonEnable('initBtn');
					setButtonEnable('editBtn');
					setButtonEnable('cancelBtn');
					
					setTextBoxEnable();
					setTextBoxDisable('userName');
					setTextBoxDisable('tempPassword');
					
					$('#tempPassword').textbox('textbox').parent().hide();

					var row = $('#dg').datagrid('getSelected');
					if (row){
						$('#fm').form('load',row);
					}
				}   
				
				function saveData(){
					
					// 필수입력값 검증
					if(checkValidation()==false){
						return;
					}
					
					$.messager.confirm('Confirm','사용자를 저장하시겠습니까?',function(r){
						if (r){
							rawData = getRawData();
							console.log(JSON.stringify(rawData));
							
							targetUrl="${pageContext.request.contextPath}/rest/userProfile";
							
							// 수정과 신규를 구분함
							if(rawData.accountSeq==''){ 				// NEW
								restfulType = "POST";
							}else{								// MODIFY
								targetUrl += "/"+rawData.accountSeq;
								restfulType = "PUT";
							}

							console.log("rawData.accountSeq="+rawData.accountSeq);
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
					var selectedSeq;
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$.messager.confirm('Confirm','사용자를 삭제하시겠습니까?',function(r){
							if (r){
								
								selectedSeq = getSelectedValue('#dg', 'accountSeq');	
								
								jQuery.ajax({
									type:"DELETE",
									url:"${pageContext.request.contextPath}/rest/userProfile/" + selectedSeq,
									dataType : 'text',
									success:function(){
										//formClear();
										initData();
										$.messager.show({    // show error message
											title: 'Message',
											msg: '정상처리되었습니다.'
										});
										
										$('#dg').datagrid('reload');    // reload the user data
									},
								    error:function(request,status,error){
									//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
				
				function checkValidation(){
					
					// 필수체크
					var userName = $('#userName').val();
					if(userName==''){
						showErrMsg('<font color=red>사용자명</font>은 필수 입력사항입니다.');
						return false;
					}
					
					var fullName = $('#fullName').val();
					if(fullName==''){
						showErrMsg('<font color=red>설명</font>은 필수 입력사항입니다.');
						return false;
					}
					var whiteIp = $('#whiteIp').val();
					if(whiteIp==''){
						showErrMsg('<font color=red>허용IP</font>는 필수 입력사항입니다.');
						return false;
					}
					var whiteIp = $('#whiteIp').val();
					if(whiteIp==''){
						showErrMsg('<font color=red>허용IP</font>는 필수 입력사항입니다.');
						return false;
					}

				}
				
				function getSelectedValue(dg, field){
				    var dg = $(dg);
				    var row = dg.datagrid('getSelected');
				    if (!row){return undefined;}
				    var fields = dg.datagrid('getColumnFields',true).concat(dg.datagrid('getColumnFields',false));
				    if (typeof field == 'number'){
				        return row[fields[field]];
				    } else {
				        return row[field];
				    }
				}
				
				function formClear(){
					
					$('#accountSeq').textbox('clear');
					$('#userName').textbox('clear');
					$('#password').textbox('clear');
					$('#tempPassword').textbox('clear');
					$('#fullName').textbox('clear');
					$('#role').textbox('setValue','ROLE_ADMIN');
					$('#whiteIp').textbox('clear');
					$('#posCd').textbox('clear');
					$('#userPos').textbox('clear');
					$('#superUser').textbox('setValue','N');
					$('#brno').textbox('clear');
					$('#offrId').textbox('clear');
					$('#telNo').textbox('clear');
					$('#cellNo').textbox('clear');
					setTextBoxEnable();
					$('#tempPassword').textbox('readonly', true);
					$('#tempPassword').textbox('textbox').parent().show();
				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$("#userName").textbox('textbox').attr('maxlength',10);
					$("#password").textbox('textbox').attr('maxlength',12);
					$("#tempPassword").textbox('textbox').attr('maxlength',12);

				}
				
				function setTextBoxCss(){

					// TEXTBOX 입력시 무조건 대문자화

				}
				
				function setTextBoxDisable(textBoxName){
					// Disable
					if(textBoxName=='all' || textBoxName=='accountSeq'){
						$('#accountSeq').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='userName'){
						$('#userName').textbox('disable');
					}
					
					if(textBoxName=='all' || textBoxName=='password'){
						$('#password').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='tempPassword'){
						$('#tempPassword').textbox('disable');
					}
					
				}
				
				function setTextBoxEnable(){
					// Disable
					$('#accountSeq').textbox('enable');
					$('#userName').textbox('enable');
					$('#password').textbox('enable');
					$('#tempPassword').textbox('enable');
				}
				
				function searchData(){
				
					var searchUsername = $('#searchUsername').val();
					var searchRole = $('#searchRole').val();
					var searchUsernameLen = searchUsername.length;
					var searchRoleLen = searchRole.length;
					var	url = '${pageContext.request.contextPath}/rest/userProfile?userName='+ searchUsername + '&role='+ searchRole;
					
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
				
				function getTempPw(){
					$.messager.confirm('Confirm','임시 비밀번호를 발급하시겠습니까?',function(r){
						if (r){
							var pw="";
							var num = ['1','2','3','4','5','6','7','8','9','0'];
							var abc = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
			                var spe = ['!','@','#','$','%','^','&','*'];
							pw+=abc[ Math.floor(Math.random() * abc.length)];
							pw+=spe[ Math.floor(Math.random() * spe.length)];
							pw+=num[ Math.floor(Math.random() * num.length)];
							pw+=abc[ Math.floor(Math.random() * abc.length)];
							pw+=abc[ Math.floor(Math.random() * abc.length)];
							pw+=abc[ Math.floor(Math.random() * abc.length)];
							pw+=num[ Math.floor(Math.random() * num.length)];
							pw+=num[ Math.floor(Math.random() * num.length)];
							pw+=num[ Math.floor(Math.random() * num.length)];
							$('#password').textbox('setValue', pw);
							$('#tempPassword').textbox('setValue', pw);
							$('#tempPassword').textbox('textbox').parent().show();
							setTextBoxEnable();
							if($('#accountSeq').val() != ''){
								setTextBoxDisable('userName');
							}
						}
						else{
							return ;
						}
					});
				}
				
				// TEXTBOX enter event
				$(document).ready(function(){

					// TEXTBOX에서 엔터 입력시 조회실행
					var t = $('#searchUsername');
					t.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});
					
					// GRID Double Click Event
				   	$('#dg').datagrid({
						onDblClickRow: function(index,row){
							editData();
							console.log("accountSeq : " + $('#accountSeq').val());
						},
						onClickRow: function(index,row){
							editData();
						}
					})
					
					// SORTER
					
					$('#dg').datagrid({
						remoteSort: false,
						columns: [[
							{field:'accountSeq',title:'SEQ',		width:'6%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'userName',	title:'사용자명',		width:'13%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'fullName',	title:'설명',			width:'14%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'role',		title:'권한',			width:'11%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'badCount',	title:'로그인 실패 횟수',	width:'13%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'whiteIp',	title:'허용IP',		width:'12%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'startDate',	title:'등록일',		width:'15%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'modifiyDate',title:'수정일',		width:'15%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'posCd',		title:'직급코드',		width:'12%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'userPos',	title:'직급명',		width:'12%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'superUser',	title:'최고책임자여부',	width:'12%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'brno',		title:'소속지점코드',	width:'12%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'offrId',	title:'책임자ID',		width:'12%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'telNo',		title:'전화번호',		width:'12%',sortable:true,halign:'center', align:'center', sorter:sorter },
							{field:'cellNo',	title:'핸드폰번호',		width:'12%',sortable:true,halign:'center', align:'center', sorter:sorter },
							]]
					});
					
				   	$('#superUser').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
					 	
				   	$('#searchRole').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
				   	
				   	$('#role').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
				   	
				   	$('#searchRole').combobox({
				   	    url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=ROLE_CD',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcode',
						label: '권한',
						labelWidth: '125px',
						labelPosition: 'left',
						labelAlign: 'right',
						panelHeight: 'auto'
				   	});
				   	
				   	$('#role').combobox({
				   	    url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=ROLE_CD',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcode',
						label: '권한',
						labelWidth: '125px',
						labelPosition: 'left',
						labelAlign: 'right',
						required: 'true',
						panelHeight: 'auto'
				   	});
				   	
				   	searchData();
					
					$('#main_content').css('height',$(document).innerHeight()-170)
					setInputDivSizeType2('open');
				})

				window.onload = setTimeout(initData, 500);
				$('#main_content_div').css("display","block");
				
				var minHeight=700;
				var minWidth=970;
				var defaultInputDivHeight=400;
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
