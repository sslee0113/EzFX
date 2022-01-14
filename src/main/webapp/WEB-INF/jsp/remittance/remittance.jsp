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
						<div id="menu_div" data-options="region:'west',split:true" title="메뉴" style="width:200px;">
							<%@ include file="/WEB-INF/jsp/menu/roleMenu.jsp"%>
						</div>
						<!-- RIGHT CONTENT -->
						<div id="contents_div" data-options="region:'center',footer:'#footer'" style="padding:3px 3px 3px 3px">
							<h2 align="center" style="margin-bottom:5px; padding:0px 0px 0px 0px"><%=selectedMenuName %></h2>
							<div id="grid_accordion" class="easyui-accordion" data-options="multiple:true" style="width:100%">
								<div id="grid_div" title="검색결과" style="width:'auto';height:300px;" data-options="selected:false">
									<table id="dg" class="easyui-datagrid" style="width:100%;height:265px" 
													view="scrollview"
													method="get" toolbar="#tb" pagination="false"
													rownumbers="true" fitColumns="true" singleSelect="true">
										<thead>
											<tr>
												<th field="refNo" width="13%" sortable="false" data-options="align:'center'"><center>참조번호</center></th>
												<th field="trDt" width="13%" sortable="false" data-options="align:'center',formatter:formatDate"><center>거래일자</center></th>
												<th field="rmprCustNo" width="13%" sortable="false" data-options="align:'center'"><center>고객번호</center></th>
												<th field="rmprKrFirstNm" width="13%" sortable="false" data-options="align:'left'"><center>고객명</center></th>
												<th field="crcd" width="10%" sortable="false" data-options="align:'center'"><center>통화코드</center></th>
												<th field="owmnAmt" width="13%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>송금금액</center></th>
												<th field="aplExrt" width="13%" sortable="false" data-options="align:'right',formatter:formatDecimal"><center>적용환율</center></th>
												<th field="frxcLdgrStcd" width="12%" sortable="false" data-options="align:'center'"><center>외환원장상태</center></th>
											</tr>
										</thead>
									</table>
									<div id="tb" style="padding:2px 5px;">
										<input id="searchStartDate" name="searchStartDate" class="easyui-datebox" label="거래일자" labelWidth="70px" labelAlign="right" style="width:180px" data-options="required:false,formatter:myformatter,parser:myparser" />
										~
										<input id="searchEndDate" name="searchEndDate" class="easyui-datebox" style="width:100px" data-options="required:false,formatter:myformatter,parser:myparser" />
										<input id="searchRefNo" name="searchRefNo" class="easyui-textbox" label="참조번호" labelWidth="70px" labelAlign="right" style="width:205px" data-options="required:true" tabindex="2"/>
										<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()">조회</a>
									</div>
								</div>
								<div id="input_div" title="입력화면" style="width:100%;height:670px;padding:5px;" data-options="selected:true">
									<form id="fm" method="post" novalidate style="margin:0;padding:20px 20px">
										<input id="isSearch" type="hidden" name="isSearch" value="N"/>
										<div align="left" style="width:49%;float:left">
											<div style="margin-bottom:2px">
												<input id="tradeType" class="easyui-combobox" name="tradeType" style="width:240px" tabindex="1" />
											</div>
											<div style="margin-bottom:2px">
												<input id="rmprRnnoDscd" class="easyui-combobox" name="rmprRnnoDscd" style="width:260px" tabindex="3" />
											</div>
											<div style="margin-bottom:2px">
												<input id="rmtKdcd" class="easyui-combobox" name="rmtKdcd" style="width:260px" tabindex="5" />
											</div>
										</div>
										<div align="left" style="width:49%;float:left">
											<div style="margin-bottom:2px">
												<input id="refNo" name="refNo" class="easyui-textbox" label="참조번호" labelWidth="130px" labelAlign="right" style="width:270px" data-options="required:true" tabindex="2"/>
												<input type="hidden" id="parData" name="parData" class="easyui-textbox" value="${map.refNo}"></input>
											</div>
											<div style="margin-bottom:2px">
												<input id="rmprRnno" name="rmprRnno" class="easyui-textbox" label="실명번호" labelWidth="130px" labelAlign="right" style="width:270px" data-options="required:true" tabindex="4"/>
											</div>
											<div style="margin-bottom:2px">
												<input id="crcd" class="easyui-combobox" name="crcd" style="width:195px;" tabindex="6" />
												<input id="owmnAmt" name="owmnAmt" class="easyui-numberbox" style="width:70px;text-align:right" data-options="required:true,precision:2,groupSeparator:','" tabindex="7"/>
											</div>
										</div>
										<div class="easyui-layout" style="width:100%;height:10px">
											&nbsp; <!-- 빈줄 간격 만들기 -->
										</div>
										<div id="tt" class="easyui-tabs" style="width:99%;height:270px">
											<div title="송금 의뢰인 정보" style="padding:5px">
												<div align="left" style="width:49%;float:left">
													<div style="margin-bottom:2px">
														<input id="rmprKrLastNm" name="rmprKrLastNm" class="easyui-textbox" label="성명(이름)" labelWidth="125px" labelAlign="right" style="width:270px;text-align:left" data-options="required:true" tabindex="8"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="rmprAmtyDscd" class="easyui-combobox" name="rmprAmtyDscd" style="width:230px" tabindex="10" />
													</div>
													<div>
														<div style="float:left;margin-bottom:2px">
															<input id="rmprSitZip" name="rmprSitZip" class="easyui-textbox" label="우편번호" labelWidth="125px" labelAlign="right" style="width:180px;text-align:left" data-options="required:true" tabindex="12"/>
														</div>
														<div style="float:left;padding-left:3px">
															<%@ include file="/WEB-INF/jsp/inc/zipcodeWindow.jsp"%>
														</div>
													</div>
												</div>
												<div align="left" style="width:49%;float:left">
													<div style="margin-bottom:2px">
														<input id="rmprKrFirstNm" name="rmprKrFirstNm" class="easyui-textbox" label="성명(성)" labelWidth="130px" labelAlign="right" style="width:270px;text-align:left" data-options="required:true" tabindex="9"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="rmprNtntNtcd" class="easyui-combobox" name="rmprNtntNtcd" style="width:190px;" tabindex="11" />
													</div>
													<div style="margin-bottom:2px">
														<input id="rmprSitNtcd" class="easyui-combobox" name="rmprSitNtcd" style="width:190px;" tabindex="13" />
													</div>
												</div>
												<div class="easyui-layout" style="width:100%;height:2px"></div>
												<div align="left" style="width:99%;float:left">
													<div style="margin-bottom:2px">
														<input id="rmprAdr1" name="rmprAdr1" class="easyui-textbox" label="주소" labelWidth="125px" labelAlign="right" style="width:650px;text-align:left" data-options="required:true" tabindex="14"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="rmprAdr2" name="rmprAdr2" class="easyui-textbox" label="상세주소" labelWidth="125px" labelAlign="right" style="width:650px;text-align:left" data-options="required:true" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:49%;float:left">
													<div style="margin-bottom:2px">
														<input id="rmprTlno" name="rmprTlno" class="easyui-textbox" label="전화번호" labelWidth="125px" labelAlign="right" style="width:240px;text-align:left" data-options="required:false" tabindex="16"/>
													</div>
												</div>
												<div align="left" style="width:49%;float:left">
													<div style="margin-bottom:2px">
														<input id="rmprCellNo" name="rmprCellNo" class="easyui-textbox" label="핸드폰번호" labelWidth="130px" labelAlign="right" style="width:240px;text-align:left" data-options="required:false" tabindex="17"/>
													</div>
												</div>
											</div>
											<div title="수취인 정보" style="padding:5px">
												<div align="left" style="width:49%;float:left">
													<div style="margin-bottom:2px">
														<input id="adreEnFirstNm" name="adreEnFirstNm" class="easyui-textbox" label="성명(이름)" labelWidth="125px" labelAlign="right" style="width:270px;text-align:left" data-options="required:true" tabindex="18"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="adreNtcd" class="easyui-combobox" name="adreNtcd" style="width:190px;" tabindex="20" />
													</div>
													<div style="margin-bottom:2px">
														<input id="adreState" name="adreState" class="easyui-textbox" label="주(STATES)" labelWidth="125px" labelAlign="right" style="width:270px;text-align:left" data-options="required:false" tabindex="21"/>
													</div>
												</div>
												<div align="left" style="width:49%;float:left">
													<div style="margin-bottom:2px">
														<input id="adreEnLastNm" name="adreEnLastNm" class="easyui-textbox" label="성명(성)" labelWidth="125px" labelAlign="right" style="width:270px;text-align:left" data-options="required:true" tabindex="19"/>
													</div>
													<div class="easyui-layout" style="width:100%;height:25px">
														&nbsp; <!-- 빈칸 간격 만들기 -->
													</div>
													<div style="margin-bottom:2px">
														<input id="adreCiy" name="adreCiy" class="easyui-textbox" label="지급도시(CITY)" labelWidth="125px" labelAlign="right" style="width:270px;text-align:left" data-options="required:false" tabindex="22"/>
													</div>
												</div>
												<div align="left" style="width:99%;float:left">
													<div style="margin-bottom:2px">
														<input id="adreAdr1" name="adreAdr1" class="easyui-textbox" label="주소1" labelWidth="125px" labelAlign="right" style="width:650px;text-align:left" data-options="required:true" tabindex="23"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="adreAdr2" name="adreAdr2" class="easyui-textbox" label="주소2" labelWidth="125px" labelAlign="right" style="width:650px;text-align:left" data-options="required:false" tabindex="24"/>
													</div>
												</div>
												<div align="left" style="width:99%;float:left">
													<div style="margin-bottom:2px">
														<input id="adreTlno" name="adreTlno" class="easyui-textbox" label="전화번호" labelWidth="125px" labelAlign="right" style="width:240px;text-align:left" data-options="required:true" tabindex="25"/>
													</div>
													<div style="margin-bottom:2px">
														<input id="rcvgBnkCd" name="rcvgBnkCd" class="easyui-textbox" label="수취기관번호" labelWidth="125px" labelAlign="right" style="width:240px;text-align:left" data-options="required:false" tabindex="26"/>
														<!-- 
														<input id="rcvgBnkNm" name="rcvgBnkNm" class="easyui-textbox" style="width:270px;text-align:left" data-options="required:false" tabindex="27"/>
														 -->
													</div>
												</div>
												<div align="left" style="width:49%;float:left">
													<div style="margin-bottom:2px">
														<input id="adreAcno" name="adreAcno" class="easyui-textbox" label="수취인 계좌번호" labelWidth="125px" labelAlign="right" style="width:270px;text-align:left" data-options="required:false" tabindex="28"/>
													</div>
												</div>
												<div align="left" style="width:49%;float:left">
													<div style="margin-bottom:2px">
														<input id="feeAmtWna" name="feeAmtWna" class="easyui-numberbox" label="송금 수수료" labelWidth="125px" labelAlign="right" style="width:270px;text-align:left" data-options="required:false,formatter:formatInteger" tabindex="28"/>
													</div>
												</div>
											</div>
										</div>
										<div class="easyui-layout" style="width:99%;height:10px">
												&nbsp; <!-- 빈줄 간격 만들기 -->
										</div>
										<div class="easyui-layout" style="width:99%">
											<div style="margin-bottom:2px">
												<input id="crcCnclNm" name="crcCnclNm" class="easyui-textbox" label="정정/취소 사유" labelWidth="130px" labelAlign="right" style="width:680px;text-align:left" data-options="required:false" tabindex="29"/>
											</div>
										</div>
										<div style="margin-bottom:2px;display:block">
											<input id="frxcLdgrStcd" class="easyui-combobox" name="frxcLdgrStcd" style="width:200px;" />
										</div>
										<div class="easyui-layout" style="width:99%;height:10px">
												&nbsp; <!-- 빈줄 간격 만들기 -->
										</div>
										<!-- 입금 / 지급 정보  -->
										<div id="p" class="easyui-panel" title="입금/지급 정보" style="width:99%;height:150px;padding:5px;">
											<div align="left" style="width:49%;float:left">
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
											<div align="left" style="width:35%;float:left">
												<div style="margin-bottom:2px">
													<input id="prmRt" class="easyui-combobox" name="prmRt" style="width:200px;" tabindex="14" />
												</div>
												<div style="margin-bottom:2px">
													<input id="basicRate" name="basicRate" class="easyui-numberbox" label="고시환율" labelWidth="130px" labelAlign="right" style="width:230px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="34"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="aplExrt" name="aplExrt" class="easyui-numberbox" label="적용환율" labelWidth="130px" labelAlign="right" style="width:230px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="36"/>
												</div>
												<div style="margin-bottom:2px">
													<input id="dlnPlWna" name="dlnPlWna" class="easyui-numberbox" label="거래이익" labelWidth="130px" labelAlign="right" style="width:230px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="38"/>
												</div>
											</div>
											<div align="right" style="width:15%;float:left">
												<a id="preCalcBtn" href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="preCalc('btn')" style="width:90px">금액선조회</a>
											</div>

											<div style="margin-bottom:2px;display:none">
												<input id="quotSeq" name="quotSeq" class="easyui-numberbox" label="고시회차" labelWidth="130px" labelAlign="right" style="width:230px;text-align:right" data-options="required:true" tabindex="38"/>
											</div>
											<div style="margin-bottom:2px;display:none">
												<input id="tusaTnslAmt" name="tusaTnslAmt" class="easyui-numberbox" label="대미환산금액" labelWidth="130px" labelAlign="right" style="width:230px;text-align:right" data-options="required:true" tabindex="38"/>
											</div>
											<div style="margin-bottom:2px;display:none">
												<input id="zipCode" name="zipCode" class="easyui-textbox"  label="우편번호" labelWidth="130px" labelAlign="right" style="width:180px" data-options="required:false" tabindex="13"/>
											</div>
											<div style="margin-bottom:2px;display:none">
												<input id="addr1" name="addr1" class="easyui-textbox" label="한글주소1" labelWidth="130px" labelAlign="right" style="width:95%" data-options="required:false" tabindex="14"/>
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
	<script type="text/javascript">
		var contextPath = '${pageContext.request.contextPath}';
		var url;
		var rawData;
		var restfulType,targetUrl,param;
		var defaultTargetUrl="${pageContext.request.contextPath}/rest/remittance";
		var defaultRestfulType="POST";
		var c1 = '1';
		var c3 = '3';
		var c4 = '4';
				
		function formClear(){
			
			$('#tradeType').combobox('setValue', c1);
			
			$('#refNo').textbox('clear');
			$('#rmtKdcd').combobox('setValue', '1');
			$('#crcd').textbox('clear');
			$('#owmnAmt').textbox('setValue', '0');
			$('#basicRate').textbox('clear');
			$('#prmRt').textbox('setValue', '0');
			$('#aplExrt').textbox('clear');
			$('#dlnPlWna').textbox('setValue', '0');
			$('#rmprRnnoDscd').combobox('setValue', '1');
			$('#rmprRnno').textbox('clear');
			$('#rmprKrFirstNm').textbox('clear');
			$('#rmprKrLastNm').textbox('clear');
			$('#rmprAdr1').textbox('clear');
			$('#rmprAdr2').textbox('clear');
			$('#rmprTlno').textbox('clear');
			$('#rmprCellNo').textbox('clear');
			$('#rmprNtntNtcd').textbox('clear');
			$('#rmprAmtyDscd').combobox('setValue', '2');
			$('#rmprSitNtcd').textbox('clear');
			$('#rmprSitZip').textbox('clear');
			$('#adreEnFirstNm').textbox('clear');
			$('#adreEnLastNm').textbox('clear');
			$('#adreAdr1').textbox('clear');
			$('#adreAdr2').textbox('clear');
			$('#adreAcno').textbox('clear');
			$('#adreNtcd').textbox('clear');
			$('#rcvgBnkCd').textbox('clear');
			$('#feeAmtWna').textbox('setValue', '0');
			$('#cashWna').textbox('setValue', '0');
			$('#frxcLdgrStcd').combobox('setValue', '1');
			$('#firstDate').textbox('clear');
			$('#firstTime').textbox('clear');
			$('#lastDate').textbox('clear');
			$('#lastTime').textbox('clear');
			$('#ntntNtcd').textbox('clear');
			$('#usNtcd').textbox('clear');
			$('#rmprNtntNtcd').textbox('clear');
			$('#rmprSitNtcd').textbox('clear');
			$('#adreNtcd').textbox('clear');
			$('#adreCiy').textbox('clear');
			$('#adreTlno').textbox('clear');
			$('#wnItrlkAmt').textbox('clear');
			$('#wnItrlkAct').textbox('clear');
			$('#altWna').textbox('setValue', '0');

//			$('#trMnbdPccd').textbox('setValue', '320-개인기타');
//			$('#intdRscd').textbox('setValue', '111-유학 및 훈련');

			$('#searchZipcode').textbox('clear');
			$('#searchProvince').textbox('clear');
			$('#searchRoadName').textbox('clear');
			$('#searchMainBuildingNo').textbox('clear');
			
			$('#zipcodeDg').datagrid('loadData', {"total":0,"rows":[]});

		}

		function setMaxLength(){
			
			// MAXLENGTH
			$("#tradeType").textbox('textbox').attr('maxlength', 1);
			
			$("#refNo").textbox('textbox').attr('maxlength', 15);
			$("#crcd").textbox('textbox').attr('maxlength', 3);
			$("#owmnAmt").textbox('textbox').attr('maxlength', 9);
			$("#crcCnclNm").textbox('textbox').attr('maxlength', 100);
			$("#basicRate").textbox('textbox').attr('maxlength', 9);
			$("#prmRt").textbox('textbox').attr('maxlength', 3);
			$("#aplExrt").textbox('textbox').attr('maxlength', 9);
			$("#dlnPlWna").textbox('textbox').attr('maxlength', 9);
			$("#rmprRnno").textbox('textbox').attr('maxlength', 20);
			$("#rmprKrFirstNm").textbox('textbox').attr('maxlength', 100);
			$("#rmprKrLastNm").textbox('textbox').attr('maxlength', 100);
			$("#rmprAdr1").textbox('textbox').attr('maxlength', 100);
			$("#rmprAdr2").textbox('textbox').attr('maxlength', 100);
			$("#rmprTlno").textbox('textbox').attr('maxlength', 20);
			$("#rmprCellNo").textbox('textbox').attr('maxlength', 20);
			$("#rmprSitZip").textbox('textbox').attr('maxlength', 5);
			$("#adreEnFirstNm").textbox('textbox').attr('maxlength', 100);
			$("#adreEnLastNm").textbox('textbox').attr('maxlength', 100);
			$("#adreAdr1").textbox('textbox').attr('maxlength', 100);
			$("#adreAdr2").textbox('textbox').attr('maxlength', 100);
			$("#adreAcno").textbox('textbox').attr('maxlength', 35);
			$("#rcvgBnkCd").textbox('textbox').attr('maxlength', 4);
			$("#feeAmtWna").textbox('textbox').attr('maxlength', 9);
			$("#cashWna").textbox('textbox').attr('maxlength', 9);

		}
		
		function setTextBoxCss(){

			// TEXTBOX 입력시 무조건 대문자화
			$('#crcd').textbox('textbox').css('text-transform','uppercase');
			$('#rmprNtntNtcd').textbox('textbox').css('text-transform','uppercase');
			$('#rmprSitNtcd').textbox('textbox').css('text-transform','uppercase');
			$('#adreNtcd').textbox('textbox').css('text-transform','uppercase');

		}
				
		function setTextBoxDisable(textBoxName){
			if(textBoxName=='all' || textBoxName=='tradeType'){
			  $('#tradeType').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='refNo'){
			  $('#refNo').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='crcd'){
			  $('#crcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='owmnAmt'){
			  $('#owmnAmt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='crcCnclNm'){
			  $('#crcCnclNm').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='basicRate'){
			  $('#basicRate').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='prmRt'){
			  $('#prmRt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='aplExrt'){
			  $('#aplExrt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='dlnPlWna'){
			  $('#dlnPlWna').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprRnno'){
			  $('#rmprRnno').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprKrFirstNm'){
			  $('#rmprKrFirstNm').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprKrLastNm'){
			  $('#rmprKrLastNm').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprAdr1'){
			  $('#rmprAdr1').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprAdr2'){
			  $('#rmprAdr2').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprTlno'){
			  $('#rmprTlno').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprCellNo'){
			  $('#rmprCellNo').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprSitZip'){
			  $('#rmprSitZip').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreEnFirstNm'){
			  $('#adreEnFirstNm').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreEnLastNm'){
			  $('#adreEnLastNm').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreAdr1'){
			  $('#adreAdr1').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreAdr2'){
			  $('#adreAdr2').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreAcno'){
			  $('#adreAcno').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rcvgBnkCd'){
			  $('#rcvgBnkCd').textbox('disable');
			}
//			if(textBoxName=='all' || textBoxName=='rcvgBnkNm'){
//			  $('#rcvgBnkNm').textbox('disable');
//			}
			if(textBoxName=='all' || textBoxName=='feeAmtWna'){
			  $('#feeAmtWna').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='cashWna'){
			  $('#cashWna').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreState'){
			  $('#adreState').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='frxcLdgrStcd'){
			  $('#frxcLdgrStcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprRnnoDscd'){
			  $('#rmprRnnoDscd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmtKdcd'){
			  $('#rmtKdcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprAmtyDscd'){
			  $('#rmprAmtyDscd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprNtntNtcd'){
			  $('#rmprNtntNtcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='rmprSitNtcd'){
			  $('#rmprSitNtcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreNtcd'){
			  $('#adreNtcd').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreCiy'){
			  $('#adreCiy').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='adreTlno'){
			  $('#adreTlno').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='wnItrlkAmt'){
			  $('#wnItrlkAmt').textbox('disable');
			}
			if(textBoxName=='all' || textBoxName=='wnItrlkAct'){
			  $('#wnItrlkAct').textbox('disable');
			}
	
			setTextBoxReadOnly(textBoxName);
			
			setInnerBtnDisable();
		}
		
		function setAmtTextBoxDisable(textBoxName){
			
			if(textBoxName=='all' || textBoxName=='altWna'){
			  $('#altWna').textbox('disable');
			}	
		}
		
		function setInnerBtnDisable(){

			$('#zipcodeWindow').linkbutton('disable');
			$('#preCalcBtn').linkbutton('disable');
		}
		
		function setTextBoxReadOnly(textBoxName){
			if(textBoxName=='all' || textBoxName=='altWna'){
			  $('#altWna').textbox('readonly', true);
			}
			if(textBoxName=='all' || textBoxName=='cashWna'){
			  $('#cashWna').textbox('readonly', true);
			}
		}
		
		function setTextBoxEnable(){
			$('#tradeType').textbox('enable');
//			$('#refNo').textbox('enable');
			$('#crcd').textbox('enable');
			$('#owmnAmt').textbox('enable');
			$('#crcCnclNm').textbox('enable');
			$('#basicRate').textbox('enable');
			$('#prmRt').textbox('enable');
			$('#aplExrt').textbox('enable');
			$('#dlnPlWna').textbox('enable');
			$('#rmprRnno').textbox('enable');
			$('#rmprKrFirstNm').textbox('enable');
			$('#rmprKrLastNm').textbox('enable');
			$('#rmprAdr1').textbox('enable');
			$('#rmprAdr2').textbox('enable');
			$('#rmprTlno').textbox('enable');
			$('#rmprCellNo').textbox('enable');
			$('#rmprSitZip').textbox('enable');
			$('#adreEnFirstNm').textbox('enable');
			$('#adreEnLastNm').textbox('enable');
			$('#adreAdr1').textbox('enable');
			$('#adreAdr2').textbox('enable');
			$('#adreAcno').textbox('enable');
			$('#rcvgBnkCd').textbox('enable');
//			$('#rcvgBnkNm').textbox('enable');
			$('#feeAmtWna').textbox('enable');
			$('#cashWna').textbox('enable');
//			$('#adreState').textbox('enable');
			$('#rmprRnnoDscd').textbox('enable');
			$('#rmtKdcd').textbox('enable');
			$('#rmprAmtyDscd').textbox('enable');
			$('#rmprNtntNtcd').textbox('enable');
			$('#rmprSitNtcd').textbox('enable');
			$('#adreNtcd').textbox('enable');
			$('#adreCiy').textbox('enable');
			$('#adreTlno').textbox('enable');
			$('#wnItrlkAmt').textbox('enable');
			$('#wnItrlkAct').textbox('enable');
			$('#altWna').textbox('enable');

			$('#rmprAdr1').textbox('readonly', true);
			$('#rmprSitZip').textbox('readonly', true);
			
			setAmtTextBoxEnable();
			
			setInnerBtnEnable();
		}
		
		function setAmtTextBoxEnable(){
			
		}
		
		function setInnerBtnEnable(){

			$('#zipcodeWindow').linkbutton('enable');
			$('#preCalcBtn').linkbutton('enable');
		}
		
		function getRawData(){
			
			rawData = new Object();
			rawData.tradeType = $('#tradeType').val();
			rawData.refNo = $('#refNo').val();
			rawData.crcd = $('#crcd').val().toUpperCase();
			rawData.owmnAmt = $('#owmnAmt').val();
			rawData.crcCnclNm = $('#crcCnclNm').val();
			rawData.basicRate = $('#basicRate').val();
			rawData.prmRt = $('#prmRt').val();
			rawData.aplExrt = $('#aplExrt').val();
			rawData.dlnPlWna = $('#dlnPlWna').val();
			rawData.rmprRnnoDscd = $('#rmprRnnoDscd').val();
			rawData.rmprRnno = $('#rmprRnno').val();
			rawData.rmprKrFirstNm = $('#rmprKrFirstNm').val();
			rawData.rmprKrLastNm = $('#rmprKrLastNm').val();
			rawData.rmprAdr1 = $('#rmprAdr1').val();
			rawData.rmprAdr2 = $('#rmprAdr2').val();
			rawData.rmprTlno = $('#rmprTlno').val();
			rawData.rmprCellNo = $('#rmprCellNo').val();
			rawData.rmprSitZip = $('#rmprSitZip').val();
			rawData.adreEnFirstNm = $('#adreEnFirstNm').val();
			rawData.adreEnLastNm = $('#adreEnLastNm').val();
			rawData.adreAdr1 = $('#adreAdr1').val();
			rawData.adreAdr2 = $('#adreAdr2').val();
			rawData.adreAcno = $('#adreAcno').val();
			rawData.adreTlno = $('#adreTlno').val();
			rawData.adreState = $('#adreState').val();
			rawData.adreCty = $('#adreCty').val();
			rawData.rcvgBnkCd = $('#rcvgBnkCd').val();
			rawData.feeAmtWna = $('#feeAmtWna').val();
			rawData.cashWna = $('#cashWna').val();
			rawData.wnItrlkAct = $('#wnItrlkAct').val();
			rawData.wnItrlkAmt = $('#wnItrlkAmt').val();
			rawData.altWna = $('#altWna').val();
			
			rawData.rmtKdcd = $('#rmtKdcd').val();
			rawData.crcd = $('#crcd').val();
			rawData.rmprAmtyDscd = $('#rmprAmtyDscd').val();
			rawData.rmprNtntNtcd = $('#rmprNtntNtcd').val().toUpperCase();
			rawData.rmprSitNtcd = $('#rmprSitNtcd').val().toUpperCase();
			rawData.adreNtcd = $('#adreNtcd').val().toUpperCase();
			rawData.frxcLdgrStcd = $('#frxcLdgrStcd').val();
			rawData.quotSeq = $('#quotSeq').val();
			rawData.tusaTnslAmt = $('#tusaTnslAmt').val();
			
			return rawData;
		}
		
		function searchData(){
			
			var searchStartDate = $('#searchStartDate').val().replace(/-/g, '');
			var searchEndDate = $('#searchEndDate').val().replace(/-/g, '');
			var searchRefNo = $('#searchRefNo').val();
			var url;

			if(searchStartDate=='' || searchStartDate.length!=8){
				searchStartDate = getToday();
			}
			if(searchEndDate=='' || searchEndDate.length!=8){
				searchEndDate = getToday();
			}
			
			console.log("searchStartDate:"+searchStartDate);
			console.log("searchEndDate:"+searchEndDate);
			console.log("searchRefNo:"+searchRefNo);
			
			// 검색 날짜 검증
			if(searchStartDate > searchEndDate){
				
				showErrMsg('기준일자의 시작일이 종료일 이후 날짜입니다. 다시 입력해주세요.');
				
				$('#searchStartDate').textbox('textbox').focus();

				return;
			}
			
			// DATAGRID LOAD
			$('#dg').datagrid({
				url: '${pageContext.request.contextPath}/rest/remittance?startDate='+searchStartDate+'&endDate='+searchEndDate+'&refNo='+searchRefNo,
				onLoadSuccess:function(){
							
					var rows = $('#dg').datagrid('getRows').length; 
					if(rows==0){
						
						showErrMsg('조회 결과가 없습니다. 입력값을 확인하세요');
					}
							
					setButtonDisable();
					setButtonEnable('initBtn');
					setButtonEnable('saveBtn');
					setAmtTextBoxEnable();
							
				},
				onLoadError:function(request,status,error){
					
					if(chkSession(request, contextPath)){
						showErrMsg('조회 중 에러가 발생했습니다.');
					}
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
					
			targetUrl="${pageContext.request.contextPath}/rest/remittance";
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
				message = '당발송금 거래를 실행하시겠습니까?';
			}else
			if(tradeType=='3' || tradeType==c3){
				message = '당발송금 거래를 취소하시겠습니까?';
			}
					
			$.messager.confirm('Confirm',message,function(r){
				if (r){
					rawData = getRawData();
					console.log(JSON.stringify(rawData));
							
					targetUrl="${pageContext.request.contextPath}/rest/remittance";
							
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

							showInfMsg('정상처리되었습니다.');

						},
						error:function(request,status,error){
							
							if(chkSession(request, contextPath)){

								showErrMsg(getPureErrMsg(request));
							}
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
			
		function preCalc(btn){
			var tradeType = $('#tradeType').val();
			var rmtKdcd = $('#rmtKdcd').val();
			var crcd = $('#crcd').val();
			var ntcd = $('#adreNtcd').val();
			var prmRt = $('#prmRt').val();
			var owmnAmt = $('#owmnAmt').val();
			var url ="${pageContext.request.contextPath}/rest/remittancePreCalc?rmtKdcd="+rmtKdcd+"&crcd="+crcd+"&ntcd="+ntcd+"&prmRt="+prmRt+"&owmnAmt="+owmnAmt;
			console.log(url);
			var isSearch = $('#isSearch').val();
			
			// 금액 선조회 버튼 클릭 시 데이터 검증
			if(btn=='btn'){
				
				if(tradeType != c1 && tradeType != '1'){
					showErrMsg('<font color=red>거래구분</font>이 '+c1+'인 경에만 가능합니다.');
					return;	
				}
				
				if(crcd=='' || owmnAmt=='' || parseFloat(owmnAmt)==0 || ntcd==''){
					showErrMsg('<font color=red>통화코드</font>, <font color=red>금액</font>, <font color=red>수취인 국가</font>를 입력해야 금액 선조회가 가능합니다.');
					$('crcd').combobox('combobox').focus();
					return;
				}
				
				if(ntcd==''){
					showErrMsg('<font color=red>수취인 정보</font>의 <font color=red>수취인 국가</font>를 입력해야 금액 선조회가 가능합니다.');
					$('#tt').tabs('select',1);
					setTimeout(function(){$('adreNtcd').focus();}, 500);
					return;
				}

			}
			
//			console.log("tradeType:"+tradeType);
			if(tradeType == c3 || tradeType == '3'
			|| tradeType == c4 || tradeType == '4'
			|| isSearch == 'Y'){
				return;
			}

			// 수취국가코드, 고시환율, 적용환율, 원화금액, 거래이익, 원화정산금액 가져오기
			if(ntcd != '' && crcd != '' && prmRt != '' && owmnAmt != 0){
				jQuery.ajax({
					type:'get',
					url: url,
					contentType: 'application/json',
					dataType:"json",
					success:function(data, status, xhr){
						
						console.log(data);
						
						setCalcResult(data);
						
						showInfMsg('금액 선조회가 완료되었습니다.');
			
					},
					error:function(request,status,error){

						if(chkSession(request, contextPath)){

							showErrMsg(getPureErrMsg(request));
						}
					}    		
				});	
			}
		}
		
		function setCalcResult(data){
			
			$('#cashWna').numberbox('setValue', data.cashWna);
			$('#dlnPlWna').numberbox('setValue', data.dlnPlWna);
			$('#aplExrt').numberbox('setValue', data.aplExrt);
			$('#basicRate').numberbox('setValue', data.basicRate);
			$('#quotSeq').numberbox('setValue', data.quotSeq);
			$('#tusaTnslAmt').numberbox('setValue', data.tusaTnslAmt);
			$('#feeAmtWna').numberbox('setValue', data.feeAmtWna);

			$('#altWna').numberbox('setValue', 0);
			$('#wnItrlkAmt').numberbox('setValue', 0);
			
		}
		
		function searchDetail(){
			var row = $('#dg').datagrid('getSelected');
			
			if (row){
				
				$('#isSearch').val('Y'); // 조회 시에는 금액선조회(preCalc)가 동작하지 않도록 하기 위해서
				$('#fm').form('load',row);
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
					
					showErrMsg('정상/등록 거래는 새로고침 누른 후 이용해 주세요.');
					
					return;
				}
			}else{

				if(newValue == '3' || newValue == c3){
					
					if(frxcLdgrStcd=='9' || frxcLdgrStcd=='취소'){
						setTradeType(oldValue);
						
						showErrMsg('외환원장 상태가 취소인 거래는 다시 취소할 수 없습니다.');

						return;	
					}

				}

				// 조회 후 거래 확인
				if(refNo == ''){
					setTradeType(oldValue);
					
					showErrMsg('그리드에서 조회 완료 후 이용해 주세요.');

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
		
		function checkRmtKdcd(val){
			
			var r1 = '계좌송금';
			var r2 = '현금송금';
			var rmtKdcd = $('#rmtKdcd').val();
			
			$('#rcvgBnkCd').textbox('disable');	// 수취기관번호
//			$('#rcvgBnkNm').textbox('disable');	// 수취기관명
			$('#adreAcno').textbox('disable');	// 수취인 계좌번호
			
			if(rmtKdcd=='1' || rmtKdcd==r1){

				$('#rcvgBnkCd').textbox('enable');
//				$('#rcvgBnkNm').textbox('enable');
				$('#adreAcno').textbox('enable');
			}else
			if(rmtKdcd=='2' || rmtKdcd==r2){
				// empty
			}
		}
		
		function checkAdreNtcd(val){
			
			var adreNtcd = $('#adreNtcd').val();
			
			$('#adreState').textbox('disable');
			if(adreNtcd=='US'){
				$('#adreState').textbox('enable');
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
			var rmprRnno = $('#rmprRnno').val();
			if(rmprRnno==''){
				showErrMsg('<font color=red>실명번호</font>는 필수 입력사항입니다.');
				return false;
			}
			var rmprRnnoDscd = $('#rmprRnnoDscd').val();
			if(rmprRnnoDscd==''){
				showErrMsg('<font color=red>실명번호 구분</font>은 필수 입력사항입니다.');
				return false;
			}
			var rmprKrFirstNm = $('#rmprKrFirstNm').val();
			var rmprKrLastNm = $('#rmprKrLastNm').val();
			if(rmprKrFirstNm=='' || rmprKrLastNm==''){
				showErrMsg('<font color=red>송금인한글명</font>은 필수 입력사항입니다.');
				return false;
			}
			var crcd = $('#crcd').val();
			if(crcd==''){
				showErrMsg('<font color=red>통화</font>는 필수 입력사항입니다.');
				return false;
			}
			var owmnAmt = parseInt($('#owmnAmt').val());
			if(owmnAmt==0){
				showErrMsg('<font color=red>금액</font>은 필수 입력사항입니다. <font color=red>금액</font>을 입력하세요');
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
			var rmprRnnoDscd = $('#rmprRnnoDscd').val();
			console.log("rmprRnnoDscd:"+rmprRnnoDscd);
			if(rmprRnnoDscd=='1' && !checkJumin(rmprRnno)){
				showErrMsg('주민번호검증 오류입니다. 입력내용을 확인해주세요');
				return false;
			}else
			if(rmprRnnoDscd=='2' && !checkFgnno(rmprRnno)){
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
					url: '${pageContext.request.contextPath}/rest/remittance/' + parData,
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
			
			// KEY DOWN 추가
			$('#rmprRnnoDscd').combobox({
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
			// KEY DOWN 추가
			$('#rmprNtntNtcd').combobox({
				url:'${pageContext.request.contextPath}/rest/ctryCodeList',
				method:'get',
				valueField:'value',
				textField:'text',
				label: '국적',
				labelWidth: '130px',
				labelPosition: 'left',
				labelAlign: 'right',
				panelHeight: 'auto',
				editable: false,
			    keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
			        down: function(e){
			            $(this).combobox('showPanel');
			            $.fn.combobox.defaults.keyHandler.down.call(this,e);
			        }
			    })
			});
			// KEY DOWN 추가
			$('#rmprSitNtcd').combobox({
				url:'${pageContext.request.contextPath}/rest/ctryCodeList',
				method:'get',
				valueField:'value',
				textField:'text',
				label: '소재지',
				labelWidth: '130px',
				labelPosition: 'left',
				labelAlign: 'right',
				panelHeight: 'auto',
				editable: false,
				keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
					down: function(e){
						$(this).combobox('showPanel');
						$.fn.combobox.defaults.keyHandler.down.call(this,e);
					}
				})
			});	
			// 거래구분
			$('#tradeType').combobox({
				onChange: function(newValue, oldValue){
					checkTradeType(newValue, oldValue);
				},
				// KEY DOWN 추가
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
			// 송금종류
			$('#rmtKdcd').combobox({
				onChange: function(newValue, oldValue){
					checkRmtKdcd(newValue);
				},
				// KEY DOWN 추가
			    url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=RMT_KDCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '송금종류',
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
			// 통화
			$('#crcd').combobox({
				onChange: function(newValue, oldValue){
					preCalc('non');
				},
				// KEY DOWN 추가
				url:'${pageContext.request.contextPath}/rest/currCodeList',
				method:'get',
				valueField:'value',
				textField:'text',
				label: '통화/금액',
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
			
			// 거주성
			$('#rmprAmtyDscd').combobox({
				onChange: function(newValue, oldValue){
					// DO NOTHING
				},
				// KEY DOWN 추가
			    url:'${pageContext.request.contextPath}/rest/searchListCommonDcode?gcode=AMTY_DSCD',
		   	 	method:'get',
		   	    valueField:'dcode',
		   	    textField:'dcodeName',
				label: '거주구분',
				labelWidth: '125px',
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
			
			// 수취국가
			$('#adreNtcd').combobox({
				onChange: function(newValue, oldValue){
					checkAdreNtcd(newValue);		
				},
				// KEY DOWN 추가
				url:'${pageContext.request.contextPath}/rest/ctryCodeList',
				method:'get',
				valueField:'value',
				textField:'text',
				label: '수취인국가',
				labelWidth: '125px',
				labelPosition: 'left',
				labelAlign: 'right',
				required: true,
				panelHeight: 'auto',
			    editable: false,
			    keyHandler: $.extend({}, $.fn.combobox.defaults.keyHandler, {
			        down: function(e){
			            $(this).combobox('showPanel');
			            $.fn.combobox.defaults.keyHandler.down.call(this,e);
			        }
			    })	
			});
			// 수취인국가
			$('#adreNtcd').combobox({
				onChange: function(newValue, oldValue){
					preCalc('non');
				},
			});
			
			// 우대율
			$('#prmRt').combobox({
				onChange: function(newValue, oldValue){
					preCalc('non');
				},
				// KEY DOWN 추가
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
				// KEY DOWN 추가
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
			})
			
		}
				
		// TEXTBOX enter event
		$(document).ready(function(){

			/*
			// TEXTBOX에서 엔터 입력시 조회실행
			var t = $('#searchRefNo');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchData();
				}
			});	
			*/
					
			// GRID Double Click Event
		   	$('#dg').datagrid({
				onDblClickRow: function(index,row){

					searchDetail();
					
					/*
					$('#grid_accordion').accordion('unselect', '검색결과');
					$('#grid_accordion').accordion('select', '입력화면');
					*/
				}
		   	});
			
			// TEXTBOX에서 엔터 입력시 조회실행
			var t = $('#searchRefNo');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){   // when press ENTER key, accept the inputed value.
					searchData();
				}
			});
			
			// SORTER
			$('#dg').datagrid({
				remoteSort: false,
				columns: [[
					{field:'refNo',			title:'참조번호',		width:'13%',sortable:true,align:'center', 								sorter:sorter },
					{field:'trDt',			title:'거래일자',		width:'13%',sortable:true,align:'center',	formatter:formatDate, 		sorter:sorter },
					{field:'rmprCustNo',	title:'고객번호',		width:'13%',sortable:true,align:'center', 								sorter:sorter },
					{field:'rmprKrFirstNm',	title:'고객명',		width:'13%',sortable:true,align:'left', 								sorter:sorter },
					{field:'crcd',			title:'통화코드',		width:'10%',sortable:true,align:'center', 								sorter:sorter },
					{field:'owmnAmt',		title:'송금금액',		width:'13%',sortable:true,align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'aplExrt',		title:'적용환율',		width:'13%',sortable:true,align:'right',	formatter:formatDecimal, 	sorter:sorter },
					{field:'frxcLdgrStcd',	title:'외환원장상태',	width:'12%',sortable:true,align:'center',							 	sorter:sorter }
				]]
			});
			
			commonCode();
			
			// 송금금액
			$('#owmnAmt').numberbox({
				onChange: function(newValue, oldValue){
					preCalc('non');
				}	
			});
			
			// 원화연동금액
			$('#wnItrlkAmt').numberbox({
				onChange: function(newValue, oldValue){
					// 원화정산금액
					var owmnAmt = $('#owmnAmt').val();
					var altWna = $('#altWna').val();
					var cashWna = $('#cashWna').val();

					newValue = parseInt(newValue);
					altWna = parseInt(altWna);
					cashWna = parseInt(cashWna);

					if(owmnAmt=='' || owmnAmt==0){
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
					/*
					if(newValue > cashWna){
						showErrMsg('입력하신 금액이 원화정산금액보다 큽니다. 작거나 같게 입력해주세요.');
						$('#wnItrlkAmt').numberbox('setValue', 0);
						return;
					}
					*/
					if(newValue>0 && newValue != cashWna){
						showErrMsg('원화연동금액은 원화정산금액과 동일해야합니다. 전체 금액 중 일부만 원화연동금액으로 입력할 수 없습니다.');
						$('#wnItrlkAmt').numberbox('setValue', 0);
						return;
					}

					// 현금금액 = 정산금액 - 원화연동금액 - 입력금액
					cashWna = cashWna - newValue;
	
					$('#cashWna').numberbox('setValue', cashWna);
					$('#altWna').numberbox('setValue', newValue);
				}	
			});
			// 팝업에서 처리된 우편번호
			$('#zipCode').textbox({
				onChange: function(newValue, oldValue){
					$('#rmprSitZip').textbox('setValue', newValue);	
				}
			});	
			// 팝업에서 처리된 본주소
			$('#addr1').textbox({
				onChange: function(newValue, oldValue){
					$('#rmprAdr1').textbox('setValue', newValue);	
				}
			});	
			
			document.onkeydown = fkey;
			function fkey(e){
			    e = e || window.event;
			 
			    if(e.keyCode == 116){
			        location.href = "${pageContext.request.contextPath}/remittance/remittance";
			    }
			}
			
			$('#cancelBtn').hide();
			$('#editBtn').hide();
			setMenuPannel();
			
			setInputDivSizeType3('mainBiz');
			zipcodeWindowClose();
			
			/*
			$.extend($.fn.validatebox.defaults.rules,{
			       inList:{
			              validator:function(value,param){
			                     var c = $(param[0]);
			                     var opts = c.combobox('options');
			                     var data = c.combobox('getData');
			                     var exists = false;
			                     for(var i=0; i<data.length; i++){
			                            if (value == data[i][opts.textField]){
			                                   exists = true;
			                                   break;
			                            }
			                     }
			                     return exists;
			              },
			              message:'invalid value.'
			       }
			});
			
			$('#crcd').combobox({
			       validType:'inList["#crcd"]'
			});
			*/
					
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
