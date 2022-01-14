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
					<div id="main_easyui_layout" class="easyui-layout" style="width:100%;height:800px">
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
									<input id="searchTrBrno" name="searchTrBrno" class="easyui-textbox" label="관리점번호" labelWidth="75px" labelAlign="right" style="width:110px" data-options="required:false" tabindex="2"/>
									<input id="searchTrDt" name="searchTrDt" class="easyui-datebox" label="거래일자" labelWidth="60px" labelAlign="right" style="width:160px" data-options="required:false,formatter:myformatter,parser:myparser" />
									<input id="searchCrcd" name="searchCrcd" class="easyui-textbox" label="통화코드" labelWidth="75px" labelAlign="right" style="width:110px" data-options="required:false" tabindex="2"/>
								</div>
								<div align="right" style="width:30%;float:right">
									<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()">조회</a>
								</div>
							</div>	

							<div class="easyui-layout" data-options="fit:true" >

								<!-- GRID -->
								<div data-options="region:'center'" title="집계목록" style="width:30%;padding:0px">
							
											<table id="dg" class="easyui-datagrid" style="width:100%;height:'auto'" 
															method="get" pagination="false"
															view="scrollview"
															rownumbers="true" fitColumns="true" singleSelect="true">
											</table>
								</div>
								<div data-options="region:'east',split:true" title="상세목록" style="width:70%;">
											<table id="subdg" class="easyui-datagrid" style="width:100%;height:'auto'" 
															method="get" pagination="false"
															view="scrollview"
															rownumbers="true" fitColumns="true" singleSelect="true">
											</table>
								</div>
        
							</div> <!-- end of grid_accordion -->

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
		var defaultTargetUrl="${pageContext.request.contextPath}/rest/remittanceTotal";
		var defaultRestfulType="POST";
				
		function formClear(){
			
		}
				
		function setMaxLength(){
					
			// MAXLENGTH
			$("#searchCrcd").textbox('textbox').attr('maxlength', 3);

		}
				
		function setTextBoxCss(){

			// TEXTBOX 입력시 무조건 대문자화
		}
				
		function setTextBoxDisable(textBoxName){

		}
		
		function setTextBoxEnable(){

		}
				
		function getRawData(){
			
		}
				
		function searchData(){
					
			var searchTrBrno = $('#searchTrBrno').val();
			var searchTrDt   = $('#searchTrDt').val().replace(/-/g, '');
			var searchCrcd   = $('#searchCrcd').val();
			var url;

			if(searchTrDt=='' || searchTrDt.length!=8){
				searchTrDt = getToday();
			}
			
			console.log("searchTrBrno:"+searchTrBrno);
			console.log("searchTrDt:"+searchTrDt);
			console.log("searchCrcd:"+searchCrcd);
			
			// DATAGRID LOAD
			$('#dg').datagrid({
				url: '${pageContext.request.contextPath}/rest/remittanceTotal?trBrno='+searchTrBrno + '&trDt='+searchTrDt+'&crcd='+searchCrcd,
				onLoadSuccess:function(){
							
					var rows = $('#dg').datagrid('getRows').length; 
					if(rows==0){
						showErrMsg('조회 결과가 없습니다. 입력값을 확인하세요');
					}
					setButtonDisable();
				},
				onLoadError:function(){
					showErrMsg('조회 중 에러가 발생했습니다.');
				}
			})
		}

		function searchDetail(){
			
			var row = $('#dg').datagrid('getSelected');
			var trBrno = row.trBrno;
			var trDt = row.trDt;
			var crcd = row.crcd;
			
			// DATAGRID LOAD
			$('#subdg').datagrid({
				url: '${pageContext.request.contextPath}/rest/remittanceSubList?trBrno='+trBrno+'&trDt='+trDt+'&crcd='+crcd,
				onLoadSuccess:function(){
					var rows = $('#subdg').datagrid('getRows').length; 
					if(rows==0){
						showErrMsg('조회 결과가 없습니다. 입력값을 확인하세요');
					}
					setButtonDisable();
				},
				onLoadError:function(){
					showErrMsg('조회 중 에러가 발생했습니다.');
				}
			});		
		}
		function newData(){
			formClear();
					
			setMaxLength();
					
			setButtonDisable();
					
			targetUrl="${pageContext.request.contextPath}/rest/remittanceTotal";
			restfulType = "GET";
					
		}

		function editData(){
		}
				
		function saveData(){
		}

		function cancelData(){
		}
		
		function initSearch(){

			console.log("TODAY:"+getFormatDate());
			$('#searchTrDt').textbox('setValue', getFormatDate());
			$('#searchCrcd').textbox('clear');

		}
		
		// TEXTBOX enter event
		$(document).ready(function(){

			// GRID Double Click Event
		   	$('#dg').datagrid({
				onDblClickRow: function(index,row){

					searchDetail();
				}
		   	});
			
		 	// SORTER
			$('#dg').datagrid({
				remoteSort: false,
				columns: [[
					{field:'trBrno',	title:'관리점',		width:'19%',sortable:false,	halign:'center', align:'center',	 						sorter:sorter},
					{field:'trDt',		title:'거래일자',		width:'31%',sortable:false,	halign:'center', align:'center',	formatter:formatDate, 	sorter:sorter},
					{field:'crcd',		title:'통화코드',		width:'25%',sortable:true,	halign:'center', align:'center',	                      	sorter:sorter},
					{field:'owmnAmt',	title:'거래금액',		width:'',sortable:true,	halign:'center', align:'right', 		formatter:formatDecimal,sorter:sorter}
				]]
			});
			// SORTER
			$('#subdg').datagrid({
				remoteSort: false,
				columns: [[
					{field:'trDt',		title:'거래일자',		width:'13%',sortable:false,	halign:'center', align:'center',	formatter:formatDate, 	sorter:sorter},
					{field:'refNo',		title:'참조번호',		width:'20%',sortable:true,	halign:'center', align:'center', 							sorter:sorter},
					{field:'trBrno',	title:'영업점',		width:'11%',sortable:true,	halign:'center', align:'center', 							sorter:sorter},
					{field:'rmtKdcd',	title:'송금종류코드',	width:'15%',sortable:true,	halign:'center', align:'center', 							sorter:sorter},
					{field:'adreNtcd',	title:'상대국가',		width:'13%',sortable:true,	halign:'center', align:'center', 							sorter:sorter},
					{field:'crcd',		title:'통화코드',		width:'13%',sortable:false,	halign:'center', align:'center', 							sorter:sorter},
					{field:'owmnAmt',	title:'송금금액',		width:'15%',sortable:true,	halign:'center', align:'right',		formatter:formatDecimal,sorter:sorter}
				]]
			});

			console.log('1234');
		   	setMenuPannel();
		   	console.log('4567');

		   	setInputDivSizeType3('total');
			
		});
					
		window.onload = setTimeout(initData, 100);
		window.onload = setTimeout(initSearch, 200);
		window.onload = setTimeout(setButtonDisable, 300);
		$('#main_content_div').css("display","block");
			
		var minHeight=700;
		var minWidth=970;
		var defaultInputDivHeight=300;
		var defaultGridDivHeight=300;
		var minGridDivHeight=150;
				
	</script>	
</body>
</html>
