<%@page import="com.sennet.common.StringUtil"%>
<%@page import="com.sennet.bizcommon.commondcode.CommonDcodeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.sennet.bizcommon.role.TrRoleVo"%>
<%@page import="java.util.List"%>
<%@page import="com.sennet.security.CustomGrantedAuthority"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="org.springframework.security.core.GrantedAuthority"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.userdetails.UserDetails"%>
<div id="leftMenu" class="easyui-accordion" data-options="multiple:true,border:false,animate:true" style="height1:190px;">
    <!-- 
	<div title="환전" data-options="selected:false" style="padding:10px">
			<a id="menuExchangeBuy" href="${pageContext.request.contextPath}/exchange/exchangeBuy" class="easyui-linkbutton" data-options="plain:true">외국통화 매입</a><br/>
			<a id="menuExchangeList" href="${pageContext.request.contextPath}/exchange/exchangeList" class="easyui-linkbutton" data-options="plain:true">환전내역 조회</a><br/>							
	</div>
	<div title="송금" data-options="selected:false" style="padding:10px;">
			<a id="menuRemittance" href="${pageContext.request.contextPath}/remittance/remittance" class="easyui-linkbutton" data-options="plain:true">해외송금</a><br/>
			<a id="menuRemittanceList" href="${pageContext.request.contextPath}/remittance/remittanceList" class="easyui-linkbutton" data-options="plain:true">해외송금 내역조회</a><br/>
			<a id="menuRemittanceTotal" href="${pageContext.request.contextPath}/remittance/remittanceTotal" class="easyui-linkbutton" data-options="plain:true">해외송금 집계조회</a><br/>							
	</div>
	<div title="회계" data-options="selected:false" style="padding:10px;">
			<a id="menuGlList" href="${pageContext.request.contextPath}/accounting/glList" class="easyui-linkbutton" data-options="plain:true">계정처리내역조회</a><br/>
			<a id="menuBsList" href="${pageContext.request.contextPath}/accounting/bsList" class="easyui-linkbutton" data-options="plain:true">외화BS조회</a><br/>
			<a id="menuGlCode" href="${pageContext.request.contextPath}/accounting/glCode" class="easyui-linkbutton" data-options="plain:true">계정코드관리</a>							
	</div>
	<div title="업무공통" data-options="selected:true" style="padding:10px">
			<a id="menuBranch" href="${pageContext.request.contextPath}/bizcommon/branch" class="easyui-linkbutton" data-options="plain:true">영업점 관리</a><br/>
			<a id="menuCurrency" href="${pageContext.request.contextPath}/bizcommon/currency" class="easyui-linkbutton" data-options="plain:true">통화 관리</a><br/>
			<a id="menuCountry" href="${pageContext.request.contextPath}/bizcommon/country" class="easyui-linkbutton" data-options="plain:true">국가 관리</a><br/>
			<a id="menuCustomer" href="${pageContext.request.contextPath}/bizcommon/customer" class="easyui-linkbutton" data-options="plain:true">외환고객 관리</a><br/>
			<a id="menuFrgnExchRate" href="${pageContext.request.contextPath}/bizcommon/frgnExchRate" class="easyui-linkbutton" data-options="plain:true">환율정보조회</a><br/>
			<a id="menuFrgnExchRateNotice" href="${pageContext.request.contextPath}/bizcommon/frgnExchRateNotice" class="easyui-linkbutton" data-options="plain:true">환율고시</a><br/>
			<a id="menuZipcode" href="${pageContext.request.contextPath}/bizcommon/zipcode" class="easyui-linkbutton" data-options="plain:true">우편번호 관리</a><br/>
			<a id="menuFee" href="${pageContext.request.contextPath}/bizcommon/fee" class="easyui-linkbutton" data-options="plain:true">송금 수수료 관리</a><br/>
			<a id="menuAccount" href="${pageContext.request.contextPath}/bizcommon/account" class="easyui-linkbutton" data-options="plain:true">사용자 관리</a><br/>
			<a id="menuIfLog" href="${pageContext.request.contextPath}/bizcommon/ifLog" class="easyui-linkbutton" data-options="plain:true">IF로그</a><br/>
			<a id="menuCommonCode" href="${pageContext.request.contextPath}/bizcommon/commonCode" class="easyui-linkbutton" data-options="plain:true">공통코드</a><br/>
			<a id="menuCommonDcode" href="${pageContext.request.contextPath}/bizcommon/commonDcode" class="easyui-linkbutton" data-options="plain:true">공통코드상세</a><br/>
			<a id="menuMenu" href="${pageContext.request.contextPath}/bizcommon/menu" class="easyui-linkbutton" data-options="plain:true">메뉴관리</a><br/>
			<a id="menuRole" href="${pageContext.request.contextPath}/bizcommon/role" class="easyui-linkbutton" data-options="plain:true">권한관리</a><br/>	
	</div>
     -->
	<%
	String url = request.getRequestURL().toString();
	String selectedMiddleMenu="";
	String selectedMenu="";
	String selectedMenuName="";
	UserDetails userDetails =(UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	Collection<? extends GrantedAuthority> list = userDetails.getAuthorities();
	Iterator<? extends GrantedAuthority> itr = list.iterator();
	while(itr.hasNext()){
		CustomGrantedAuthority customGrantedAuthority  = (CustomGrantedAuthority)itr.next();
		List<CommonDcodeVo> menuDcodeList =  customGrantedAuthority.getMenuList();
		Iterator<CommonDcodeVo> itrDcode = menuDcodeList.iterator();
		while(itrDcode.hasNext()){
			CommonDcodeVo dcodeVo = itrDcode.next();
			List<TrRoleVo> trRoleVoList = customGrantedAuthority.getMenuTrRoleVoList(dcodeVo.getDcodeName());
			if(trRoleVoList.size()>0){
				selectedMiddleMenu = customGrantedAuthority.getDcode(request.getRequestURL().toString()).equals(dcodeVo.getDcode())? "true":"false";
				%>	<div title=<%=dcodeVo.getDcodeName() %> data-options='selected:<%=selectedMiddleMenu%>' style="padding:10px;"><%
			}
			Iterator<TrRoleVo> itrTrRoleVo = trRoleVoList.iterator();
			while(itrTrRoleVo.hasNext()){
				TrRoleVo trRoleVo = itrTrRoleVo.next();
				selectedMenu =  StringUtil.getPlainMenu(request.getRequestURL().toString(),trRoleVo.getMenuUrl());
				if(selectedMenu.equals("false")){
					selectedMenuName = trRoleVo.getMenuName();
				}
				%><a id='menu<%=trRoleVo.getMenuId() %>' href='${pageContext.request.contextPath}<%=trRoleVo.getMenuUrl() %>' class='easyui-linkbutton' data-options='plain:<%=selectedMenu%>'><%=trRoleVo.getMenuName() %></a><br/><%			}
			if(trRoleVoList.size()>0){
				%></div><%
			}
		}		
		
	}
	%>
</div>