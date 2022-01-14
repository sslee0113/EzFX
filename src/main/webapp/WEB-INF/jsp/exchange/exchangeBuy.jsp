<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
						<div id="menu_div" data-options="region:'west',split:true" title="메뉴" style="width:200px">
							<%@ include file="/WEB-INF/jsp/menu/roleMenu.jsp"%>
						</div>
						<!-- RIGHT CONTENT -->
						<div id="contents_div" data-options="region:'center',footer:'#footer'" style="padding:3px 3px 3px 3px">
						<h2 align="center" style="margin-bottom:5px; padding:0px 0px 0px 0px"><%=selectedMenuName %></h2>
							<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:'auto'">
								<div id="grid_div" title="검색결과" style="width:'auto';height:300px;" data-options="selected:false">
									<div id="tb" style="padding:2px 5px;">
										<input id="searchStartDate" name="searchStartDate" class="easyui-datebox" label="거래일자" labelWidth="70px" labelAlign="right" style="width:180px" data-options="required:false,formatter:myformatter,parser:myparser" />
										~
										<input id="searchEndDate" name="searchEndDate" class="easyui-datebox" style="width:100px" data-options="required:false,formatter:myformatter,parser:myparser" />
										<input id="searchRefNo" name="searchRefNo" class="easyui-textbox" label="참조번호" labelWidth="70px" labelAlign="right" style="width:205px" data-options="required:true" tabindex="2"/>
										<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()">조회</a>
									</div>
									<table id="dg" class="easyui-datagrid" style="height:265px" 
													view="scrollview"
													method="get" toolbar="#tb" pagination="false"
													rownumbers="true" fitColumns="true" singleSelect="true">
										<thead>
											<tr>
												<th field="refNo" width="13%" sortable="false" data-options="align:'center'"><center>참조번호</center></th>
												<th field="trDt" width="13%" sortable="false" data-options="align:'center',formatter:formatDate"><center>거래일자</center></th>
												<th field="custNo" width="13%" sortable="false" data-options="align:'center'"><center>고객번호</center></th>
												<th field="custNm" width="13%" sortable="false" data-options="align:'left'"><center>고객명</center></th>
												<th field="crcd" width="10%" sortable="false" data-options="align:'center'"><center>통화코드</center></th>
												<th field="efmAmt" width="13%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>환전금액</center></th>
												<th field="pmnyExrt" width="13%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>적용환율</center></th>
												<th field="frxcLdgrStcd" width="12%" sortable="false" data-options="align:'center'"><center>외환원장상태</center></th>
											</tr>
										</thead>
									</table>
								</div>
								<div id="input_div" title="입력화면" style="width:100%;height:520px;padding:5px;" data-options="selected:true">
									<form id="fm" method="post" novalidate style="margin:0;padding:20px 20px">
										<input id="isSearch" type="hidden" name="isSearch" value="N"/>
										<div align="left" style="width:49%;float:left">
											<div style="margin-bottom:2px">
												<input id="tradeType" class="easyui-combobox" name="tradeType" style="width:240px;" />
											</div>
											<div style="margin-bottom:2px">
												<input id="rnnoDscd" class="easyui-combobox" name="rnnoDscd" style="width:260px;" />
											</div>
											<div style="margin-bottom:2px">
												<input id="custNm" name="custNm" class="easyui-textbox" label="고객명" labelWidth="130px" labelAlign="right" style="width:350px" data-options="required:true" tabindex="5"/>
											</div>
										</div>
										<div align="left" style="width:49%;float:left">
											<div style="margin-bottom:2px">
												<input id="refNo" name="refNo" class="easyui-textbox" label="참조번호" labelWidth="130px" labelAlign="right" style="width:270px" data-options="required:true" tabindex="2"/>
												<input type="hidden" id="parData" name="parData" class="easyui-textbox" value="${map.refNo}"></input>
											</div>
											<div style="margin-bottom:2px">
												<input id="rnno" name="rnno" class="easyui-textbox" label="실명번호" labelWidth="130px" labelAlign="right" style="width:270px" data-options="required:true" tabindex="4"/>
											</div>
										</div>
										<div class="easyui-layout" style="width:100%;height:10px">
											&nbsp; <!-- 빈줄 간격 만들기 -->
										</div>
										<div align="left" style="width:49%;float:left">
											<div style="margin-bottom:2px">
												<input id="crcd" class="easyui-combobox" name="crcd" style="width:200px;" tabindex="6" />
											</div>
											<div style="margin-bottom:2px">
												<input id="pmnyAmt" name="pmnyAmt" class="easyui-numberbox" label="지폐금액" labelWidth="130px" labelAlign="right" style="width:270px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="6"/>
											</div>
											<div style="margin-bottom:2px">
												<input id="amtyDscd" class="easyui-combobox" name="amtyDscd" style="width:230px;" tabindex="9" />
											</div>
											<div style="margin-bottom:2px">
												<input id="usNtcd" class="easyui-combobox" name="usNtcd" style="width:190px;" tabindex="11" />
											</div>
											<div style="margin-bottom:2px">
												<input id="intdRscd" class="easyui-combobox" name="intdRscd" style="width:360px;" tabindex="13" />
											</div>
										</div>
										<div align="left" style="width:49%;float:left">
											<div class="easyui-layout" style="width:100%;height:25px">
												&nbsp; <!-- 빈칸 간격 만들기 -->
											</div>
											<div style="margin-bottom:2px">
												<input id="cnAmt" name="cnAmt" class="easyui-numberbox" label="주화금액" labelWidth="130px" labelAlign="right" style="width:270px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="8"/>
											</div>
											<div style="margin-bottom:2px">
												<input id="ntntNtcd" class="easyui-combobox" name="ntntNtcd" style="width:190px;" tabindex="10" />
											</div>
											<div style="margin-bottom:2px">
												<input id="trMnbdPccd" class="easyui-combobox" name="trMnbdPccd" style="width:270px;" tabindex="12" />
											</div>
											<div style="margin-bottom:2px;display:block">
												<input id="frxcLdgrStcd" class="easyui-combobox" name="frxcLdgrStcd" style="width:200px;"/>
											</div>
										</div>
										<div class="easyui-layout" style="width:99%;height:10px">
												&nbsp; <!-- 빈줄 간격 만들기 -->
										</div>
										<!-- 입금 / 지급 정보  -->
										<div id="p" class="easyui-panel" title="입금/지급 정보" style="width:99%;height:210px;padding:5px;">
											<div align="left" style="width:49%;float:left">
												<div style="margin-bottom:2px">
													<input id="efmAmt" name="efmAmt" class="easyui-numberbox" label="외국통화" labelWidth="130px" labelAlign="right" style="width:210px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="99"/>
												</div>
											</div>
											<div align="left" style="width:35%;float:left">
												<div style="margin-bottom:2px">
													<input id="prmRt" class="easyui-combobox" name="prmRt" style="width:200px;" tabindex="14" />
												</div>
											</div>
											<div align="right" style="width:15%;float:left">
												<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="preCalc()" style="width:90px">금액선조회</a>
											</div>
											<div class="easyui-layout" style="width:99%;height:10px">
												&nbsp; <!-- 빈줄 삽입  -->
											</div>
											<div align="left" style="width:30%;float:left">
												<div style="margin-bottom:2px">
													<input id="wnItrlkAmt" name="wnItrlkAmt" class="easyui-numberbox" label="원화연동금액" labelWidth="130px" labelAlign="right" style="width:210px;text-align:right" data-options="required:false,precision:0,groupSeparator:','" tabindex="31"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="wnItrlkAct" name="wnItrlkAct" class="easyui-numberbox" label="원화계좌번호" labelWidth="130px" labelAlign="right" style="width:250px;text-align:left" data-options="required:false" tabindex="33"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="altWna" name="altWna" class="easyui-numberbox" label="일반원화대체" labelWidth="130px" labelAlign="right" style="width:210px;text-align:right" data-options="required:false,precision:0,groupSeparator:','" tabindex="35"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="cashWna" name="cashWna" class="easyui-numberbox" label="통화(현금)금액" labelWidth="130px" labelAlign="right" style="width:210px;text-align:right" data-options="required:false,precision:0,groupSeparator:','" tabindex="37"/>
												</div>
											</div>
											<div align="left" style="width:70%;float:left">
												<div class="easyui-layout" style="width:99%;height:5px">
													&nbsp; <!-- 빈줄 삽입  -->
												</div>
												<!-- 지폐금액,주화금액의 TITLE -->
												<div class="easyui-layout" style="width:99%;height:20px">
													<div align="left" style="width:128px;float:left">
														&nbsp;
													</div>
													<div align="left" style="width:90px;float:left;text-align:center">
														외화금액
													</div>
													<div align="left" style="width:90px;float:left;text-align:center">
														고시환율
													</div>
													<div align="left" style="width:90px;float:left;text-align:center">
														적용환율
													</div>
													<div align="left" style="width:90px;float:left;text-align:center">
														원화금액
													</div>
													<div align="left" style="width:90px;float:left;text-align:center">
														거래이익
													</div>
												</div> <!-- end of 지폐금액,주화금액의 TITLE -->
												<div class="easyui-layout" style="width:99%;height:26px">
													<div class="my-textbox1" align="left" style="float:left;">
														지폐금액
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="pmnyFrgAmt" name="pmnyFrgAmt" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="16"/>
														</div>
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="pmnyExrt" name="pmnyExrt" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="17"/>
														</div>
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="pmnyAplExrt" name="pmnyAplExrt" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="18"/>
														</div>
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="pmnyStlmWna" name="pmnyStlmWna" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:0,groupSeparator:','" tabindex="20"/>
														</div>
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="pmnyDlnPlWna" name="pmnyDlnPlWna" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:0,groupSeparator:','" tabindex="19"/>
														</div>
													</div>
												</div> <!-- end of 지폐금액 -->
												<div class="easyui-layout" style="width:99%;height:26px">
													<div class="my-textbox1" align="left" style="float:left;">
														주화금액
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="cnFrgAmt" name="cnFrgAmt" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="21"/>
														</div>
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="cnExrt" name="cnExrt" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="22"/>
														</div>
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="cnAplExrt" name="cnAplExrt" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="23"/>
														</div>
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="cnStlmWna" name="cnStlmWna" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:0,groupSeparator:','" tabindex="25"/>
														</div>
													</div>
													<div align="left" style="width:90px;float:left">
														<div style="margin-bottom:2px">
															<input id="cnDlnPlWna" name="cnDlnPlWna" class="easyui-numberbox" style="width:80px;text-align:right" data-options="required:false,precision:0,groupSeparator:','" tabindex="24"/>
														</div>
													</div>
												</div> <!-- end of 주화금액 -->
											</div>
											<div align="left" style="width:99%;float:left">
												<div style="margin-bottom:2px">
													<input id="sumStlmWna" name="sumStlmWna" class="easyui-numberbox" label="원화정산금액" labelWidth="130px" labelAlign="right" style="width:210px;text-align:right" data-options="required:false,precision:0,groupSeparator:','" tabindex="26"/>
												</div>
												<div style="margin-bottom:2px;display:none">
													<input id="tusaTnslAmt" name="tusaTnslAmt" class="easyui-numberbox" label="대미환산금액" labelWidth="130px" labelAlign="right" style="width:255px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="27"/>
												</div>
												<div style="margin-bottom:2px;display:none">
													<input id="efmDscd" name="efmDscd" class="easyui-textbox" label="환전구분코드" labelWidth="130px" labelAlign="right" style="width:255px;text-align:right" data-options="required:false" />
												</div>
											</div>
										</div> <!--  end of 입금/지급 정보 -->
									</form>	
								</div> <!-- end of input_div -->
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
		var defaultTargetUrl="${pageContext.request.contextPath}/rest/exchange";
		var defaultRestfulType="POST";
		var c1 = '1';
		var c3 = '3';
		var c4 = '4';
				
		function formClear(){
			
			$('#tradeType').combobox('setValue', c1);
			$('#pmnyFrgAmt').textbox('clear');
			$('#cnFrgAmt').textbox('clear');

			$('#refNo').textbox('clear');
			$('#efmDscd').textbox('setValue', 'B'); // B:매입, S:매도
			$('#rnnoDscd').combobox('setValue', '1');
			$('#rnno').textbox('clear');
			$('#custNm').textbox('clear');
			$('#crcd').combobox('setValue', 'USD');
			$('#efmAmt').textbox('clear');
			$('#pmnyAmt').textbox('setValue', '0');
			$('#cnAmt').textbox('setValue', '0');
			$('#amtyDscd').combobox('setValue', '1');
			$('#ntntNtcd').combobox('setValue', 'KR');
			$('#usNtcd').combobox('setValue', 'US');
			$('#trMnbdPccd').combobox('setValue', '320');
			$('#intdRscd').combobox('setValue', '111');
			$('#pmnyExrt').textbox('clear');
			$('#cnExrt').textbox('clear');
			$('#prmRt').combobox('setValue', '0');
			$('#wnItrlkAmt').textbox('clear');
			$('#wnItrlkAct').textbox('clear');
			$('#altWna').textbox('clear');
			$('#cashWna	').textbox('clear');
			$('#pmnyAplExrt').textbox('clear');
			$('#cnAplExrt').textbox('clear');
			$('#pmnyDlnPlWna').textbox('clear');
			$('#cnDlnPlWna').textbox('clear');
			$('#pmnyStlmWna').textbox('clear');
			$('#cnStlmWna').textbox('clear');
			$('#sumStlmWna').textbox('clear');
			$('#frxcLdgrStcd').combobox('setValue', '1');
		}
				
		function setMaxLength(){
					
			// MAXLENGTH
			$("#tradeType").textbox('textbox').attr('maxlength', 1);
			$("#pmnyFrgAmt").textbox('textbox').attr('maxlength', 9);
			$("#cnFrgAmt").textbox('textbox').attr('maxlength', 9);
			$("#refNo").textbox('textbox').attr('maxlength', 15);
			$("#efmDscd").textbox('textbox').attr('maxlength', 1);
			$("#rnnoDscd").textbox('textbox').attr('maxlength', 1);
			$("#rnno").textbox('textbox').attr('maxlength', 20);
			$("#custNm").textbox('textbox').attr('maxlength', 50);
			$("#crcd").textbox('textbox').attr('maxlength', 3);
			$("#efmAmt").textbox('textbox').attr('maxlength', 9);
			$("#pmnyAmt").textbox('textbox').attr('maxlength', 9);
			$("#cnAmt").textbox('textbox').attr('maxlength', 9);
			$("#amtyDscd").textbox('textbox').attr('maxlength', 1);
			$("#ntntNtcd").textbox('textbox').attr('maxlength', 2);
			$("#usNtcd").textbox('textbox').attr('maxlength', 2);
			$("#trMnbdPccd").textbox('textbox').attr('maxlength', 3);
			$("#intdRscd").textbox('textbox').attr('maxlength', 1);
			$("#pmnyExrt").textbox('textbox').attr('maxlength', 9);
			$("#cnExrt").textbox('textbox').attr('maxlength', 9);
			$("#prmRt").textbox('textbox').attr('maxlength', 9);
			$("#wnItrlkAmt").textbox('textbox').attr('maxlength', 9);
			$("#wnItrlkAct").textbox('textbox').attr('maxlength', 20);
			$("#altWna").textbox('textbox').attr('maxlength', 9);
			$("#cashWna").textbox('textbox').attr('maxlength', 9);
			$("#pmnyAplExrt").textbox('textbox').attr('maxlength', 9);
			$("#cnAplExrt").textbox('textbox').attr('maxlength', 9);
			$("#pmnyDlnPlWna").textbox('textbox').attr('maxlength', 9);
			$("#cnDlnPlWna").textbox('textbox').attr('maxlength', 9);
			$("#pmnyStlmWna").textbox('textbox').attr('maxlength', 9);
			$("#cnStlmWna").textbox('textbox').attr('maxlength', 9);
			$("#sumStlmWna").textbox('textbox').attr('maxlength', 9);

		}
				
		function setTextBoxCss(){

			// TEXTBOX 입력시 무조건 대문자화
			$('#crcd').textbox('textbox').css('text-transform','uppercase');
		}
				
		function setTextBoxDisable(textBoxName){
			// Disable
			if(textBoxName=='all' || textBoxName=='tradeType'){
			  $('#tradeType').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='refNo'){
			  $('#refNo').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='efmDscd'){
			  $('#efmDscd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rnnoDscd'){
			  $('#rnnoDscd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rnno'){
			  $('#rnno').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='custNm'){
			  $('#custNm').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='crcd'){
			  $('#crcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='pmnyAmt'){
			  $('#pmnyAmt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='cnAmt'){
			  $('#cnAmt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='amtyDscd'){
			  $('#amtyDscd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='ntntNtcd'){
			  $('#ntntNtcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='usNtcd'){
			  $('#usNtcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='trMnbdPccd'){
			  $('#trMnbdPccd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='intdRscd'){
			  $('#intdRscd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='prmRt'){
			  $('#prmRt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='frxcLdgrStcd'){
			  $('#frxcLdgrStcd').textbox('disable');
			}
			
			setTextBoxReadOnly(textBoxName);
		}
		
		function setAmtTextBoxDisable(textBoxName){
			if(textBoxName=='all' || textBoxName=='pmnyFrgAmt'){
			  $('#pmnyFrgAmt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='cnFrgAmt'){
			  $('#cnFrgAmt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='pmnyExrt'){
			  $('#pmnyExrt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='efmAmt'){
			  $('#efmAmt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='cnExrt'){
			  $('#cnExrt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='pmnyAplExrt'){
			  $('#pmnyAplExrt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='cnAplExrt'){
			  $('#cnAplExrt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='pmnyDlnPlWna'){
			  $('#pmnyDlnPlWna').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='cnDlnPlWna'){
			  $('#cnDlnPlWna').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='pmnyStlmWna'){
			  $('#pmnyStlmWna').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='cnStlmWna'){
			  $('#cnStlmWna').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='sumStlmWna'){
			  $('#sumStlmWna').textbox('disable');
			}	
			if(textBoxName=='all' || textBoxName=='wnItrlkAmt'){
			  $('#wnItrlkAmt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='wnItrlkAct'){
			  $('#wnItrlkAct').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='altWna'){
			  $('#altWna').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='cashWna'){
			  $('#cashWna').textbox('disable');
			}
		}
		
		function setTextBoxReadOnly(textBoxName){
			
			if(textBoxName=='all' || textBoxName=='pmnyFrgAmt'){
			  $('#pmnyFrgAmt').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='cnFrgAmt'){
			  $('#cnFrgAmt').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='pmnyExrt'){
			  $('#pmnyExrt').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='efmAmt'){
			  $('#efmAmt').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='cnExrt'){
			  $('#cnExrt').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='pmnyAplExrt'){
			  $('#pmnyAplExrt').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='cnAplExrt'){
			  $('#cnAplExrt').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='pmnyDlnPlWna'){
			  $('#pmnyDlnPlWna').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='cnDlnPlWna'){
			  $('#cnDlnPlWna').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='pmnyStlmWna'){
			  $('#pmnyStlmWna').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='cnStlmWna'){
			  $('#cnStlmWna').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='sumStlmWna'){
			  $('#sumStlmWna').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='altWna'){
			  $('#altWna').textbox('readonly',true);
			}
			if(textBoxName=='all' || textBoxName=='cashWna'){
			  $('#cashWna').textbox('readonly',true);
			}
		}
				
		function setTextBoxEnable(){
			// Disable
			$('#tradeType').textbox('enable');
//			$('#pmnyFrgAmt').textbox('enable');
//			$('#cnFrgAmt').textbox('enable');
//			$('#refNo').textbox('enable');
			$('#efmDscd').textbox('enable');
			$('#rnnoDscd').textbox('enable');
			$('#rnno').textbox('enable');
			$('#custNm').textbox('enable');
			$('#crcd').textbox('enable');
			$('#efmAmt').textbox('enable');
			$('#pmnyAmt').textbox('enable');
			$('#cnAmt').textbox('enable');
			$('#amtyDscd').textbox('enable');
			$('#ntntNtcd').textbox('enable');
			$('#usNtcd').textbox('enable');
			$('#trMnbdPccd').textbox('enable');
			$('#intdRscd').textbox('enable');
			$('#prmRt').textbox('enable');
			/*
			$('#pmnyExrt').textbox('enable');
			$('#cnExrt').textbox('enable');
			$('#pmnyAplExrt').textbox('enable');
			$('#cnAplExrt').textbox('enable');
			$('#pmnyDlnPlWna').textbox('enable');
			$('#cnDlnPlWna').textbox('enable');
			$('#pmnyStlmWna').textbox('enable');
			$('#cnStlmWna').textbox('enable');
			$('#sumStlmWna').textbox('enable');
			*/

			setAmtTextBoxEnable();
		}
		
		function setAmtTextBoxEnable(){
			$('#pmnyExrt').textbox('enable');
			$('#cnExrt').textbox('enable');
			$('#pmnyAplExrt').textbox('enable');
			$('#cnAplExrt').textbox('enable');
			$('#pmnyDlnPlWna').textbox('enable');
			$('#cnDlnPlWna').textbox('enable');
			$('#pmnyStlmWna').textbox('enable');
			$('#cnStlmWna').textbox('enable');
			$('#sumStlmWna').textbox('enable');	
			$('#wnItrlkAmt').textbox('enable');
			$('#wnItrlkAct').textbox('enable');
			$('#altWna').textbox('enable');
			$('#cashWna').textbox('enable');
			$('#pmnyFrgAmt').textbox('enable');
			$('#cnFrgAmt').textbox('enable');
		}
				
		function getRawData(){
			
			rawData = new Object();
			rawData.tradeType = $('#tradeType').val();
			rawData.pmnyFrgAmt = $('#pmnyFrgAmt').val();
			rawData.cnFrgAmt = $('#cnFrgAmt').val();
			rawData.refNo = $('#refNo').val();
			rawData.efmDscd = $('#efmDscd').val();
			rawData.rnnoDscd = $('#rnnoDscd').val();
			rawData.rnno = $('#rnno').val();
			rawData.custNm = $('#custNm').val();
			rawData.crcd = $('#crcd').val().toUpperCase();
			rawData.efmAmt = $('#efmAmt').val();
			rawData.pmnyAmt = $('#pmnyAmt').val();
			rawData.cnAmt = $('#cnAmt').val();
			rawData.amtyDscd = $('#amtyDscd').val();
			rawData.ntntNtcd = $('#ntntNtcd').val();
			rawData.usNtcd = $('#usNtcd').val();
			rawData.trMnbdPccd = $('#trMnbdPccd').val();
			rawData.intdRscd = $('#intdRscd').val();
			rawData.pmnyExrt = $('#pmnyExrt').val();
			rawData.cnExrt = $('#cnExrt').val();
			rawData.prmRt = $('#prmRt').val();
			rawData.pmnyAplExrt = $('#pmnyAplExrt').val();
			rawData.cnAplExrt = $('#cnAplExrt').val();
			rawData.pmnyDlnPlWna = $('#pmnyDlnPlWna').val();
			rawData.cnDlnPlWna = $('#cnDlnPlWna').val();
			rawData.pmnyStlmWna = $('#pmnyStlmWna').val();
			rawData.cnStlmWna = $('#cnStlmWna').val();
			rawData.sumStlmWna = $('#sumStlmWna').val();
			rawData.tusaTnslAmt = $('#tusaTnslAmt').val();
			rawData.wnItrlkAmt = $('#wnItrlkAmt').val();
			rawData.wnItrlkAct = $('#wnItrlkAct').val();
			rawData.altWna = $('#altWna').val();
			rawData.cashWna = $('#cashWna').val();

			return rawData;
		}
				
		function searchData(){
					
			var searchStartDate = $('#searchStartDate').val().replace(/-/g, '');
			var searchEndDate = $('#searchEndDate').val().replace(/-/g, '');
			var brno = '';
			var efmDscd = '';
			var searchRefNo = $('#searchRefNo').val();

			if(searchStartDate=='' || searchStartDate.length!=8){
				searchStartDate = getToday();
			}
			if(searchEndDate=='' || searchEndDate.length!=8){
				searchEndDate = getToday();
			}

			var varUrl = '${pageContext.request.contextPath}/rest/exchangeSearchList?startDate='+searchStartDate+'&endDate='+searchEndDate+'&brno='+brno+'&efmDscd='+efmDscd+'&refNo='+searchRefNo;
			console.log(varUrl);

			// 검색 날짜 검증
			if(searchStartDate > searchEndDate){
				$.messager.show({    // show error message
					title: 'Error',
					msg: '기준일자의 시작일이 종료일 이후 날짜입니다. 다시 입력해주세요.'
				});	
				$('#searchStartDate').textbox('textbox').focus();
				return;
			}

			// DATAGRID LOAD
			$('#dg').datagrid({
				url: varUrl,
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
					setAmtTextBoxEnable();
							
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
			setTextBoxDisable('firstDate');
			setTextBoxDisable('lastDate');
			setMaxLength();
					
			setButtonDisable();
			setButtonEnable('initBtn');
			setButtonEnable('saveBtn');
			setAmtTextBoxEnable();
					
			targetUrl="${pageContext.request.contextPath}/rest/exchange";
			restfulType = "POST";
					
		}

		function editData(){
		}
				
		function saveData(){
			var message;			
			
			// 필수입력값 검증
			if(checkValidation()==false){
				return;
			}
			
			var tradeType = $('#tradeType').val();
			if(tradeType=='1' || tradeType==c1){
				message = '외국통화 매입 거래를 실행하시겠습니까?';
			}else
			if(tradeType=='3' || tradeType==c3){
				message = '외국통화 매입 거래를 취소하시겠습니까?';
			}
					
			$.messager.confirm('Confirm',message,function(r){
				if (r){
					rawData = getRawData();
					console.log(JSON.stringify(rawData));
							
					targetUrl="${pageContext.request.contextPath}/rest/exchange";
							
					// 1-등록, 3-취소
					if($('#tradeType').val()=='1'){

						restfulType = "POST";
					}else 
					if($('#tradeType').val()=='3'){

						targetUrl += "/"+rawData.refNo;
						restfulType = "PUT";
					}else{
						showErrMsg('거래 구분이 잘못되었습니다.');
						return;
					}

					console.log("rawData.refNo="+rawData.refNo);
					console.log("targetUrl="+targetUrl);
					console.log("restfulType="+restfulType);
							
					jQuery.ajax({
						type:restfulType,
						url:targetUrl,
						contentType: 'application/json',
						data: JSON.stringify(rawData),
						dataType:"json",
						success:function(data){
							$('#dg').datagrid('reload');    // reload the user data

//							initData();
							setTextBoxDisable('all');
							setAmtTextBoxDisable('all');
							setButtonDisable();
							setButtonEnable('initBtn');

							$('#refNo').textbox('setValue', data.refNo);
							
							if($('#tradeType').val()=='3'){
								$('#frxcLdgrStcd').combobox('setValue', '취소');
							}

							$.messager.show({    // show error message
								title: 'Message',
								msg: '정상처리되었습니다.'
							});
						},
						error:function(request,status,error){
							console.log(request);
							$.messager.show({    // show error message
								title: 'Error',
								msg: getPureErrMsg(request)
							});
						}    		
					});	
				}
			});
		}

		function cancelData(){
		}
		
		function initSearch(){

			console.log("TODAY:"+getFormatDate());
			$('#searchStartDate').textbox('setValue', getFormatDate());
			$('#searchEndDate').textbox('setValue', getFormatDate());

		}

		function preCalc(){
			var tradeType = $('#tradeType').val();
			var crcd = $('#crcd').val();
			var prmRt = $('#prmRt').val();
			var pmnyAmt = $('#pmnyAmt').val();
			var cnAmt = $('#cnAmt').val();
			var efmDscd = $('#efmDscd').val();
			var efmAmt = parseFloat(pmnyAmt) + parseFloat(cnAmt);
			var url ="${pageContext.request.contextPath}/rest/exchangePreCalc?crcd="+crcd+"&prmRt="+prmRt+"&pmnyAmt="+pmnyAmt+"&cnAmt="+cnAmt+"&efmDscd="+efmDscd;
			var isSearch = $('#isSearch').val();
			
//			console.log("tradeType:"+tradeType);
			if(tradeType == c3 || tradeType == '3'
			|| tradeType == c4 || tradeType == '4'
			|| isSearch == 'Y'){
				return;
			}

			// 외국통화 합계 자동 계산
			$('#efmAmt').numberbox('setValue', efmAmt);	
		
			// 고시환율, 적용환율, 원화금액, 거래이익, 원화정산금액 가져오기
			if(crcd != '' && prmRt != '' && (pmnyAmt != 0 || cnAmt != 0)){
				jQuery.ajax({
					type:'get',
					url: url,
					contentType: 'application/json',
					dataType:"json",
					success:function(data, status, xhr){
						
						console.log(data);
						
						setCalcResult(data);
			
					},
					error:function(request,status,error){

						$.messager.show({    // show error message
							title: 'Error',
							msg: getPureErrMsg(request)
						});
					}    		
				});	
			}
		}
		
		function setCalcResult(data){
			
			$('#pmnyExrt').numberbox('setValue', data.pmnyExrt);
			$('#cnExrt').numberbox('setValue', data.cnExrt);
			$('#pmnyAplExrt').numberbox('setValue', data.pmnyAplExrt);
			$('#cnAplExrt').numberbox('setValue', data.cnAplExrt);
			$('#pmnyDlnPlWna').numberbox('setValue', data.pmnyDlnPlWna);
			$('#cnDlnPlWna').numberbox('setValue', data.cnDlnPlWna);
			$('#pmnyStlmWna').numberbox('setValue', data.pmnyStlmWna);
			$('#cnStlmWna').numberbox('setValue', data.cnStlmWna);
			$('#sumStlmWna').numberbox('setValue', data.sumStlmWna);
			$('#tusaTnslAmt').numberbox('setValue', data.tusaTnslAmt);
			//$('#prmRt').combobox('setValue', data.prmRt+'%');
			
			$('#cashWna').numberbox('setValue', data.sumStlmWna);
			$('#altWna').numberbox('setValue', 0);
			$('#wnItrlkAmt').numberbox('setValue', 0);
	
			
		}
		
		function searchDetail(){
			var row = $('#dg').datagrid('getSelected');
			
			if (row){
				
				$('#isSearch').val('Y'); // 조회 시에는 금액선조회(preCalc)가 동작하지 않도록 하기 위해서
				$('#fm').form('load',row);
				setTimeout(function(row) {$('#isSearch').val('N');}, 500);
				
				setTextBoxDisable('all');
				setAmtTextBoxDisable('all');
				$('#tradeType').textbox('enable');

				setButtonDisable();
				setButtonEnable('initBtn');

				$('#tradeType').combobox('setValue', c4);
			}
			
		}
		
		function parDetail(){
			var	data = $('#dg').datagrid('getData');
			
			if (data.rows[0]){
				
				$('#isSearch').val('Y');
				$('#fm').form('load',data.rows[0]);
				setTimeout(function(row) {
					$('#isSearch').val('N');
				}, 500);
				
				setTextBoxDisable('all');
				setAmtTextBoxDisable('all');
				$('#tradeType').textbox('enable');
				
				setButtonDisable();
				setButtonEnable('initBtn');

				$('#tradeType').combobox('setValue', c4);
			}
		}
		
		function checkTradeType(newValue, oldValue){
			
			var frxcLdgrStcd = $('#frxcLdgrStcd').val();
			
			var refNo = $('#refNo').val();
			if(newValue == '1' || newValue == c1){
				// 조회된 상태인지 확인
				if(refNo != ''){
					setTradeType(oldValue);
					$.messager.show({    // show error message
						title: 'Error',
						msg: '정상/등록 거래는 새로고침 누른 후 이용해 주세요.'
					});
					return;
				}
			}else{

				if(newValue == '3' || newValue == c3){
					
					if(frxcLdgrStcd=='9' || frxcLdgrStcd=='취소'){
						setTradeType(oldValue);
						$.messager.show({    // show error message
							title: 'Error',
							msg: '외환원장 상태가 취소인 거래는 다시 취소할 수 없습니다.'
						});
						return;	
					}

				}

				// 조회 후 거래 확인
				if(refNo == ''){
					setTradeType(oldValue);
					$.messager.show({    // show error message
						title: 'Error',
						msg: '그리드에서 조회 완료 후 이용해 주세요.'
					});
					return;
				}	
			}
			
			setButtonDisable();
			if(newValue == '1' || newValue == c1){
				setButtonEnable('saveBtn');
			}else
			if(newValue == '3' || newValue == c3){
				setButtonEnable('initBtn');
				setButtonEnable('saveBtn');
			}else
			if(newValue == '4' || newValue == c4){
				setButtonEnable('initBtn');

			}
		}
		
		function setTradeType(val){
			
			console.log('val:'+val);

			if(val==c1 || val=='1'){
				$('#tradeType').combobox('setValue', c1);	
			}else
			if(val==c3 || val=='3'){
				$('#tradeType').combobox('setValue', c3);	
			}else
			if(val==c4 || val=='4'){
				$('#tradeType').combobox('setValue', c4);	
			}
		}
		
		function checkValidation(){
			
			// 필수체크
			var rnno = $('#rnno').val();
			if(rnno==''){
				showErrMsg('<font color=red>실명번호</font>는 필수 입력사항입니다.');
				return false;
			}
			var rnnoDscd = $('#rnnoDscd').val();
			if(rnnoDscd==''){
				showErrMsg('<font color=red>실명번호 구분</font>은 필수 입력사항입니다.');
				return false;
			}
			var custNm = $('#custNm').val();
			if(custNm==''){
				showErrMsg('<font color=red>고객명</font>은 필수 입력사항입니다.');
				return false;
			}
			var crcd = $('#crcd').val();
			if(crcd==''){
				showErrMsg('<font color=red>통화</font>는 필수 입력사항입니다.');
				return false;
			}
			var pmnyAmt = parseInt($('#pmnyAmt').val());
			var cnAmt = parseInt($('#cnAmt').val());
			if(pmnyAmt==0 && cnAmt==0){
				showErrMsg('<font color=red>금액</font>은 필수 입력사항입니다. <font color=red>지폐금액</font> 또는 <font color=red>주화금액</font>을 입력하세요');
				return false;
			}
			var wnItrlkAmt = parseInt($('#wnItrlkAmt').val());
			var wnItrlkAct = $('#wnItrlkAct').val();
			if(wnItrlkAmt > 0 && wnItrlkAct==''){
				showErrMsg('원화연동금액 입력시 <font color=red>원화계좌번호</font>는 필수 입력사항입니다.');
				return false;
			}
			if(wnItrlkAct!='' && wnItrlkAmt==0 ){
				showErrMsg('원화계좌번호 입력시 <font color=red>원화연동금액</font>은 필수 입력사항입니다.');
				return false;
			}

			// 관계성 체크
			
			// 유효성 검증
			/*
			var rnnoDscd = $('#rnnoDscd').val();
			console.log("rnnoDscd:"+rnnoDscd);
			if(rnnoDscd=='1' && !checkJumin(rnno)){
				showErrMsg('주민번호검증 오류입니다. 입력내용을 확인해주세요');
				return false;
			}else
			if(rnnoDscd=='2' && !checkFgnno(rnno)){
				showErrMsg('여권 검증 오류입니다. 입력내용을 확인해주세요');
				return false;
			}
			*/
			
			return true;
		}
		
		function parentData(){
			var parData = $('#parData').val(); 
			console.log("parData:"+parData);
			
			if(parData != null && parData != ''){
				// DATAGRID LOAD
				$('#dg').datagrid({
					url: '${pageContext.request.contextPath}/rest/exchange/' + parData,
					onLoadSuccess:function(){
								
						var rows = $('#dg').datagrid('getRows').length;
						parDetail();
						
					},
					onLoadError:function(){
						$.messager.show({    // show error message
							title: 'Error',
							msg: '조회 중 에러가 발생했습니다.'
						});
					}
				});
			}
		}
		
		function commonCode(){
			// TEXTBOX OnChange Event
			$('#tradeType').combobox({
				onChange: function(newValue, oldValue){
					checkTradeType(newValue, oldValue);
				},
		   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=TRADE_TYPE',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '거래구분',
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
				})
			});
			
			$('#rnnoDscd').combobox({
		   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=RNNO_DSCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '실명번호구분',
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
				})
			});
			
			$('#crcd').combobox({
				onChange: function(newValue, oldValue){
					preCalc();
				},
				url:'${pageContext.request.contextPath}/rest/currCodeList',
				method:'get',
				valueField:'value',
				textField:'text',
				label: '통화',
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
				})
			})
			
			$('#amtyDscd').combobox({
		   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=AMTY_DSCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '거주성',
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
				})
			});
			
			$('#usNtcd').combobox({
				url:'${pageContext.request.contextPath}/rest/ctryCodeList',
				method:'get',
				valueField:'value',
				textField:'text',
				label: '상대국가',
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
				})
			})
			
			$('#ntntNtcd').combobox({
				url:'${pageContext.request.contextPath}/rest/ctryCodeList',
				method:'get',
				valueField:'value',
				textField:'text',
				label: '국적',
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
				})
			})
			
			$('#trMnbdPccd').combobox({
		   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=TR_MNBD_PCCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '거래주체',
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
				})
			});
			
			$('#intdRscd').combobox({
		   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=INTD_RSCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '사유코드',
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
				})
			});
			
			$('#prmRt').combobox({
				onChange: function(newValue, oldValue){
					preCalc();
				},
				url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=PRM_RT',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '우대율',
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
				})
			});
			
			$('#frxcLdgrStcd').combobox({
		   		url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=FRXC_LDGR_STCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '외환원장상태',
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
				})
			});
		}
	
		// TEXTBOX enter event
		$(document).ready(function(){

			// TEXTBOX에서 엔터 입력시 조회실행
			var t = $('#searchRefNo');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchData();
				}
			});	
					
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
					{field:'refNo',			title:'참조번호',		width:'13%',sortable:true,halign:'center', align:'center', 								sorter:sorter },
					{field:'trDt',			title:'거래일자',		width:'13%',sortable:true,halign:'center', align:'center',	formatter:formatDate, 		sorter:sorter },
					{field:'custNo',		title:'고객번호',		width:'13%',sortable:true,halign:'center', align:'center', 								sorter:sorter },
					{field:'custNm',		title:'고객명',		width:'13%',sortable:true,halign:'center', align:'left', 								sorter:sorter },
					{field:'crcd',			title:'통화코드',		width:'10%',sortable:true,halign:'center', align:'center', 								sorter:sorter },
					{field:'efmAmt',		title:'환전금액',		width:'13%',sortable:true,halign:'center', align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'pmnyExrt',		title:'적용환율',		width:'13%',sortable:true,halign:'center', align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'frxcLdgrStcd',	title:'외환원장상태',	width:'12%',sortable:true,halign:'center', align:'center',							 	sorter:sorter }
				]]
			});
			
			commonCode();
			
			$('#pmnyAmt').numberbox({
				onChange: function(newValue, oldValue){
					$('#pmnyFrgAmt').numberbox('setValue', newValue);
					preCalc();
				}	
			});
			$('#cnAmt').numberbox({
				onChange: function(newValue, oldValue){
					$('#cnFrgAmt').numberbox('setValue', newValue);
					preCalc();
				}	
			});
			
			$('#wnItrlkAmt').numberbox({
				onChange: function(newValue, oldValue){
					// 원화정산금액
					var sumStlmWna = $('#sumStlmWna').val();
					var altWna = $('#altWna').val();
					var cashWna = $('#cashWna').val();

					newValue = parseInt(newValue);
					sumStlmWna = parseInt(sumStlmWna);
					altWna = parseInt(altWna);
					cashWna = parseInt(cashWna);

					// 현금금액 = 정산금액 - 원화연동금액 - 입력금액
					var cashWna = sumStlmWna - newValue;
					
					if(sumStlmWna=='' || sumStlmWna==0){
						return;
					}
					
					if($('#isSearch').val()=='Y'){
						return;
					}
					
					if(newValue < 0){
						showErrMsg('마이너스 금액은 입력할 수 없습니다.');
						return;
					}
					console.log("newValue:"+newValue);
					console.log("sumStlmWna:"+sumStlmWna);
					/*
					if(newValue > sumStlmWna){
						showErrMsg('입력하신 금액이 원화정산금액보다 큽니다. 작거나 같게 입력해주세요.');
						$('#wnItrlkAmt').numberbox('setValue', 0);
						return;
					}
					*/
					if(sumStlmWna>0 && newValue>0 && newValue != sumStlmWna){
						showErrMsg('원화연동금액은 원화정산금액과 동일해야합니다. 전체 금액 중 일부만 원화연동금액으로 입력할 수 없습니다.');
						$('#wnItrlkAmt').numberbox('setValue', 0);
						return;
					}
					$('#cashWna').numberbox('setValue', cashWna);
					$('#altWna').numberbox('setValue', newValue);
				}	
			});
			
			document.onkeydown = fkey;
			function fkey(e){
			    e = e || window.event;
			 
			    if(e.keyCode == 116){
			        location.href = "${pageContext.request.contextPath}/exchange/exchangeBuy";
			    }
			}
			
			$('#cancelBtn').hide();
			$('#editBtn').hide();
			setMenuPannel();
			
			setInputDivSizeType3('mainBiz');	
					
		});
		
		window.onload = setTimeout(initData, 100);
		window.onload = setTimeout(initSearch, 200);
		window.onload = setTimeout(parentData, 300);
		
		$('#main_content_div').css("display","block");
				
		var minHeight=700;
		var minWidth=970;
				
	</script>	
</body>
</html>
