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
							<div id="searchCondition_div" class="easyui-panel" title="검색조건" style="width:100%;height:73px;padding:7px;">
								<div align="left" style="width:70%;float:left">
									<input id="searchAcsjCd" name="searchAcsjCd" class="easyui-textbox" label="계정과목코드" labelWidth="85px" labelAlign="right" style="width:155px" data-options="required:false" tabindex="1" />
									<input id="searchAcsjNm" name="searchAcsjNm" class="easyui-textbox" label="계정과목명" labelWidth="85px" labelAlign="right" style="width:210px" data-options="required:false" tabindex="1" />
								</div>
								<div align="right" style="width:30%;float:right">
									<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
								</div>
							</div>	

							<div class="easyui-layout" data-options="fit:true" >

								<!-- GRID -->
								<div data-options="region:'center'" style="width:100%;padding:0px">
							
									<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">
						
										<div id="grid_div" title="검색결과" style="overflow:auto;width:100%;height:670px;doSize:true;">
											<table id="dg" class="easyui-datagrid" style="width:100%;"
															url = "${pageContext.request.contextPath}/rest/accountingGlCode?acsjCd="
															view="scrollview"
															method="GET" toolbar="#toolbar" pagination="false"
															rownumbers="true" fitColumns="true" singleSelect="true">
															
												<thead>
													<tr>
														<th field="acsjCd" width="10%" sortable="false" data-options="align:'center'"><center>계정과목코드</center></th>
														<th field="acsjNm" width="15%" sortable="false" data-options="align:'left',"><center>계정과목명</center></th>
														<th field="acsjGrp" width="12%" sortable="false" data-options="align:'center'"><center>계정그룹(1~4)</center></th>
														<th field="hostAcsjCd" width="10%" sortable="false" data-options="align:'center'"><center>계정계코드</center></th>
														<th field="bokAcsjTcd" width="10%" sortable="false" data-options="align:'center'"><center>한국은행코드</center></th>
														<th field="acsjOputNm" width="15%" sortable="false" data-options="align:'left',formatter:formatAcsjOputNm"><center>계정과목 조회명</center></th>
														<th field="astDbtTcd" width="13%" sortable="false" data-options="align:'center',formatter:formatAstDbtTcd"><center>자산부채구분코드</center></th>
														<th field="wnFrTcd" width="13%" sortable="false" data-options="align:'center',formatter:formatWnFrTcd"><center>원화외화구분코드</center></th>
														<th field="evSbjTcd" width="13%" sortable="false" data-options="align:'center',formatter:formatEvSbjTcd"><center>평가주체구분코드</center></th>
														<th field="astDbtYn" width="12%" sortable="false" data-options="align:'center'"><center>양변여부(Y/N)</center></th>
														<th field="onlnTcd" width="12%" sortable="false" data-options="align:'center',formatter:formatOnlnTcd"><center>온라인구분코드</center></th>
														<th field="statTcd" width="12%" sortable="false" data-options="align:'center',formatter:formatStatTcd"><center>상태구분코드</center></th>	
														<th field="qryYn" width="8%" sortable="false" data-options="align:'center'"><center>조회여부</center></th>
														<th field="qrySqn" width="12%" sortable="false" data-options="align:'center'"><center>조회순서</center></th>
													</tr>
												</thead>
											</table>
										</div>
										<!-- end of 검색결과 -->
										<div id="input_div" title="입력화면" style="width:100%;height:500px;padding:5px;" 
										data-options=" tools:[{ iconCls:'icon-clear',
																handler:function(){
																	setInputDivSizeType2('close');
																}}]">
							
										<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
											<input type="hidden" id="mode" name="mode" value="new" class="easyui-textbox">
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="acsjCd" name="acsjCd" class="easyui-textbox" label="계정과목코드" labelWidth="130px" labelAlign="right" style="width:210px" data-options="required:true" tabindex="1"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="acsjNm" name="acsjNm" class="easyui-textbox" label="계정과목명" labelWidth="130px" labelAlign="right" style="width:250px" data-options="required:true" tabindex="2"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="acsjGrp" class="easyui-combobox" name="acsjGrp" style="width:190px" tabindex="3"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="hostAcsjCd" name="hostAcsjCd" class="easyui-textbox" label="계정계코드" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false,validType:'length[1,50]'" tabindex="4"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="bokAcsjTcd" name="bokAcsjTcd" class="easyui-textbox" label="한국은행코드" labelWidth="130px" labelAlign="right" style="width:220px" data-options="required:false,validType:'length[1,50]'" tabindex="5"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="acsjOputNm" name="acsjOputNm" class="easyui-textbox" label="계정과목 조회명" labelWidth="130px" labelAlign="right" style="width:270px" data-options="required:true" tabindex="6"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="astDbtTcd" class="easyui-combobox" name="astDbtTcd" style="width:200px" tabindex="7"/>
												</div>
											</div>
											<div align="left" style="width:50%;float:left">
												<div style="margin-bottom:2px">
													<input id="wnFrTcd" class="easyui-combobox" name="wnFrTcd" style="width:210px" tabindex="8"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="evSbjTcd" class="easyui-combobox" name="evSbjTcd" style="width:210px" tabindex="9"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="astDbtYn" class="easyui-combobox" name="astDbtYn" style="width:200px" tabindex="10"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="onlnTcd" class="easyui-combobox" name="onlnTcd" style="width:210px" tabindex="11"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="statTcd" class="easyui-combobox" name="statTcd" style="width:200px" tabindex="12"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="qryYn" class="easyui-combobox" name="qryYn" style="width:200px" tabindex="13"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="qrySqn" name="qrySqn" class="easyui-textbox" label="조회순서" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:true" tabindex="14"/>
												</div>
												<input type="hidden" id="lastUser" name="lastUser" class="easyui-textbox">
											</div>
										</form>
									</div>
									<!-- end of 입력화면 -->
									</div>
									<!-- end of 'easyui-accordion' -->
								</div>
								<!-- END OF GRID -->	
							</div>
							<!--  end of easyui-layout -->

							<div id="footer" align="right" style="padding:5px;">
								<%@ include file="/WEB-INF/jsp/footer/footer_btn.jsp"%>
							</div>
						</div> <!-- END OF RIGHT CONTENT -->
					</div>	<!--  main_easyui_layout  -->
				</div>	<!-- center_content -->
			</div> <!-- main_content_div -->

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<!-- end of body-->
	</div>
	
	<!-- SCRIPT -->
	<script type="text/javascript">
		var url;
		var rawData;
		var restfulType,targetUrl,param;
		var defaultTargetUrl="${pageContext.request.contextPath}/rest/accountingGlCode";
		var defaultRestfulType="POST";
				
		function formClear(){
			
			$('#acsjCd').textbox('clear');
			$('#acsjNm').textbox('clear');
			$('#acsjGrp').textbox('clear');
			$('#hostAcsjCd').textbox('clear');
			$('#bokAcsjTcd').textbox('clear');
			$('#acsjOputNm').textbox('clear');
			$('#astDbtTcd').combobox('setValue', '1');
			$('#wnFrTcd').combobox('setValue', '0');
			$('#evSbjTcd').combobox('setValue', '1');
			$('#astDbtYn').combobox('setValue', 'Y');
			$('#onlnTcd').combobox('setValue', '1');
			$('#statTcd').combobox('setValue', '1');
			$('#qryYn').combobox('setValue', 'Y');
			$('#qrySqn').textbox('clear');
			$('#lastDate').textbox('clear');
			$('#lastTime').textbox('clear');
			$('#lastUser').textbox('clear');
			
		}
				
		function setMaxLength(){
					
			// MAXLENGTH
			$("#searchAcsjCd").textbox('textbox').attr('maxlength', 9);

		}
				
		function setTextBoxCss(){

			// TEXTBOX 입력시 무조건 대문자화
		}
				
		function setTextBoxDisable(textBoxName){
			// Disable
			if(textBoxName=='all' || textBoxName=='acsjCd'){
				$('#acsjCd').textbox('disable');	
			}
			if(textBoxName=='all' || textBoxName=='acsjNm'){
				$('#acsjNm').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='acsjGrp'){
				$('#acsjGrp').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='hostAcsjCd'){
				$('#hostAcsjCd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='bokAcsjTcd'){
				$('#bokAcsjTcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='acsjOputNm'){
				$('#acsjOputNm').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='astDbtTcd'){
				$('#astDbtTcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='wnFrTcd'){
				$('#wnFrTcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='evSbjTcd'){
				$('#evSbjTcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='astDbtYn'){
				$('#astDbtYn').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='onlnTcd'){
				$('#onlnTcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='astDbtYn'){
				$('#astDbtYn').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='onlnTcd'){
				$('#onlnTcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='astDbtYn'){
				$('#astDbtYn').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='onlnTcd'){
				$('#onlnTcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='statTcd'){
				$('#statTcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='qryYn'){
				$('#qryYn').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='qrySqn'){
				$('#qrySqn').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='lastDate'){
				$('#lastDate').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='lastTime'){
				$('#lastTime').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='lastUser'){
				$('#lastUser').textbox('disable');
			}
		}
		
		function setTextBoxEnable(){
			$('#acsjCd').textbox('enable');
			$('#acsjNm').textbox('enable');
			$('#acsjGrp').textbox('enable');
			$('#hostAcsjCd').textbox('enable');
			$('#bokAcsjTcd').textbox('enable');
			//$('#acsjOputNm').textbox('enable');
			$('#astDbtTcd').textbox('enable');
			$('#wnFrTcd').textbox('enable');
			$('#evSbjTcd').textbox('enable');
			$('#astDbtYn').textbox('enable');
			$('#onlnTcd').textbox('enable');
			$('#statTcd').textbox('enable');
			$('#qryYn').textbox('enable');
			$('#qrySqn').textbox('enable');
			$('#lastDate').textbox('enable');
			$('#lastTime').textbox('enable');
			$('#lastUser').textbox('enable');
		}
				
		function getRawData(){
			rawData = new Object();
			rawData.acsjCd = $('#acsjCd').val();
			rawData.acsjNm = $('#acsjNm').val();
			rawData.acsjGrp = $('#acsjGrp').val();
			rawData.hostAcsjCd = $('#hostAcsjCd').val();
			rawData.bokAcsjTcd = $('#bokAcsjTcd').val();
			rawData.acsjOputNm = $('#acsjOputNm').val();
			rawData.astDbtTcd = $('#astDbtTcd').val();
			rawData.wnFrTcd = $('#wnFrTcd').val();
			rawData.evSbjTcd = $('#evSbjTcd').val();
			rawData.astDbtYn = $('#astDbtYn').val();
			rawData.onlnTcd = $('#onlnTcd').val();
			rawData.statTcd = $('#statTcd').val();
			rawData.qryYn = $('#qryYn').val();
			rawData.qrySqn = $('#qrySqn').val();
			rawData.lastDate = $('#lastDate').val();
			rawData.lastTime = $('#lastTime').val();
			rawData.lastUser = $('#lastUser').val();

			return rawData;
		}
				
		function searchData(){
			
			var searchAcsjCd = $('#searchAcsjCd').val();
			var searchAcsjNm = $('#searchAcsjNm').val();
			var searchAcsjCdLen = searchAcsjCd.length;
			var searchAcsjNmLen = searchAcsjNm.length;
			console.log("searchAcsjCd:"+searchAcsjCd);
			console.log("searchAcsjNm:"+searchAcsjNm);
			console.log("searchAcsjCd.length:"+searchAcsjCdLen);
			console.log("searchAcsjNm.length:"+searchAcsjNmLen);
			
			var url='${pageContext.request.contextPath}/rest/accountingGlCode?acsjCd='+searchAcsjCd+'&acsjNm='+searchAcsjNm;
			
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
			setMaxLength();
			
			setButtonDisable();
			setButtonEnable('initBtn');
			setButtonEnable('saveBtn');
			
			targetUrl="${pageContext.request.contextPath}/rest/accountingGlCode";
			restfulType = "POST";
			
		}

		function editData(){
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#fm').form('load',row);
				console.log(row);
				setButtonDisable();
				setButtonEnable('initBtn');
				if($('#firstDate').val()==''){
					setButtonEnable('saveBtn');
				}else{
					setButtonEnable('editBtn');
				}
				setButtonEnable('cancelBtn');
				
				setTextBoxEnable();
				setTextBoxDisable('acsjCd');
				setTextBoxDisable('acsjOputNm');
				setTextBoxDisable('qrySqn');

			}
		}
		
		function saveData(){
			
			// 필수입력값 검증
			if(checkValidation()==false){
				return;
			}
			
			console.log($('#mode').val());
			$.messager.confirm('Confirm','주소 정보를 저장하시겠습니까?',function(r){
				if (r){
					if($('#mode').val() == 'new'){
						$('#lastUser').val('test');
					}
					rawData = getRawData();
					console.log(JSON.stringify(rawData));
					
					targetUrl="${pageContext.request.contextPath}/rest/accountingGlCode";
					
					// 수정과 신규를 구분함
					if($('#mode').val() == 'modify'){
						targetUrl += "/"+rawData.acsjCd;
						restfulType = "PUT";
					}else if($('#mode').val() == 'new'){
						restfulType = "POST";
					}

					console.log("rawData.acsjCd="+rawData.acsjCd);
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
			var selectedAcsjCd;
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$.messager.confirm('Confirm','영업점 정보를 취소하시겠습니까?',function(r){
					if (r){
						
						selectedAcsjCd = getSelectedValue('#dg', 'acsjCd');	
						
						jQuery.ajax({
							type:"DELETE",
							url:"${pageContext.request.contextPath}/rest/accountingGlCode/" + selectedAcsjCd,
							contentType: 'application/json',
							dataType:"json",
							success:function(){
								//formClear();
								initData();
								$.messager.show({    // show error message
									title: 'Message',
									msg: '정상처리되었습니다.'
								});
								
								if($('#searchAcsjCd').val()==''){
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
		
		function checkValidation(){
			console.log($('#astDbtTcd').val());
			
			// 필수체크
			var acsjCd = $('#acsjCd').val();
			if(acsjCd==''){
				showErrMsg('<font color=red>계정과목코드</font>는 필수 입력사항입니다.');
				return false;
			}
			var acsjNm = $('#acsjNm').val();
			if(acsjNm==''){
				showErrMsg('<font color=red>계정과목명</font>은 필수 입력사항입니다.');
				return false;
			}
			var acsjGrp = $('#acsjGrp').val();
			if(acsjGrp==''){
				showErrMsg('<font color=red>계정그룹(1~4)</font>은 필수 입력사항입니다.');
				return false;
			}
			var acsjOputNm = $('#acsjOputNm').val();
			if(acsjOputNm==''){
				showErrMsg('<font color=red>계정과목 조회명</font>은 필수 입력사항입니다.');
				return false;
			}
			var astDbtTcd = $('#astDbtTcd').val();
			if(astDbtTcd==''){
				showErrMsg('<font color=red>자산부채구분코드</font>는 필수 입력사항입니다. <font color=red>항믁</font>을 선택하세요');
				return false;
			}
			
			var wnFrTcd = $('#wnFrTcd').val();
			if(wnFrTcd==''){
				showErrMsg('<font color=red>원화외화구분코드</font>는 필수 입력사항입니다. <font color=red>항믁</font>을 선택하세요');
				return false;
			}
			
			var evSbjTcd = $('#evSbjTcd').val();
			if(evSbjTcd==''){
				showErrMsg('<font color=red>평가주체구분코드</font>는 필수 입력사항입니다. <font color=red>항믁</font>을 선택하세요');
				return false;
			}
			
			var astDbtYn = $('#astDbtYn').val();
			if(astDbtYn==''){
				showErrMsg('<font color=red>양변여부(Y/N)</font>는 필수 입력사항입니다. <font color=red>항믁</font>을 선택하세요');
				return false;
			}
			
			var onlnTcd = $('#onlnTcd').val();
			if(onlnTcd==''){
				showErrMsg('<font color=red>온라인구분코드</font>는 필수 입력사항입니다. <font color=red>항믁</font>을 선택하세요');
				return false;
			}
			
			var statTcd = $('#statTcd').val();
			if(statTcd==''){
				showErrMsg('<font color=red>상태구분코드</font>는 필수 입력사항입니다. <font color=red>항믁</font>을 선택하세요');
				return false;
			}
			
			var qryYn = $('#qryYn').val();
			if(qryYn==''){
				showErrMsg('<font color=red>조회여부</font>는 필수 입력사항입니다. <font color=red>항믁</font>을 선택하세요');
				return false;
			}
			
			var qrySqn = $('#qrySqn').val();
			if(qrySqn==''){
				showErrMsg('<font color=red>조회순서</font>는 필수 입력사항입니다.');
				return false;
			}

		}
		
		function initSearch(){

			$('#searchAcsjCd').textbox('clear');
			$('#searchAcsjNm').textbox('clear');

		}
		
		function commonCode(){

			$('#acsjGrp').combobox({
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=ACSJ_GRP',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '계정그룹(1~4)',
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
				}),
				onChange: function(){
					var acsjNm = $('#acsjNm').val();
					var acsjGrp = $('#acsjGrp').val();

					if(acsjGrp == "1"){
						$('#acsjOputNm').textbox('setValue', acsjNm);
					}
					else if(acsjGrp == "2"){
						$('#acsjOputNm').textbox('setValue', "  " + acsjNm);
					}
					else if(acsjGrp == "3"){
						$('#acsjOputNm').textbox('setValue', "    " + acsjNm);
					}
					else if(acsjGrp == "4"){
						$('#acsjOputNm').textbox('setValue', "      " + acsjNm);
					}
					else{
						$('#acsjOputNm').textbox('setValue', acsjNm);
					}
					
					
					console.log("AscjGrp:" + $('#acsjGrp').val());
				}
			});
			
			$('#astDbtTcd').combobox({
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=AST_DBT_TCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '자산부채구분코드',
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
				}),
			})
			
			$('#wnFrTcd').combobox({
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=WN_FR_TCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '원화외화구분코드',
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
				}),
			})
			
			$('#evSbjTcd').combobox({
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=EV_SBJ_TCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '평가주체구분코드',
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
				}),
			})
			
			$('#astDbtYn').combobox({
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=AST_DBT_YN',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '양변여부(Y/N)',
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
				}),
			})
			
			$('#onlnTcd').combobox({
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=ONLN_TCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '온라인구분코드',
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
				}),
			})
			
			$('#statTcd').combobox({
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=STA_CD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '상태구분코드',
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
				}),
			})
			
			$('#qryYn').combobox({
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=QRY_YN',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '조회여부',
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
				}),
			})
		}
		
		
		
		// TEXTBOX enter event
		$(document).ready(function(){
			
			// TEXTBOX에서 엔터 입력시 조회실행
			var t = $('#searchAcsjCd');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchData();
				}
			});
			
			var u = $('#searchAcsjNm');
			u.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchData();
				}
			});

			// GRID Double Click Event
		   	$('#dg').datagrid({
				onDblClickRow: function(index,row){
					editData();
					$('#mode').val('modify');
					setInputDivSizeType2('open');
				},
				onClickRow: function(index,row){
					editData();
					$('#mode').val('modify');
				}
			})
			
			// SORTER
			$('#dg').datagrid({
				remoteSort: false,
				columns: [[
					{field:'acsjCd',	title:'계정과목코드',	width:'10%',	sortable:true,halign:'center', align:'center', 								sorter:sorter},
					{field:'acsjNm',	title:'계정과목명',	width:'15%',	sortable:true,halign:'center', align:'left', 									sorter:sorter},
					{field:'acsjGrp',	title:'계정그룹(1~4)',	width:'12%',	sortable:true,halign:'center', align:'center', 								sorter:sorter},
					{field:'hostAcsjCd',title:'계정계코드',	width:'10%',	sortable:true,halign:'center', align:'center', 									sorter:sorter},
					{field:'bokAcsjTcd',title:'한국은행코드',	width:'10%',	sortable:true,halign:'center', align:'center', 								sorter:sorter},
					{field:'acsjOputNm',title:'계정과목 조회명',	width:'15%',	sortable:true,halign:'center', align:'left',	formatter:formatAcsjOputNm, sorter:sorter},
					{field:'astDbtTcd',	title:'자산부채구분코드',width:'13%',	sortable:true,halign:'center', align:'center',		formatter:formatAstDbtTcd, 	sorter:sorter},
					{field:'wnFrTcd',	title:'원화외화구분코드',width:'13%',	sortable:true,halign:'center', align:'center',		formatter:formatWnFrTcd, 	sorter:sorter},
					{field:'evSbjTcd',	title:'평가주체구분코드',width:'13%',	sortable:true,halign:'center', align:'center',		formatter:formatEvSbjTcd, 	sorter:sorter},
					{field:'astDbtYn',	title:'양변여부(Y/N)',	width:'12%',	sortable:true,halign:'center', align:'center', 								sorter:sorter},
					{field:'onlnTcd',	title:'온라인구분코드',	width:'12%',	sortable:true,halign:'center', align:'center',	formatter:formatOnlnTcd, 	sorter:sorter},
					{field:'statTcd',	title:'상태구분코드',	width:'12%',	sortable:true,halign:'center', align:'center',	formatter:formatStatTcd, 	sorter:sorter},
					{field:'qryYn',		title:'조회여부',		width:'8%',		sortable:true,halign:'center', align:'center', 								sorter:sorter},
					{field:'qrySqn',	title:'조회순서',		width:'12%',	sortable:true,halign:'center', align:'center', 								sorter:sorter}
				]]
			});
			
		   	commonCode();
			
			$('#main_content').css('height',$(document).innerHeight()-170)
			
			setInputDivSizeType2('close');
			
		});
					
		window.onload = setTimeout(initData, 10);
		$('#main_content_div').css("display","block");
		
		
		var minHeight=700;
		var minWidth=970;
		var defaultInputDivHeight=350;
		var defaultGridDivHeight=300;
		var minGridDivHeight=150;
				
	</script>	
</body>
</html>
