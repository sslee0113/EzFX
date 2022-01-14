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

				<div id="main_easyui_layout" class="easyui-layout" style="width:100%;height:670px">
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
								<input id="searchValDate" name="searchValDate" class="easyui-datebox" label="기준일자" labelWidth="80px" labelAlign="right" style="width:180px" data-options="required:false,formatter:myformatter,parser:myparser" />
							</div>
							<div align="right" style="width:30%;float:right">
								<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
							</div>
						</div>	

						<div class="easyui-layout" data-options="fit:true" >
						
							<!-- GRID -->
							<div title="검색결과" data-options="region:'center'" style="width:100%;padding:0px">
							
								<div id="grid_div" style="overflow:auto;padding:5px;width:'auto';height:520px;doSize:true;">
									<table id="dg" class="easyui-datagrid" style="width:100%"
												view="scrollview"
												method="get" toolbar="#toolbar" pagination="false"
												rownumbers="true" fitColumns="true" singleSelect="true">
										<thead>
											<tr>
												<th field="currCode" width="20%" sortable="false" data-options="align:'center'"><center>통화코드</center></th>
												<th field="ttSprdRate" width="20%" sortable="false" data-options="align:'right'"><center>전신환 SPREAD</center></th>
												<th field="basicSprdRate" width="20%" sortable="false" data-options="align:'right'"><center>현찰 SPREAD</center></th>
												<th field="coinSprdRate" width="20%" sortable="false" data-options="align:'right'"><center>주화 SPREAD</center></th>
												<th field="midRate" width="20%" sortable="false" data-options="align:'right',editor:{type:'numberbox',options:{precision:2}}"><center>매매기준율</center></th>
											</tr>
										</thead>
									</table>
								</div> <!-- end of 'grid_div' -->

							</div> <!-- END OF GRID -->

						</div> <!--  end of easyui-layout -->

						<div id="footer" align="right" style="padding:5px;">
							<%@ include file="/WEB-INF/jsp/footer/footer_btn.jsp"%>
						</div>
					</div> <!-- END OF RIGHT CONTENT -->
        
				</div>
				</div>
			</div> <!-- end of "center_content" -->

			<!-- SCRIPT -->
			<script type="text/javascript">
				var url;
				var rawData;
				var restfulType,targetUrl,param;
				var defaultTargetUrl="${pageContext.request.contextPath}/rest/frgnexchratenotice";
				var defaultRestfulType="POST";
				
				
				function initSearch(){

					console.log("TODAY:"+getFormatDate());
					$('#searchValDate').textbox('setValue', getFormatDate());

				}
				
				function formClear(){

					$('#dg').datagrid('reload');					
					
					setButtonEnable('initBtn');

					setButtonDisable();
				}
				
				function setMaxLength(){
					
					// MAXLENGTH
					$('#searchValDate').textbox('textbox').attr('maxlength',8);

				}
				
				function setTextBoxCss(){

				}
				
				function setTextBoxDisable(textBoxName){
					
				}
				
				function setTextBoxEnable(){

				}
				
				
				function getRawData(){
					rawData = new Object();

					return rawData;
				}
				
				function searchData(){

					var searchValDate = $('#searchValDate').val().replace(/-/g, '');
					var url;
					
					if(searchValDate=='' || searchValDate.length!=8){
						searchValDate = getToday();
					}
					
					console.log("searchValDate:"+searchValDate);
					
					// DATAGRID LOAD
					$('#dg').datagrid({
						url: '${pageContext.request.contextPath}/rest/frgnexchratenotice/'+searchValDate,
						onLoadSuccess:function(){
							
						},
						onLoadError:function(){

						}
					});

				}
				
				// 최초에만 호출되게, searchData 함수에 넣으면 조회버튼 누르면 Maximum call stack size exceeded
				function searchDataEditing(){
					$('#dg').datagrid('enableCellEditing').datagrid('gotoCell', {
		                index: 0,
		                field: 'currCode'
		            });
				}

				function newData(){

					targetUrl="${pageContext.request.contextPath}/rest/frgnexchratenotice";
					restfulType = "POST";
					
					$('#searchValDate').textbox('setValue', getFormatDate());
					
				}

				function editData(){

				}
				
				function saveData(){
					
					var frgnExchRateNoticeList = new Array();
					
					$('#dg').datagrid('acceptChanges');
					
					var rows = $('#dg').datagrid('getData').total;
					console.log("rows:"+rows);
					for(var i=0; i<rows; i++){
						rawData = new Object();
						rawData.valDate = $('#dg').datagrid('getRows')[i].valDate;
						rawData.currCode = $('#dg').datagrid('getRows')[i].currCode;
						rawData.midRate = $('#dg').datagrid('getRows')[i].midRate;
						rawData.quotSeq = $('#dg').datagrid('getRows')[i].quotSeq;
						
						if(rawData.midRate==0){
							$.messager.show({    // show success message
								title: 'Error',
								msg: rawData.currCode + ' 통화의 매매 기준율을 입력하세요'
							});	
							
							return;
						}
						
						console.log(JSON.stringify(rawData));
						
						//frgnExchRateNoticeList.rows.push({ 
						frgnExchRateNoticeList.push({ 
					        "valDate" : rawData.valDate,
					        "currCode" : rawData.currCode,
					        "midRate" : rawData.midRate
					    });
					}
					console.log("frgnExchRateNoticeList........");
					console.log(JSON.stringify(frgnExchRateNoticeList));
					
					jQuery.ajax({
						type:defaultRestfulType,
						url:defaultTargetUrl,
						contentType: 'application/json',
						data: JSON.stringify(frgnExchRateNoticeList),
						dataType:"json",
						success:function(){
							$.messager.show({    // show success message
								title: 'Message',
								msg: '정상처리되었습니다.'
							});	

							$('#dg').datagrid('reload');
						},
						error:function(request,status,error){
							$.messager.show({    // show error message
								title: 'Error',
								msg: "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error
							});
							
							return;
						}    		
					});	
					
				}

				function cancelData(){

				}
				
				/** ezfx.js 에 선언했는데 왜 못찾지 ㅡㅡa **/
				/** GRID FORMATTER **/
				function formatDate(val,row){
					return getFormatDate(val);
				}
				
				// TEXTBOX enter event
				$(document).ready(function(){

					// TEXTBOX에서 엔터 입력시 조회실행
					var s = $('#searchValDate');
					s.textbox('textbox').bind('keydown', function(e){
						if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
							searchData();
						}
					});	
					
					// GRID Double Click Event
				   	$('#dg').datagrid({
						onDblClickRow: function(index,row){
							// Button Enable
							setButtonEnable('initBtn');
							//setInputDivSizeType2('open');
							    
						},
						onClickRow: function(index,row){
							// Button Enable
							setButtonEnable('initBtn');
						}
					})
					
					// SORTER
					// TODO SORTER 를 사용하면 그리드 입력이 안된다. 방법을 찾아야한다.	
					/*
					$('#dg').datagrid({
						remoteSort: false,
						columns: [[
							{field:'currCode',title:'통화코드',width:'20%',sortable:true,halign:'center', align:'center', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'ttSprdRate',title:'전신환 SPREAD',width:'20%',sortable:true,halign:'center', align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'basicSprdRate',title:'현찰 SPREAD',width:'20%',sortable:true,halign:'center', align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'coinSprdRate',title:'주화 SPREAD',width:'20%',sortable:true,halign:'center', align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } },
							{field:'midRate',title:'매매기준율',width:'20%',sortable:true,halign:'center', align:'right', sorter:function(a,b){  if (a < b){  return -1; } else{ return 1; } } }
						]]
					});
					*/
					
					
					// SEARCH
					searchData();
					searchDataEditing();
					
				   	setInputDivSizeType3('mainBiz');
					
				});

				window.onload = setTimeout(initData, 200);
				window.onload = setTimeout(initSearch, 300);

				$('#main_content_div').css("display","block");
				
				var minHeight=700;
				var minWidth=970;
				var defaultInputDivHeight=240;
				var defaultGridDivHeight=300;
				var minGridDivHeight=130;

			</script>	
    
			<!-- END OF SCRIPT -->

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<!-- end of body-->
	</div>
</body>
</html>
