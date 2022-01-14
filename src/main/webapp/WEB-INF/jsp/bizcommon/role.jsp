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
					
					<!-- LEFT MENU -->
					<div id="menu_div" data-options="region:'west',split:true" title="메뉴" style="width:200px;">
						<%@ include file="/WEB-INF/jsp/menu/roleMenu.jsp"%>
					</div>
					
					<!-- RIGHT CONTENT -->
					<div id="contents_div" data-options="region:'center',footer:'#footer'" style="padding:3px 3px 3px 3px">
					<h2 align="center" style="margin-bottom:5px; padding:0px 0px 0px 0px"><%=selectedMenuName %></h2>
						<div id="searchCondition" class="easyui-panel" title="검색조건" style="width:'100%';height:73px;padding:7px;">
						
							<div align="left" style="width:70%;float:left">
								<input id="searchRoleCd" class="easyui-combobox" name="searchRoleCd" style="width:250px;"
									data-options=" url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=ROLE_CD',
										method:'get',
										valueField:'dcode',
										textField:'dcode',
										label: '권한코드',
										labelWidth: '130px',
										labelPosition: 'left',
										labelAlign: 'right',
										required: 'true',
										panelHeight: 122
										" />
							</div>
							<div align="right" style="width:10%;float:right">
								<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
							</div>
						</div>	
						<div class="easyui-layout" data-options="fit:true" >
							<!-- GRID -->
							<div data-options="region:'west',split:true, title:'검색결과'" style="width:100%;padding:5px">
								<table id="dg" class="easyui-datagrid" style="width:100%;height:87%"
											url=''
											method="GET"
											toolbar="#toolbar" pagination="false"
											rownumbers="true" fitColumns="true" singleSelect="true"
								>
								<thead>
								<tr>
									<th field="chk"          width="5%"   data-options="align:'center',editor:{type:'checkbox',options:{on:'true',off:''}}"><center>선택</center></th>
									<th field="dcodeName"    width="15%"  data-options="align:'center'"><center>상위메뉴</center></th>
									<th field="menuId"       width="15%"  data-options="align:'left'"><center>메뉴아이디</center></th>
									<th field="menuUrl"      width=""     data-options="align:'left'"><center>메뉴URL</center></th>
									<th field="menuName"     width="20%"  data-options="align:'left'"><center>메뉴명</center></th>
									<th field="firstUserId"   width="10%"  data-options="align:'center'"><center>등록아이디</center></th>
									<th field="firstDatetime" width="15%"  data-options="align:'center' ,formatter:formatDatetime"><center>등록일시</center></th>
								</tr>
								</thead>
								</table>
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

			    /***** ezfx.js 정의 되어 필드명만 바꿔야함. function 이름 유지   START *******/
				var url;
				var rawData;
				var restfulType,targetUrl,param;
				var defaultTargetUrl;
				var defaultRestfulType;
				
				function formClear(){
				}
				function setMaxLength(){
				}
				function setTextBoxCss(){
				}
				function setTextBoxDisable(textBoxName){
				}
				function setTextBoxEnable(){
				}
				function getRawData(){
					var roleList = new Array();
					$('#dg').datagrid('acceptChanges');
					var rows = $('#dg').datagrid('getData').total;
					for(var i=0; i<rows; i++){
						roleList.push({ 
					        "chk" : $('#dg').datagrid('getRows')[i].chk,
					        "roleCd" : $('#searchRoleCd').val(),
					        "menuId" : $('#dg').datagrid('getRows')[i].menuId,
					        "lastUserId" : $('#dg').datagrid('getRows')[i].lastUserId,
					        "lastDatetime" : $('#dg').datagrid('getRows')[i].lastDatetime
					    });
					}
					return roleList;
				}
			    /***** ezfx.js 정의 되어 필드명만 바꿔야함. function 이름 유지   END *******/
				
				function searchData(){
					var searchRoleCd = $('#searchRoleCd').val();
					var url = '${pageContext.request.contextPath}/rest/role/searchListRole?roleCd='+searchRoleCd;
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
						},
						onLoadError:function(){
							$.messager.show({    // show error message
								title: 'Error',
								msg: '조회 중 에러가 발생했습니다.'
							});
						}
					});
				}

				function searchDataEditing(){
					$('#dg').datagrid('enableCellEditing').datagrid('gotoCell', {
		                index: 0,
		                field: 'chk'
		            });
				}
				function editData(){
				}
				
				function saveData(){
					$.messager.confirm('Confirm','권한정보를 저장하시겠습니까?',function(r){
						if (r){
							rawData = getRawData();
							targetUrl="${pageContext.request.contextPath}/rest/role"
							restfulType = "POST";
							jQuery.ajax({
								type:restfulType,
								url:targetUrl,
								contentType: 'application/json',
								data: JSON.stringify(rawData),
								dataType:"json",
								success:function(){
									$('#dg').datagrid('reload');    // reload the user data
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
				}
				
				
				$(document).ready(function(){
					$('#searchRoleCd').combobox({
						onChange: function(newValue, oldValue){
							searchData();
						},
					    editable: false,
					    keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
					        down: function(e){
					            $(this).combobox('showPanel');
					            $.fn.combobox.defaults.keyHandler.down.call(this,e);
					        }
					    })	
					});
					
					searchDataEditing();
					
					// 수정버튼만 enable
					setButtonDisable();
					$('#editBtn').linkbutton('enable');
					/*
					$('#searchRoleCd').combobox({
						method: 'get',
						url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=ROLE_CD',
						required: true,
						valueField: 'dcode',
						textField: 'dcodeName'
					});
					*/
					
					$('#main_content').css('height',$(document).innerHeight()-170)
					
					$('#searchRoleCd').textbox('setValue', 'ROLE_ADMIN');
					searchData();
					
					setInputDivSizeType1();
					
				});
				$('#main_content_div').css("display","block");
				setMenuPannel();

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
