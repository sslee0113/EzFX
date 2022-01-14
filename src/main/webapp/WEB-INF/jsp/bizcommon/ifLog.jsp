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
					<!-- LEFT MENU -->
					<div id="menu_div" data-options="region:'west',split:true" title="메뉴" style="width:200px;">
						<%@ include file="/WEB-INF/jsp/menu/roleMenu.jsp"%>
					</div>
					
					<!-- RIGHT CONTENT -->
					<div id="contents_div" data-options="region:'center',footer:'#footer'" style="padding:3px 3px 3px 3px">
					<h2 align="center" style="margin-bottom:5px; padding:0px 0px 0px 0px"><%=selectedMenuName %></h2>
						<div id="searchCondition_div" class="easyui-panel" title="검색조건" style="width:100%;height:73px;padding:7px;">
							<div align="left" style="width:70%;float:left">
								<input id="searchStartDate" name="searchStartDate" class="easyui-datebox" label="조회일자" labelWidth="80px" labelAlign="right" style="width:180px" data-options="required:false,formatter:myformatter,parser:myparser" tabindex="1"/>
								~
								<input id="searchEndDate" name="searchEndDate" class="easyui-datebox" style="width:100px" data-options="required:false,formatter:myformatter,parser:myparser" tabindex="2"/>
								<input class="easyui-combobox" id="searchBizType" name="searchBizType" style="width:170px"  />
								<input class="easyui-combobox" id="searchTrYn" name="searchTrYn" style="width:165px"  />
							</div>
							<div align="right" style="width:30%;float:right">
								<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">조회</a>
							</div>
						</div>	

						<div class="easyui-layout" data-options="fit:true" >
						
							<!-- GRID -->
							<div data-options="region:'center'" style="width:100%;padding:0px">
							
								<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">

									<div id="grid_div" title="검색결과" style="overflow:auto;padding:5px;width:'auto';height:650px;doSize:true;">
										<table id="dg" class="easyui-datagrid" style="width:100%;"
													view="scrollview"
													method="get" toolbar="#toolbar" pagination="true"
													rownumbers="true" fitColumns="true" singleSelect="true">
											<thead>
												<tr>
													<th field="ifNo" width="20%" sortable="false" data-options="align:'center'"><center>인터페이스 번호</center></th>
													<th field="bizType" width="20%" sortable="false" data-options="align:'center'"><center>업무구분</center></th>
													<th field="staCd" width="20%" sortable="false" data-options="align:'center'"><center>상태코드</center></th>
													<th field="trYn" width="20%" sortable="false" data-options="align:'center'"><center>전송여부</center></th>
													<th field="trDate" width="20%" sortable="false" data-options="align:'center', formatter:formatDate"><center>거래일자</center></th>
													<th field="trTime" width="20%" sortable="false" data-options="align:'center', formatter:formatTime"><center>거래시각</center></th>
												</tr>
											</thead>
										</table>
									</div>
								</div>
								<!-- end of 'easyui-accordion' -->

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
				var defaultTargetUrl='';
				var defaultRestfulType="POST";
				var totalElements;
	            var pageNumber;
	            var pageSize;
				function initSearch(){
					$('#searchStartDate').textbox('setValue', getFormatStartDayOfMonth());
					$('#searchEndDate').textbox('setValue', getFormatDate());
				}
				
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
					rawData = new Object();
					rawData.ifNo = $('#ifNo').val();
					rawData.staCd = $('#staCd').val();
					rawData.trYn = $('#trYn').val();
					rawData.trDate = $('#trDate').val();
					rawData.trTime = $('#trTime').val();
					rawData.bizType = $('#bizType').val();
					rawData.firstDate = $('#firstDate').val();
					rawData.firstTime = $('#firstTime').val();
					rawData.lastDate = $('#lastDate').val();
					rawData.lastTime = $('#lastTime').val();
					return rawData;
				}
				function newData(){
				}

				function editData(){
				}
				function saveData(){
				}

				function cancelData(){
				}
				
				function searchData(page, size){
					var searchStartDate = $('#searchStartDate').val().replace(/-/g, '');
					var searchEndDate = $('#searchEndDate').val().replace(/-/g, '');
					var searchBizType = $('#searchBizType').val();
					var searchTrYn = $('#searchTrYn').val();
					var url;
					
					if(page==null || page==''){
						page = 1;
					}
					if(size==null || size==''){
						size = 20;
					}
					
					if(searchStartDate=='' || searchStartDate.length!=8){
						searchStartDate = getToday();
					}
					if(searchEndDate=='' || searchEndDate.length!=8){
						searchEndDate = getToday();
					}
					// 검색 날짜 검증
					if(searchStartDate > searchEndDate){
						$.messager.show({    // show error message
							title: 'Error',
							msg: '기준일자의 시작일이 종료일 이후 날짜입니다. 다시 입력해주세요.'
						});	
						$('#searchStartDate').textbox('textbox').focus();
						return;
					}
					url = '${pageContext.request.contextPath}/rest/searchListInterfaceLog?startDate='+searchStartDate+'&endDate='+searchEndDate+'&trYn='+searchTrYn+'&bizType='+searchBizType;
					page--; // 실제 서버에서 는 1페이지가 0 으로 처리되기 때문에 하나씩 작은 수를 서버에 전달해야한다.
					url += '&page='+page+'&size='+size;
					// setPagination 에서 사용하기 위해서
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
							var dg = $('#dg');
							dg.datagrid('loadData', rawData);
							
							totalElements = data.totalElements;
							pageSize = data.size;
							setPagination(totalElements, pageNumber, pageSize);
							
							// 조회 결과 확인
							var rows = $('#dg').datagrid('getRows').length; 
							if(rows==0){
								showInfMsg('조회 결과가 없습니다. 입력값을 확인하세요');
							}
							setButtonDisable();
						},
						error:function(request,status,error){
							if(chkSession(request, contextPath)){
								showErrfMsg('조회 중 에러가 발생했습니다.<br>' + getPureErrMsg(request));
							}
						}    		
					});	
				}

				$(document).ready(function(){
					$('#searchBizType').combobox({
						url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=BIZ_TYPE',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '업무구분',
						labelWidth: '70px',
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
					$('#searchTrYn').combobox({
						url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=TR_YN',
				   	 	method:'get',
				   	    valueField:'dcode',
				   	    textField:'dcodeName',
						label: '전송여부',
						labelWidth: '90px',
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
					initSearch();
					searchData();
					setInputDivSizeType2('close');
				})
				$('#main_content_div').css("display","block");
				var minHeight=700;
				var minWidth=970;
				var defaultInputDivHeight=350;
				var defaultGridDivHeight=300;
				var minGridDivHeight=0;

			</script>	
    
			<!-- END OF SCRIPT -->

			<!-- do not delete this div:clear -->
			<div class="clear"></div>

		</div>

		<!-- end of body-->
	</div>
</body>
</html>
