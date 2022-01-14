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
									<input id="searchZipcode" name="searchZipcode" class="easyui-textbox" label="우편번호" labelWidth="60px" labelAlign="right" style="width:120px" data-options="required:false" />
									<input id="searchProvince" name="searchProvince" value="서울" class="easyui-textbox" label="시도" labelWidth="40px" labelAlign="right" style="width:140px" data-options="required:false" />
									<input id="searchRoadName" name="searchRoadName" value="성수" class="easyui-textbox" label="도로명" labelWidth="50px" labelAlign="right" style="width:200px" data-options="required:false" />
									<input id="searchMainBuildingNo" name="searchMainBuildingNo" class="easyui-numberbox" label="건물번호본번" labelWidth="85px" labelAlign="right" style="width:140px" data-options="required:false" />
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
											<table id="dg" class="easyui-datagrid" style="width:100%;padding:0px;height:567px"
												view="scrollview"
												method="get" toolbar="#toolbar" pagination="true"
												rownumbers="true" fitColumns="true" singleSelect="true">
											</table>
										</div>
										<!-- end of 검색결과 -->
										<div id="input_div" title="입력화면" style="width:'auto';height:500px;padding:5px;" 
											data-options=" tools:[{ iconCls:'icon-clear',
																	handler:function(){
																		setInputDivSizeType2('close');
																		setTimeout(function(){setPagination(totalElements, pageNumber, pageSize);}, 10);
																	}}]">
								
											<form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
												<div align="left" style="width:50%;float:left">
													<div style="margin-bottom:2px">
														<input id="zipcode" name="zipcode" class="easyui-textbox" label="구역번호" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:true" tabindex="1"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="province" name="province" class="easyui-textbox" label="시도" labelWidth="130px" labelAlign="right" style="width:280px" data-options="required:true,validType:'length[1,50]'" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="county" name="county" class="easyui-textbox" label="시군구" labelWidth="130px" labelAlign="right" style="width:250px" data-options="required:true,validType:'length[1,50]'" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="town" name="town" class="easyui-textbox" label="읍면" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="roadName" name="roadName" class="easyui-textbox" label="도로명" labelWidth="130px" labelAlign="right" style="width:350px" data-options="required:true" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="roadNameCd" name="roadNameCd" class="easyui-textbox" label="도로명코드" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:true" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="mainBuildingNo" name="mainBuildingNo" class="easyui-numberbox" label="건물번호본번" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:true" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="bulkDeliveryName" name="bulkDeliveryName" class="easyui-textbox" label="다량배달처명" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:false" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="lawDongCode" name="lawDongCode" class="easyui-textbox" label="법정동코드" labelWidth="130px" labelAlign="right" style="width:250px" data-options="required:true,validType:'length[1,50]'" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="liName" name="liName" class="easyui-textbox" label="리명" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:false,validType:'length[1,50]'" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="mainLotNo" name="mainLotNo" class="easyui-numberbox" label="지번본번" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:true,validType:'length[1,50]'" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
													<select class="easyui-combobox" id="mountainYn" name="mountainYn" label="산여부" labelWidth="130px" labelAlign="right" style="width:200px;" data-options="panelHeight:50" tabindex="12">
														<option value="0">토지</option>
														<option value="1">산</option>
													</select>
													</div>
													<div style="margin-bottom:2px">
														<input id="oldZipcode" name="oldZipcode" class="easyui-numberbox" label="구우편번호" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:false,validType:'length[1,50]'" tabindex="12"/>
													</div>
												</div>
												<div align="left" style="width:50%;float:left">
													<div style="margin-bottom:2px">
														<input id="buildingMgntNo" name="buildingMgntNo" class="easyui-textbox" label="건물관리번호" labelWidth="130px" labelAlign="right" style="width:350px" data-options="required:false" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="provinceEng" name="provinceEng" class="easyui-textbox" label="시도영문" labelWidth="130px" labelAlign="right" style="width:260px" data-options="required:true,validType:'length[1,50]'" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="countyEng" name="countyEng" class="easyui-textbox" label="시군구영문" labelWidth="130px" labelAlign="right" style="width:320px" data-options="required:true,validType:'length[1,50]'" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="townEng" name="townEng" class="easyui-textbox" label="읍면영문명" labelWidth="130px" labelAlign="right" style="width:230px" data-options="required:false" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="roadNameEng" name="roadNameEng" class="easyui-textbox" label="도로명영문" labelWidth="130px" labelAlign="right" style="width:350px" data-options="required:true" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
													<select class="easyui-combobox" id="undergroundYn" name="undergroundYn" label="지하여부" labelWidth="130px" labelAlign="right" style="width:200px;" data-options="panelHeight:50" tabindex="11">
														<option value="0">지상</option>
														<option value="1">지하</option>
													</select>
													</div>
													<div style="margin-bottom:2px">
														<input id="subBuildingNo" name="subBuildingNo" class="easyui-textbox" label="건물번호부번" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:true" tabindex="11"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="buildingName" name="buildingName" class="easyui-textbox" label="시군구용건물명" labelWidth="130px" labelAlign="right" style="width:350px" data-options="required:false,validType:'length[1,50]'" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="lawDongName" name="lawDongName" class="easyui-textbox" label="법정동명" labelWidth="130px" labelAlign="right" style="width:280px" data-options="required:true,validType:'length[1,50]'" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="adminDongName" name="adminDongName" class="easyui-textbox" label="행정동명" labelWidth="130px" labelAlign="right" style="width:280px" data-options="required:true,validType:'length[1,50]'" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="subLotNo" name="subLotNo" class="easyui-textbox" label="지번부번" labelWidth="130px" labelAlign="right" style="width:170px" data-options="required:true,validType:'length[1,50]'" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="serialNo" name="serialNo" class="easyui-textbox" label="읍면동일련번호" labelWidth="130px" labelAlign="right" style="width:200px" data-options="required:true,validType:'length[1,50]'" tabindex="12"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="zipcodeSerialNo" name="zipcodeSerialNo" class="easyui-textbox" label="우편번호일련번호" labelWidth="130px" labelAlign="right" style="width:190px" data-options="required:false,validType:'length[1,50]'" tabindex="12"/>
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
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/zipcode";
				var defaultRestfulType="POST";
				var totalElements;
	            var pageNumber;
	            var pageSize;
				
				function formClear(){
					
					$('#zipcode').textbox('clear');
					$('#province').textbox('clear');
					$('#provineEng').textbox('clear');
					$('#county').textbox('clear');
					$('#countyEng').textbox('clear');
					$('#town').textbox('clear');
					$('#townEng').textbox('clear');
					$('#roadNameCd').textbox('clear');
					$('#roadName').textbox('clear');
					$('#roadNameEng').textbox('clear');
					$('#undergroundYn').textbox('clear');
					$('#subBuildingNo').textbox('clear');
					$('#buildingMgntNo').textbox('clear');
					$('#bulkDeliveryName').textbox('clear');
					$('#buildingName').textbox('clear');
					$('#lawDongCode').textbox('clear');
					$('#lawDongName').textbox('clear');
					$('#liName').textbox('clear');
					$('#adminDongName').textbox('clear');
					$('#mountainYn').textbox('clear');
					$('#mainLotNo').textbox('clear');
					$('#serialNo').textbox('clear');
					$('#subLotNo').textbox('clear');
					$('#oldZipcode').textbox('clear');
					$('#zipcodeSerialNo').textbox('clear');
					
				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$("#buildingMgntNo").textbox('textbox').attr('maxlength',100);
					$("#searchProvince").textbox('textbox').attr('maxlength',10);
					$("#searchZipcode").textbox('textbox').attr('maxlength',5);
					$("#searchProvince").textbox('textbox').attr('maxlength',20);
					$("#searchRoadName").textbox('textbox').attr('maxlength',80);
					$("#searchMainBuildingNo").textbox('textbox').attr('maxlength',5);

				}
				
				function setTextBoxCss(){

					// TEXTBOX 입력시 무조건 대문자화

				}
				
				function setTextBoxDisable(textBoxName){
					// Disable
					if(textBoxName=='all' || textBoxName=='zipcode'){
						$('#zipcode').textbox('disable');	
					}
					if(textBoxName=='all' || textBoxName=='buildingMgntNo'){
						$('#buildingMgntNo').textbox('disable');	
					}
					
					/*
					// SEARCH TEXTBOX
					if(textBoxName=='all' || textBoxName=='searchProvince'){
						$("#searchProvince").textbox('disable');
					}
					if(textBoxName=='all' || textBoxName=='searchRoadName'){
						$("#searchRoadName").textbox('disable');
					}
					*/
				}
				
				function setTextBoxEnable(){
					// Disable
					$('#zipcode').textbox('enable');
					$('#buildingMgntNo').textbox('enable');
					//$('#firstDate').textbox('enable');
					//$('#lastDate').textbox('enable');
				}
				

				
				function getRawData(){
					rawData = new Object();
					rawData.zipcode  			= $('#zipcode').val();
					rawData.province 			= $('#province').val();
					rawData.provineEng			= $('#provineEng').val();
					rawData.county 				= $('#county').val();
					rawData.countyEng 			= $('#countyEng').val();
					rawData.town 				= $('#town').val();
					rawData.townEng  			= $('#townEng').val();
					rawData.roadNameCd 			= $('#roadNameCd').val();
					rawData.roadName			= $('#roadName').val();
					rawData.roadNameEng    		= $('#roadNameEng').val();
					rawData.undergroundYn 		= $('#undergroundYn').val();
					rawData.subBuildingNo   	= $('#subBuildingNo').val();
					rawData.buildingMgntNo   	= $('#buildingMgntNo').val();
					rawData.bulkDeliveryName    = $('#bulkDeliveryName').val();
					rawData.buildingName   		= $('#buildingName').val();
					rawData.lawDongCode  		= $('#lawDongCode').val();
					rawData.lawDongName   		= $('#lawDongName').val();
					rawData.liName   			= $('#liName').val();
					rawData.adminDongName  		= $('#adminDongName').val();
					rawData.mountainYn   		= $('#mountainYn').val();
					rawData.mainLotNo 			= $('#mainLotNo').val();
					rawData.serialNo 			= $('#serialNo').val();
					rawData.subLotNo   			= $('#subLotNo').val();
					rawData.oldZipcode  		= $('#oldZipcode').val();
					rawData.zipcodeSerialNo   	= $('#zipcodeSerialNo').val();

					return rawData;
				}
				function searchData()
				{
					searchData(1,10);
				}
				
				function searchData(page,size){
					var searchZipcode = $('#searchZipcode').val();
					var searchProvince = $('#searchProvince').val();
					var searchRoadName = $('#searchRoadName').val();
					var searchMainBuildingNo = $('#searchMainBuildingNo').val();

					if(searchProvince == '' || searchRoadName == ''){
						showErrMsg('시도와 도로명을 모두 입력해주세요');
						return;
					}
					if(page==null || page==''){
						page = 1;
					}
					if(size==null || size==''){
						size = 20;
					}
					page--; // 실제 서버에서 는 1페이지가 0 으로 처리되기 때문에 하나씩 작은 수를 서버에 전달해야한다.
					
					var	url = '${pageContext.request.contextPath}/rest/searchListZipcodePageable?'
						url +=  'zipcode='+ searchZipcode;
						url +=  '&province='+ searchProvince;
						url +=  '&roadName='+ searchRoadName;
						url +=  '&mainBuildingNo=' + searchMainBuildingNo;
						url += '&page='+page+'&size='+size;
					pageNumber = page;
					jQuery.ajax({
						type:'GET',
						url:url,
						contentType: 'application/json',
						dataType:"json",
						success:function(data){
							// Page<?> 형태로 생성된 JSON 데이터로 부터 DATAGRID 에서 사용할 수 있는 형태로 변환
							var rawData = new Object();
							rawData.total = data.content.length;
							rawData.rows = data.content;
							// 변환된 JSON 형태를 그리드에 LOAD
							var dg = $('#dg');
							dg.datagrid('loadData', rawData);
							
							totalElements = data.totalElements;
							pageSize = data.size;
							
							setPagination(totalElements, pageNumber, pageSize);
							var rows = $('#dg').datagrid('getRows').length; 
							if(rows==0){
								showErrMsg('조회 결과가 없습니다. 입력값을 확인하세요');
							}
							setButtonDisable();
							setButtonEnable('initBtn');
							setButtonEnable('saveBtn');
						},
						error:function(request,status,error){
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
					
					targetUrl="${pageContext.request.contextPath}/rest/zipcode";
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
						setTextBoxDisable('buildingMgntNo');
						setTextBoxDisable('zipcode');

					}
				}
				
				function saveData(){
				}

				function cancelData(){
				}
				
				// TEXTBOX enter event
				$(document).ready(function(){

					// TEXTBOX에서 엔터 입력시 조회실행
					var t = $('#searchZipcode');
					t.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});
					
					var u = $('#searchProvince');
					u.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					
					var w = $('#searchRoadName');
					w.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});
					
					var o = $('#searchMainBuildingNo');
					o.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					
					// GRID Double Click Event
				   	$('#dg').datagrid({
						onDblClickRow: function(index,row){
							editData();
							
							setInputDivSizeType2('open');

							setTimeout(function(){setPagination(totalElements, pageNumber, pageSize);}, 10);
						},
						onClickRow: function(index,row){
							editData();

							setPagination(totalElements, pageNumber, pageSize);
						},
						onSortColumn: function(sort,order){
							setPagination(totalElements, pageNumber, pageSize);	
						}
					})
						
					// SORTER
					$('#dg').datagrid({
						remoteSort: false,
						columns: [[
							{field:'zipcode', 			width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'우편번호'},
							{field:'province', 			width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'시도'},
							{field:'provinceEng', 		width:'12%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'시도영문'},
							{field:'county', 			width:'13%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'시군구'},
							{field:'countyEng', 		width:'15%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'시군구영문'},
							{field:'town', 				width:'7%',  sortable:true, halign:'center', align:'center', sorter:sorter, title:'읍면'},
							{field:'townEng', 			width:'7%',  sortable:true, halign:'center', align:'center', sorter:sorter, title:'읍면영문'},
							{field:'roadNameCd', 		width:'15%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'도로명코드'},
							{field:'roadName', 			width:'20%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'도로명'},
							{field:'roadNameEng', 		width:'20%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'도로명영문'},
							{field:'undergroundYn', 	width:'9%',  sortable:true, halign:'center', align:'center', sorter:sorter, title:'지하여부'},
							{field:'mainBuildingNo', 	width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'건물번호본번'},
							{field:'subBuildingNo', 	width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'건물번호부번'},
							{field:'buildingMgntNo', 	width:'25%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'건물관리번호'},
							{field:'bulkDeliveryName', 	width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'다량배달처명'},
							{field:'buildingName', 		width:'23%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'시군구용건물명'},
							{field:'lawDongCode', 		width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'법정동코드'},
							{field:'lawDongName', 		width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'법정동명'},
							{field:'liName', 			width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'리명'},
							{field:'adminDongName', 	width:'15%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'행정동명'},
							{field:'mountainYn', 		width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'산여부'},
							{field:'mainLotNo', 		width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'지번본번'},
							{field:'serialNo', 			width:'12%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'읍면동일련번호'},
							{field:'subLotNo', 			width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'지번부번'},
							{field:'oldZipcode', 		width:'10%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'구우편번호'},
							{field:'zipcodeSerialNo', 	width:'13%', sortable:true, halign:'center', align:'center', sorter:sorter, title:'우편번호일련번호'}
						]]
					});
					
					$('#mountainYn').combobox({
						editable: false,
						keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
							down: function(e){
								$(this).combobox('showPanel');
								$.fn.combobox.defaults.keyHandler.down.call(this,e);
							}
						})
					});
					
					$('#undergroundYn').combobox({
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
				})

				window.onload = setTimeout(searchData, 10);
				$('#main_content_div').css("display","block");
				
				var minHeight=700;
				var minWidth=970;
				var defaultInputDivHeight=410;
				var defaultGridDivHeight=300;
				var minGridDivHeight=150;
				
			</script>	
			<!-- do not delete this div:clear -->
			<div class="clear"></div>
		</div>
		<!-- end of body-->
	</div>
</body>
</html>
