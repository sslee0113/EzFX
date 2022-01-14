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
							<div class="easyui-layout" data-options="fit:true" >
							
								<!-- GRID -->
								<div data-options="region:'center'" style="width:100%;padding:0px">
										<div id="input_div" title="패스워드 변경" style="position:relative;width:'auto';height:500px;padding:5px;" 
											data-options=" tools:[{ iconCls:'icon-clear',
																	handler:function(){
																		setInputDivSizeType2('open');
																	}}]">
								
											<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
												<div align="left" style="position:absolute;
																	    left:50%;
																	    top:50%;
																	    margin-left:-150px;
																	    margin-top:-80px;">
													<div style="display:none">
														<input id="accountSeq" name="accountSeq" class="easyui-numberbox" label="SEQ" labelWidth="125px" labelAlign="right" style="width:100%" />
													</div>
													<div style="margin-bottom:10px">
														<input id="userName" name="userName" class="easyui-textbox" label="사용자명" labelWidth="125px" labelAlign="right" style="width:370px" data-options="required:true,validType:'length[5,10]'" tabindex="1" />
													</div>
													<div style="margin-bottom:10px">
														<input id="password" name="password" class="easyui-passwordbox" label="수정할 암호" labelWidth="125px" labelAlign="right" style="width:370px" data-options="required:true,validType:'length[8,12]',prompt:'영문,숫자,특수문자를 모두 사용하세요.'" tabindex="3" />
													</div>
													<div style="margin-bottom:10px">
														<input id="password2" name="password2" class="easyui-passwordbox" label="확인" labelWidth="125px" labelAlign="right" style="width:370px" validType="confirmPass['#password']" data-options="required:true" tabindex="4" />
													</div>
													
												</div>
											</form>
										</div>
										<!-- end of 입력화면 -->
	
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
					
					return rawData;
				}
					
				function newData(){

					formClear();
					
					setTextBoxEnable();
					setMaxLength();
					
					setButtonDisable();
					setButtonEnable('editBtn');
					
					targetUrl="${pageContext.request.contextPath}/rest/userProfile";
					restfulType = "POST";
					
					// READONLY Enable
					$('#userName').textbox('readonly',false);
					
				}

				function editData(){
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
							
							targetUrl="${pageContext.request.contextPath}/rest/updatePassword";
							
							// 수정과 신규를 구분함
							if(rawData.accountSeq!=''){ 				// MODIFY
								targetUrl += "/"+rawData.accountSeq;
								restfulType = "PUT";
							}
							else{
								return;
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
				
				function checkValidation(){
					
					// 필수체크
					var userName = $('#userName').val();
					if(userName==''){
						showErrMsg('<font color=red>사용자명</font>은 필수 입력사항입니다.');
						return false;
					}
					var password = $('#password').val();
					if(password==''){
						showErrMsg('<font color=red>암호</font>는 필수 입력사항입니다.');
						return false;
					}
					var password2 = $('#password2').val();
					if(password2==''){
						showErrMsg('<font color=red>암호 확인란</font>은 필수 입력사항입니다.');
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
				
				// 2개의 암호가 동일한지 확인한다.
				$.extend($.fn.validatebox.defaults.rules, {
		            confirmPass: {
		                validator: function(value, param){
		                    var pass = $(param[0]).passwordbox('getValue');
		                    return value == pass;
		                },
		                message: '암호가 동일하지 않습니다. 입력 내용을 확인하세요'
		            }
		        })
				
				function formClear(){
					
					$('#password').textbox('clear');
					$('#password2').textbox('clear');
					
				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$("#userName").textbox('textbox').attr('maxlength',10);
					$("#password").textbox('textbox').attr('maxlength',12);
					$("#password2").textbox('textbox').attr('maxlength',12);

				}
				
				function setTextBoxCss(){

					// TEXTBOX 입력시 무조건 대문자화

				}
				
				function setTextBoxDisable(textBoxName){
					// Disable
					if(textBoxName=='all' || textBoxName=='userName'){
						$('#userName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='password'){
						$('#password').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='password2'){
						$('#password2').textbox('disable');
					}
				}
				
				function setTextBoxEnable(){
					// Disable
					$('#password').textbox('enable');
					$('#password2').textbox('enable');
				}
				
				function searchData(){
					
					var getAccountSeq="";
					var getUserName="";
					
					jQuery.ajax({
						type:'get',
						url: '${pageContext.request.contextPath}/rest/userProfileInfo',
						contentType: 'application/json',
						dataType:"json",
						success:function(data){
							
							getAccountSeq += data.accountSeq;
							getUserName += data.userName;
							
							$('#accountSeq').textbox('setValue',getAccountSeq);
							$('#userName').textbox('setValue',getUserName);
							setMaxLength();
							
							setButtonDisable();
							setButtonEnable('editBtn');
							setTextBoxDisable('userName');
					
						},
						error:function(request,status,error){
							
							chkSession(request, url);

						}
					});

				}
				
				// TEXTBOX enter event
				$(document).ready(function(){
					
				   	searchData();
				   	editData();
					
					$('#main_content').css('height',$(document).innerHeight()-170)
					setInputDivSizeType2('open');
				})

				//window.onload = setTimeout(initData, 500);
				$('#main_content_div').css("display","block");
				
				var minHeight=700;
				var minWidth=970;
				var defaultInputDivHeight=788;
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
