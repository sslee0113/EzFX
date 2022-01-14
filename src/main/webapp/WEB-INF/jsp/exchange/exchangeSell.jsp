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

		<div class="header">
			<%@ include file="/WEB-INF/jsp/header/header.jsp"%>
		</div>

		<div id="dummy_white_div" class="main_content" style="display:block;border-radius: 10px;">
			<div id="main_content_div" >
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
								<div id="grid_div" title="검색결과" style="width:'auto';height:300px;overflow:scroll;" data-options="selected:false">
									검색결과 그리드표시
								</div>
								<div id="input_div" title="입력화면" style="width:100%;height:470px;padding:5px;" data-options="selected:true">
									<form id="fm" method="post" novalidate style="margin:0;padding:20px 20px">
										<div align="left" style="width:49%;float:left">
											<div style="margin-bottom:2px">
												<select id="id1" name="id1" class="easyui-combobox" label="거래구분" labelWidth="130px" labelAlign="right" style="width:240px" data-options="required:true" tabindex="1"/>
													<option value="1">1-정상/등록</option>
													<option value="3">3-취소</option>
													<option value="4">4-조회</option>
													
												</select>
											</div>
											<div style="margin-bottom:2px">
												<select class="easyui-combobox" id="residentCd" name="residentCd" label="실명번호구분" labelWidth="130px" labelAlign="right" style="width:260px;" tabindex="3">
													<option value="1">1-주민등록증</option>
													<option value="2">2-운전면허증</option>
													<option value="3">3-여권</option>
													<option value="4">4-외국인등록증 </option>
													<option value="5">5-사업자등록증</option>
													<option value="6">6-법인등록번호</option>
												</select>
											</div>
										</div>
										<div align="left" style="width:49%;float:left">
											<div style="margin-bottom:2px">
												<input id="id2" name="id2" class="easyui-textbox" label="참조번호" labelWidth="130px" labelAlign="right" style="width:270px" data-options="required:true" tabindex="2"/>
											</div>
											<div style="margin-bottom:2px">
												<input id="residentNo" name="residentNo" class="easyui-textbox" label="실명번호" labelWidth="130px" labelAlign="right" style="width:270px" data-options="required:true" tabindex="4"/>
											</div>
										</div>
										<div class="easyui-layout" style="width:100%;height:10px">
											&nbsp; <!-- 빈줄 간격 만들기 -->
										</div>
										<div align="left" style="width:49%;float:left">
											<div style="margin-bottom:2px">
												<input id="currCode" class="easyui-combobox" name="currCode" style="width:200px;" tabindex="5"
													data-options=" url:'${pageContext.request.contextPath}/rest/currCodeList',
														method:'get',
														valueField:'value',
														textField:'text',
														label: '통화',
														labelWidth: '130px',
														labelPosition: 'left',
														labelAlign: 'right',
														required: 'true'
														" />
											</div>
											<div style="margin-bottom:2px">
												<input id="id3" name="id3" class="easyui-numberbox" label="지폐금액" labelWidth="130px" labelAlign="right" style="width:270px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="6"/>
											</div>
											<div style="margin-bottom:2px">
												<select class="easyui-combobox" id="habitationCd" name="habitationCd" label="거주성" labelWidth="130px" labelAlign="right" style="width:230px;" tabindex="8">
													<option value="1">1-거주자</option>
													<option value="2">2-비거주자</option>
												</select>
											</div>
											<div style="margin-bottom:2px">
												<input id="nationalCode2" class="easyui-combobox" name="nationalCode2" style="width:190px;" tabindex="10" 
													data-options=" url:'${pageContext.request.contextPath}/rest/ctryCodeList',
																	method:'get',
																	valueField:'value',
																	textField:'text',
																	label: '상대국가',
																	labelWidth: '130px',
																	labelPosition: 'left',
																	labelAlign: 'right'
																	" />
											</div>
											<div style="margin-bottom:2px">
												<select class="easyui-combobox" id="id6" name="id6" label="사유코드" labelWidth="130px" labelAlign="right" style="width:360px;" tabindex="12">
													<option value="111">111-유학 및 훈련</option>
													<option value="124">124-업무상 여행</option>
													<option value="125">125-치료목적의 여행</option>
													<option value="126">126-관광,친지방문 등 기타일반여행</option>
													<option value="127">127-여행경비(환전상 등)</option>
													<option value="128">128-여행경비(신용카드)</option>
													<option value="132">132-여행 알선료</option>
													<option value="141">141-지참금</option>
													<option value="190">190-여행(100달러이하 소액거래)</option>
												</select>
											</div>
										</div>
										<div align="left" style="width:49%;float:left">
											<div class="easyui-layout" style="width:100%;height:25px">
												&nbsp; <!-- 빈칸 간격 만들기 -->
											</div>
											<div style="margin-bottom:2px">
												<input id="id4" name="id4" class="easyui-numberbox" label="주화금액" labelWidth="130px" labelAlign="right" style="width:270px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="7"/>
											</div>
											<div style="margin-bottom:2px">
												<input id="nationalCode" class="easyui-combobox" name="nationalCode" style="width:190px;" tabindex="9" 
													data-options=" url:'${pageContext.request.contextPath}/rest/ctryCodeList',
																	method:'get',
																	valueField:'value',
																	textField:'text',
																	label: '국적',
																	labelWidth: '130px',
																	labelPosition: 'left',
																	labelAlign: 'right'
																	" />
											</div>
											<div style="margin-bottom:2px">
												<select class="easyui-combobox" id="id5" name="id5" label="거래주체" labelWidth="130px" labelAlign="right" style="width:270px;" tabindex="11">
													<option value="320">320-개인기타</option>
													<option value="620">620-국가개인기타</option>
												</select>
											</div>
										</div>
										<div class="easyui-layout" style="width:99%;height:10px">
												&nbsp; <!-- 빈줄 간격 만들기 -->
										</div>
										<!-- 입금 / 지급 정보  -->
										<div id="p" class="easyui-panel" title="입금/지급 정보" style="width:99%;height:180px;padding:5px;">
											<div align="left" style="width:49%;float:left">
												<div style="margin-bottom:2px">
													<input id="id6" name="id6" class="easyui-numberbox" label="외국통화" labelWidth="130px" labelAlign="right" style="width:255px;text-align:right" data-options="required:true,precision:2,groupSeparator:','" tabindex="13"/>
												</div>
											</div>
											<div align="left" style="width:35%;float:left">
												<div style="margin-bottom:2px">
													<input id="id7" name="id7" class="easyui-numberbox" label="우대율" labelWidth="130px" labelAlign="right" style="width:255px;text-align:right" data-options="required:true,precision:2,groupSeparator:','" tabindex="14"/>
												</div>
											</div>
											<div align="right" style="width:15%;float:left">
												<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchData()" style="width:90px">금액선조회</a>
											</div>
											<div class="easyui-layout" style="width:99%;height:10px">
												&nbsp; <!-- 빈줄 삽입  -->
											</div>
											<!-- 지폐금액,주화금액의 TITLE -->
											<div class="easyui-layout" style="width:99%;height:20px">
												<div align="left" style="width:130px;float:left">
													&nbsp;
												</div>
												<div align="left" style="width:130px;float:left;text-align:center">
													외화금액
												</div>
												<div align="left" style="width:130px;float:left;text-align:center">
													고시환율
												</div>
												<div align="left" style="width:130px;float:left;text-align:center">
													적용환율
												</div>
												<div align="left" style="width:130px;float:left;text-align:center">
													원화환율
												</div>
												<div align="left" style="width:130px;float:left;text-align:center">
													거래이익
												</div>
											</div> <!-- end of 지폐금액,주화금액의 TITLE -->
											<div class="easyui-layout" style="width:99%;height:26px">
												<div class="my-textbox1" align="left" style="float:left;">
													지폐금액
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id9" name="id9" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id10" name="id10" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id11" name="id11" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id12" name="id12" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id13" name="id13" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
											</div> <!-- end of 지폐금액 -->
											<div class="easyui-layout" style="width:99%;height:26px">
												<div class="my-textbox1" align="left" style="float:left;">
													주화금액
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id9" name="id9" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id10" name="id10" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id11" name="id11" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id12" name="id12" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
												<div align="left" style="width:130px;float:left">
													<div style="margin-bottom:2px">
														<input id="id13" name="id13" class="easyui-numberbox" style="width:125px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
													</div>
												</div>
											</div> <!-- end of 주화금액 -->
											<div align="left" style="width:99%;float:left">
												<div style="margin-bottom:2px">
													<input id="id6" name="id6" class="easyui-numberbox" label="원화정산금액" labelWidth="130px" labelAlign="right" style="width:255px;text-align:right" data-options="required:false,precision:2,groupSeparator:','" tabindex="15"/>
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
	<script type="text/javascript">
		$(document).ready(function(){
			$('#cancelBtn').hide();
			
			setMenuPannel();
		});
	</script>
</body>
</html>
