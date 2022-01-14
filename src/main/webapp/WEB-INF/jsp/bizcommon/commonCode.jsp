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
						<div id="searchCondition" class="easyui-panel" title="검색조건" style="width:'auto';height:73px;padding:7px;">
							<div align="left" style="width:70%;float:left">
								<input id="searchGcode" name="searchGcode" class="easyui-textbox" label="공통코드" labelWidth="80px" labelAlign="right" style="width:200px" data-options="required:false,validType:'length[0,20]'" />
								<input id="searchGcodeName" name="searchGcodeName" class="easyui-textbox" label="공통코드명" labelWidth="70px" labelAlign="right" style="width:250px" data-options="required:false,validType:'length[0,132]'" />
								<select class="easyui-combobox" id="searchStaCd" name="searchStaCd" label="상태" labelWidth="70px" labelAlign="right" style="width:150px;" data-options="panelHeight:50">
									<option value="0">사용</option>
									<option value="9">삭제</option>
								</select>
								
							</div>
							<div align="right" style="width:10%;float:right">
								<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
							</div>
						</div>	
						<div class="easyui-layout" data-options="fit:true" >
							<!-- GRID -->
							<div data-options="region:'west',split:true, title:'검색결과'" style="width:50%;padding:5px">
								<table id="dg" class="easyui-datagrid" style="width:100%;height:87%"
											url=''
											method="GET"
											toolbar="#toolbar" pagination="false"
											rownumbers="true" fitColumns="true" singleSelect="true"
								>
									<thead>
										<tr>
											<th field="gcode" width="20%" sortable="false" ><center>공통코드</center></th>
											<th field="gcodeName" width="20%" sortable="false" ><center>공통코드명</center></th>
											<th field="staCd" width="20%" sortable="false"  data-options="align:'center',formatter:formatStacd" ><center>상태</center></th>
											<th field="lastUserId" width="20%" sortable="false" ><center>수정아이디</center></th>
											<th field="lastDatetime" width="20%" sortable="false" data-options="align:'center',formatter:formatDatetime" ><center>수정일시</center></th>
											<th field="firstUserId" width="20%" sortable="false" ><center>등록아이디</center></th>
											<th field="firstDatetime" width="20%" sortable="false"  data-options="align:'center',formatter:formatDatetime"><center>등록일시</center></th>
										</tr>
									</thead>
								</table>
							</div> <!-- END OF GRID -->
							<!-- VIEW -->
							<div data-options="region:'center', title:'입력화면'" style="width:50%;padding:10px">
							
								<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
									<div style="margin-bottom:2px">
										<input id="gcode" name="gcode" class="easyui-textbox" label="공통코드" labelWidth="130px" labelAlign="right" style="width:250px" data-options="required:true,validType:'length[1,20]'" />
									</div>
									<div style="margin-bottom:2px">
										<input id="gcodeName" name="gcodeName" class="easyui-textbox" label="공통코드명" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:true,validType:'length[1,132]'" />
									</div>
									<div style="margin-bottom:2px">
										<select class="easyui-combobox" id="staCd" name="staCd" label="상태" labelWidth="130px" labelAlign="right" style="width:200px;" data-options="panelHeight:50" disabled>
											<option value="0" selected>사용</option>
											<option value="9">삭제</option>
										</select>
									</div>
									<div style="margin-bottom:2px">
										<input id="lastUserId" name="lastUserId" class="easyui-textbox" label="최종변경아이디" labelWidth="130px" labelAlign="right" style="width:250px" disabled data-options="required:false" />
									</div>
									<div style="margin-bottom:2px">
										<input id="lastDatetime" name="lastDatetime" class="easyui-textbox" label="최종변경일시" labelWidth="130px" labelAlign="right" style="width:250px" disabled data-options="required:false" />
									</div>
									<div style="margin-bottom:2px">
										<input id="firstUserId" name="firstUserId" class="easyui-textbox" label="등록자아이디" labelWidth="130px" labelAlign="right" style="width:250px" disabled data-options="required:false" />
									</div>
									<div style="margin-bottom:2px">
										<input id="firstDatetime" name="firstDatetime" class="easyui-textbox" label="등록일시" labelWidth="130px" labelAlign="right" style="width:250px" disabled data-options="required:false" />
									</div>
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

			    /***** ezfx.js 정의 되어 필드명만 바꿔야함. function 이름 유지   START *******/
				var url;
				var rawData;
				var restfulType,targetUrl,param;
				var defaultTargetUrl='';
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/CommonCode";
				var defaultRestfulType="POST";
				
				function formClear(){
					$('#gcode').textbox('clear');
					$('#gcodeName').textbox('clear');
					$('#staCd').textbox('setValue','사용');
					$('#firstDatetime').textbox('clear');
					$('#firstUserId').textbox('clear');
					$('#lastUserId').textbox('clear');
					$('#lastDatetime').textbox('clear');
				}
				
				function setMaxLength(){
					$("#searchGcode").textbox('textbox').attr('maxlength',20);
					$("#searchGcodeName").textbox('textbox').attr('maxlength',20);
					$("#searchStaCd").textbox('textbox').attr('maxlength',20);
					$("#gcode").textbox('textbox').attr('maxlength',20);
					$('#gcodeName').textbox('textbox').attr('maxlength',20);
				}
				function setTextBoxCss(){
					// TEXTBOX 입력시 무조건 대문자화
				}
				
				function setTextBoxDisable(textBoxName){
					// Disable
					if(textBoxName=='all' || textBoxName=='gcode'){
						$('#gcode').textbox('disable');	
					}
					if(textBoxName=='all' || textBoxName=='gcodeName'){
						$('#gcodeName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='staCd'){
						$('#staCd').textbox('disable');
					}
				}
				function setTextBoxEnable(){
					$('#gcode').textbox('enable');	
					$('#gcodeName').textbox('enable');
					$('#staCd').textbox('enable');
				}

				function getRawData(){
					rawData = new Object();
					rawData.gcode	= $('#gcode').val();
					rawData.gcodeName = $('#gcodeName').val();
					rawData.staCd = $('#staCd').val();
					rawData.firstDatetime = $('#firstDatetime').val();
					return rawData;
				}
			    /***** ezfx.js 정의 되어 필드명만 바꿔야함. function 이름 유지   END *******/
				
				
				function searchData(){
					var searchGcode = $('#searchGcode').val();
					var searchGcodeName = $('#searchGcodeName').val();
					var searchStaCd = $('#searchStaCd').val();
					var searchGcodeLen = searchGcode.length;
					var searchGcodeNameLen = searchGcodeName.length;
					
					var url = '${pageContext.request.contextPath}/rest/searchListCommonCode?gcode='+searchGcode+'&gcodeName='+searchGcodeName+'&staCd='+searchStaCd;
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
							//initData();
						},
						onLoadError:function(){
							$.messager.show({    // show error message
								title: 'Error',
								msg: '조회 중 에러가 발생했습니다.'
							});
						}
					});
				}

				function editData(){

					setButtonDisable();
					setButtonEnable('initBtn');
					setButtonEnable('editBtn');
					setButtonEnable('cancelBtn');

					$('#gcode').textbox('disable');	
					$('#gcodeName').textbox('enable');	
					$('#staCd').textbox('enable');	
					
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$('#fm').form('load',row);
					}
				}
				
				function saveData(){
					
					$.messager.confirm('Confirm','공통코드를 저장하시겠습니까?',function(r){
						if (r){
							rawData = getRawData();
							console.log(JSON.stringify(rawData));
							targetUrl="${pageContext.request.contextPath}/rest/CommonCode"
							if(rawData.firstDatetime ==''){
								restfulType = "POST";
							}
							else{
								restfulType = "PUT";
							}
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
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$.messager.confirm('Confirm','공통코드를 삭제하시겠습니까?',function(r){
							if (r){
								console.log(JSON.stringify(getRawData()));
								console.log("${pageContext.request.contextPath}/rest/CommonCode/"+ getRawData().gcode);
								jQuery.ajax({
									type:"DELETE",
									url:"${pageContext.request.contextPath}/rest/CommonCode/"+ getRawData().gcode,
									contentType: 'application/json',
									dataType:"json",
									success:function(){
										searchData();
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
					
				}
				
				$(document).ready(function(){

					var t = $('#searchGcode');
					t.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					
					$('#searchGcodeName').textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					
					$('#searchStaCd').combobox({
						onChange: function(newValue, oldValue){
							searchData();
						},
						// KEY DOWN 추가
					    editable: false,
					    keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
					        down: function(e){
					            $(this).combobox('showPanel');
					            $.fn.combobox.defaults.keyHandler.down.call(this,e);
					        }
					    })	
					});
					
					// GRID Double Click Event
				   	$('#dg').datagrid({
						onDblClickRow: function(index,row){
							editData();
						},
						onClickRow: function(index,row){
							editData();
						}
					});
					
					
					// SORTER
					$('#dg').datagrid({
						remoteSort: false,
						columns: [[
							{field:'gcode',		   title:'공통코드',		    width:'100px',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'gcodeName',  	title:'공통코드명',		width:'100px',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'staCd',      	title:'상태',		        width:'20%',  halign:'center', align:'center', sortable:true, formatter:formatStacd,  sorter:sorter },
							{field:'lastUserId',	title:'최종변경아이디',		width:'25%',  halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'lastDatetime',	title:'최종변경일시',		width:'130px',halign:'center', align:'center', sortable:true, formatter:formatDatetime, sorter:sorter },
							{field:'firstUserId',	title:'등록자아이디',		width:'20%',  halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'firstDatetime',	title:'등록일시',		    width:'130px',halign:'center', align:'center', sortable:true, formatter:formatDatetime, sorter:sorter },
						]]
					});
					
					$('#main_content').css('height',$(document).innerHeight()-170)
					
					setInputDivSizeType1();
					searchData();
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
