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
						<div id="searchCondition" class="easyui-panel" title="검색조건" style="width:100%;height:73px;padding:7px;">
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
							<div data-options="region:'center', title:'상세입력화면'" style="width:50%;padding:10px">
								<table id="dg1" class="easyui-datagrid" style="width:100%;height:88%"
											url=''
											method="GET"
											toolbar="#toolbar" pagination="false"
											rownumbers="true" fitColumns="true" singleSelect="true"
								>
									<thead>
										<tr>
											<th field="dcode" width="20%" sortable="false" ><center>상세구분코드</center></th>
											<th field="dcodeName" width="20%" sortable="false" ><center>상세구분코드명</center></th>
											<th field="viewSeq" width="20%" sortable="false" ><center>보기순서</center></th>
											<th field="lastUserId" width="20%" sortable="false" ><center>수정아이디</center></th>
											<th field="lastDatetime" width="20%" sortable="false" data-options="align:'center',formatter:formatDatetime" ><center>수정일시</center></th>
											<th field="firstUserId" width="20%" sortable="false" ><center>등록아이디</center></th>
											<th field="firstDatetime" width="20%" sortable="false"  data-options="align:'center',formatter:formatDatetime"><center>등록일시</center></th>
										</tr>
									</thead>
								</table>
									
								<div align="right">
									<a id="plusBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick = "newUser()" style="width:80px">추가</a>
									<a id="minusBtn" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="cancelData()" style="width:80px">삭제</a>
								</div>
								<div id="dlg" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
							    	<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
							    		<div style="margin-bottom:20px">
							    			<input id="gcode" name="gcode" class="easyui-textbox" required="true" label="공통코드" labelWidth="100px" labelAlign="right" style="width:85%" />
							    		</div>
							    		<div style="margin-bottom:20px">
							    			<input id="dcode" name="dcode" class="easyui-textbox" required="true" label="상세구분코드" labelWidth="100px" labelAlign="right" style="width:85%" />
							    		</div>
							    		<div style="margin-bottom:20px">
							    			<input id="dcodeName" name="dcodeName" class="easyui-textbox" required="true" label="상세구분코드명" labelWidth="100px" labelAlign="right" style="width:85%" />
							    		</div>
							    		<div style="margin-bottom:20px">
							    			<input id="viewSeq" name="viewSeq" class="easyui-numberbox" required="true" label="보기순서" labelWidth="100px" labelAlign="right" style="width:60%" />
							    		</div>
							    		<div style="display:none">
							    			<input id="firstDatetime" name="firstDatetime" class="easyui-textbox" required="true" label="최초등록일시" labelWidth="100px" labelAlign="right" style="width:60%" />
							    		</div>
							    	</form>
							   	</div>
							    <div id="dlg-buttons">
							        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveData()" style="width:90px">저장</a>
							        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">취소</a>
							    </div>
							    
							</div>
							<!-- END OF VIEW -->

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
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/CommonDcode";
				var defaultRestfulType="POST";
				
				function setMaxLength(){
					$("#searchGcode").textbox('textbox').attr('maxlength',20);
					$("#searchGcodeName").textbox('textbox').attr('maxlength',20);
				}
				function setTextBoxCss(){
				}
				function setTextBoxDisable(textBoxName){
					if(textBoxName=='all' || textBoxName=='gcode'){
						  $('#gcode').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='dcode'){
						$('#dcode').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='dcodeName'){
						$('#dcodeName').textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='viewSeq'){
						$('#viewSeq').textbox('disable');
					}
				}
				function setTextBoxEnable(){
					$('#gcode').textbox('enable');
					$('#dcode').textbox('enable');
					$('#dcodeName').textbox('enable');
					$('#viewSeq').textbox('enable');
				}
				function formClear(){
				}
				
				function checkValidation(){
					
					// 필수체크
					var gcode = $('#gcode').val();
					if(gcode==''){
						showErrMsg('<font color=red>공통코드</font>를 선택해주세요.');
						return false;
					}
					
					var dcode = $('#dcode').val();
					if(dcode==''){
						showErrMsg('<font color=red>상세구분코드</font>는 필수 입력사항입니다.');
						return false;
					}
					
					var dcodeName = $('#dcodeName').val();
					if(dcodeName==''){
						showErrMsg('<font color=red>상세구분코드명</font>은 필수 입력사항입니다.');
						return false;
					}
					
					var viewSeq = $('#viewSeq').val();
					if(viewSeq==''){
						showErrMsg('<font color=red>보기순서</font>는 필수 입력사항입니다.');
						return false;
					}
					

				}
				
				function newUser(){
					var row = $('#dg').datagrid('getSelected');
		            
		            if(row == null || row == ''){
		            	$('#gcode').textbox('setValue',"");
		            	$.messager.show({    // show error message
							title: 'Error',
							msg: "공통코드를 선택해주세요."
						});
		            	
		            	return;
		            }
		            else{
		            	$('#fm').form('clear');
		            	$('#dlg').dialog('open').dialog('center').dialog('setTitle','공통코드상세 추가');
		            	
			            $('#gcode').textbox('setValue',row.gcode);
						console.log(row.gcode);
			            
						setTextBoxEnable();
			            setTextBoxDisable('gcode');
		            }
		        }
				
				function editUser(){
					var row = $('#dg1').datagrid('getSelected');
					
					$('#fm').form('clear');
	            	$('#dlg').dialog('open').dialog('center').dialog('setTitle','공통코드상세 수정');
	            	
		            $('#gcode').textbox('setValue',row.gcode);
		            $('#dcode').textbox('setValue',row.dcode);
		            $('#dcodeName').textbox('setValue',row.dcodeName);
		            $('#viewSeq').textbox('setValue',row.viewSeq);

		            setTextBoxDisable('gcode');
		            setTextBoxDisable('dcode');
				}
				
				function saveData(){
					
					$.messager.confirm('Confirm','상세구분코드를 저장하시겠습니까?',function(r){
						
						// 필수입력값 검증
						if(checkValidation()==false){
							return;
						}
						
						if (r){
							rawData = getRawData();
							console.log("firstDatetime:" + $('#firstDatetime').val());
							console.log(JSON.stringify(rawData));
							targetUrl="${pageContext.request.contextPath}/rest/CommonDcode"
							if($('#firstDatetime').val()==''){
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
									$('#dg1').datagrid('reload');    // reload the user data
									$.messager.show({    // show error message
										title: 'Message',
										msg: '정상처리되었습니다.'
									});
									$('#dlg').dialog('close');
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
					var selectedDcode;
					var row = $('#dg1').datagrid('getSelected');

					if (row){
						$.messager.confirm('Confirm','상세구분코드를 삭제하시겠습니까?',function(r){
							if (r){
								console.log(JSON.stringify(row));
								targetUrl='${pageContext.request.contextPath}/rest/CommonDcode/';
								
								jQuery.ajax({
									type:"DELETE",
									   url:targetUrl,
									contentType: 'application/json',
									data: JSON.stringify(row),
									dataType:"json",
									success:function(){
										$('#dg1').datagrid('reload'); // reload the user data
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
				}
				
				function editData(){
					var row = $('#dg').datagrid('getSelected');
					if (row){
						$('#fm').form('load',row);
						setButtonDisable();
						setButtonEnable('initBtn');
						if($('#firstDatetime').val()==''){
							setButtonEnable('saveBtn');
						}else{
							setButtnEnable('editBtn');
						}
						setButtonEnable('cancelBtn');
						
						setTextBoxEnable();

					}
				}
				
				function getRawData(){
					rawData = new Object();
					rawData.gcode	= $('#gcode').val();
					rawData.gcodeName = $('#gcodeName').val();
					rawData.dcode	= $('#dcode').val();
					rawData.dcodeName = $('#dcodeName').val();
					rawData.viewSeq = $('#viewSeq').val();
					rawData.firstDatetime = $('#firstDatetime').val();
					return rawData;
				}

				function searchData(){
					
					$('#initBtn').linkbutton('disable');
					$('#saveBtn').linkbutton('disable');
					$('#editBtn').linkbutton('disable');
					$('#cancelBtn').linkbutton('disable');
					
					var searchGcode = $('#searchGcode').val();
					var searchGcodeName = $('#searchGcodeName').val();
					var searchStaCd = $('#searchStaCd').val();
					var searchGcodeLen = searchGcode.length;
					var searchGcodeNameLen = searchGcodeName.length;
					var url = '${pageContext.request.contextPath}/rest/searchListCommonCode?gcode='+searchGcode+'&gcodeName='+searchGcodeName+'&staCd='+searchStaCd;
					
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
				function searchDataDetail(gcode){
					var url = '${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode='+gcode;
					
					$('#dg1').datagrid({
						url:url,
						onLoadSuccess:function(){
							var rows = $('#dg1').datagrid('getRows').length; 
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
					
				// dg GRID Double Click Event
				   	$('#dg').datagrid({
						onDblClickRow: function(index,row){
							var row = $('#dg').datagrid('getSelected');
							if (row){
								searchDataDetail(row.gcode);
							}
						},
						onClickRow: function(index,row){
							var row = $('#dg').datagrid('getSelected');
							if (row){
								searchDataDetail(row.gcode);
							}
						}
					});
					
				 // dg1 GRID Double Click Event
				   	$('#dg1').datagrid({
						onDblClickRow: function(index,row){
							var row = $('#dg1').datagrid('getSelected');
							if (row){
								//searchDataDetail(row.gcode);
								editUser();
							}
						},
					});
					
					
					// SORTER
					$('#dg').datagrid({
						remoteSort: false,
						columns: [[
							{field:'gcode',		   title:'공통코드',		    width:'100px',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'gcodeName',  	title:'공통코드명',			width:'100px',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'staCd',      	title:'상태',		        width:'20%',  halign:'center', align:'center', sortable:true, formatter:formatStacd,  sorter:sorter },
							{field:'lastUserId',	title:'최종변경아이디',		width:'25%',  halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'lastDatetime',	title:'최종변경일시',		width:'130px',halign:'center', align:'center', sortable:true, formatter:formatDatetime, sorter:sorter },
							{field:'firstUserId',	title:'등록자아이디',		width:'20%',  halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'firstDatetime',	title:'등록일시',		    width:'130px',halign:'center', align:'center', sortable:true, formatter:formatDatetime, sorter:sorter },
						]]
					});
					// SORTER1
					$('#dg1').datagrid({
						remoteSort: false,
						columns: [[
							{field:'dcode',		   title:'상세구분코드',		    width:'100px',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'dcodeName',  	title:'상세구분코드명',		width:'100px',halign:'center', align:'center', sortable:true, sorter:sorter },
							{field:'viewSeq',      	title:'보기',		        width:'20%',  halign:'center', align:'center', sortable:true, sorter:sorter },
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
	</div>
</body>
</html>
