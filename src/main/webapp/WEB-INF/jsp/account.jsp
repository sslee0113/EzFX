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

		<div class="header">
			<%@ include file="/WEB-INF/jsp/header/header.jsp"%>
		</div>

		<div id="main_content_div" class="main_content">

			<div class="center_content">

	<div class="easyui-layout" style="width:100%;height:550px;">
		<!--
        <div data-options="region:'north'" style="height:50px"></div>
        <div data-options="region:'south',split:true" style="height:50px;"></div>
        <div data-options="region:'east',split:true" title="East" style="width:100px;"></div>
        -->
        <div data-options="region:'west',split:true" title="메뉴" style="width:200px;">
			<%@ include file="/WEB-INF/jsp/menu/menu.jsp"%>
        </div>
        <div data-options="region:'center',title:'공통',iconCls:'icon-ok'" >
			<table id="dg" title="사용자 관리" class="easyui-datagrid" style="width:100%;height:100%"
							url="${pageContext.request.contextPath}/rest/account"
							method="get"
							toolbar="#toolbar" pagination="true"
							rownumbers="true" fitColumns="true" singleSelect="true">
							<thead>
								<tr>
									<th field="seq" width="30" sortable="false" >SEQ</th>
									<th field="username" width="100" sortable="false" >사용자명</th>
									<th field="fullname" width="140" sortable="false" >설명</th>
									<th field="role" width="90" sortable="false" >권한</th>
									<th field="badcount" width="70" sortable="false" >로그인 실패 횟수</th>
									<th field="whiteip" width="60" sortable="false" >허용IP</th>
									<th field="startdate" width="100" sortable="false" >등록일</th>
									<th field="modifydate" width="100" sortable="false" >수정일</th>
								</tr>
							</thead>
						</table>
						<div id="toolbar">
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">사용자 추가</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">사용자 수정</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">사용자 삭제</a>
						</div>
						
						<div id="dlg" class="easyui-dialog" style="width:500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
							<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
								<div style="display:none">
									<input id="seq" name="seq" class="easyui-textbox" label="SEQ:" style="width:100%" />
								</div>
								<div style="margin-bottom:10px">
									<input id="username" name="username" class="easyui-textbox" label="사용자명:" style="width:100%" data-options="required:true,validType:'length[5,10]'" />
								</div>
								<div style="margin-bottom:10px">
									<input id="password" name="password" class="easyui-passwordbox" label="암호:" style="width:100%" data-options="required:true,validType:'length[8,12]',prompt:'영문,숫자,특수문자를 모두 사용하세요.'" />
								</div>
								<div style="margin-bottom:10px">
									<input id="password2" name="password2" class="easyui-passwordbox" label="확인:" style="width:100%" validType="confirmPass['#password']" data-options="required:true" />
								</div>
								<div style="margin-bottom:10px">
									<input id="fullname" name="fullname" class="easyui-textbox" required="true" label="설명:" style="width:100%" />
								</div>
								<div style="margin-bottom:10px">
									<select class="easyui-combobox" id="role" name="role" label="역할:" style="width:100%">
										<option value="ROLE_ADMIN">ROLE_ADMIN</option>
										<option value="ROLE_USER">ROLE_USER</option>
									</select>
								</div>
								<div style="margin-bottom:10px">
									<input id="whiteip" name="whiteip" class="easyui-textbox" required="true" label="허용IP:" style="width:100%" />
								</div>
							</form>
						</div>
						<div id="dlg-buttons">
							<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">Save</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">Cancel</a>
						</div>
						<script type="text/javascript">
							var url;
							var rawData;
							function getRawData(){
								rawData = new Object();
								rawData.seq = $('#seq').val();
								rawData.username = $('#username').val();
								rawData.password = $('#password').val();
								rawData.fullname = $('#fullname').val();
								rawData.role = $('#role').val();
								rawData.whiteip = $('#whiteip').val();	
							}

							function newUser(){
								$('#dlg').dialog('open').dialog('center').dialog('setTitle','사용자 추가');
								$('#fm').form('clear');
								url = '${pageContext.request.contextPath}/rest/account';
								type = 'POST';
								method = 'POST';
								contentType ='application/json';
								dataType = "json";
								
								// READONLY Enable
								$('#username').textbox('readonly',false);
							}

							function editUser(){
								var row = $('#dg').datagrid('getSelected');
								if (row){
									$('#dlg').dialog('open').dialog('center').dialog('setTitle','사용자 수정');
									$('#fm').form('load',row);

									// READONLY Disable
									$('#username').textbox('readonly',true);
								}
							}
								
							function saveUser(){
								
								var restfulType,targetUrl,param;
								/*
								var rawData = new Object();
								rawData.seq = $('#seq').val();
								rawData.username = $('#username').val();
								rawData.password = $('#password').val();
								rawData.fullname = $('#fullname').val();
								rawData.role = $('#role').val();
								rawData.whiteip = $('#whiteip').val();
								*/
								
								getRawData();
								
								console.log(JSON.stringify(rawData));
								
								targetUrl="${pageContext.request.contextPath}/rest/account";
								if(rawData.seq==''){ 				// NEW
									restfulType = "POST";
								}else{								// MODIFY
									targetUrl += "/"+rawData.seq;
									restfulType = "PUT";
								}
								
								console.log("rawData.seq="+rawData.seq);
								console.log("targetUrl="+targetUrl);
								console.log("restfulType="+restfulType);
									
								jQuery.ajax({
									type:restfulType,
									url:targetUrl,
									contentType: 'application/json',
									data: JSON.stringify(rawData),
									dataType:"json",
									success:function(){
										location.href = "${pageContext.request.contextPath}/admin/account";
									},
									error:function(request,status,error){
										alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
									}    		
								});	
							}

							function destroyUser(){
								var selectedSeq;
								var row = $('#dg').datagrid('getSelected');
								if (row){
									$.messager.confirm('Confirm','사용자를 삭제하시겠습니까?',function(r){
										if (r){
											
											selectedSeq = getSelectedValue('#dg', 'seq');	
											
											jQuery.ajax({
												type:"DELETE",
												url:"${pageContext.request.contextPath}/rest/account/" + selectedSeq,
												contentType: 'application/json',
												dataType:"json",
												success:function(){
													$('#dg').datagrid('reload');    // reload the user data
												},
											    error:function(request,status,error){
//										            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
					        
					        function initData(){

								setMenuPannel();
							}

					        window.onload = setTimeout(initData, 500);
					        
					        $('#main_content_div').css("display","block");
					        
						</script>	
				</div>
			</div>
    
			</div> <!-- end of "center_content" -->

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<div class="footer">
			<%@ include file="/WEB-INF/jsp/footer/footer.jsp"%>
		</div>

		<!-- end of body-->
	</div>
</body>
</html>
