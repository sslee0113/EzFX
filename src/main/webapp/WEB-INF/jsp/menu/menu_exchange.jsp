<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
						<div id="leftMenu" class="easyui-accordion" data-options="multiple:true,border:false,animate:true" style="height1:190px;">
							<div title="환전" data-options="selected:true" style="padding:10px">
								<%@ include file="/WEB-INF/jsp/menu/menu_link_exchange.jsp"%>
							</div>
							<div title="송금" data-options="selected:false" style="padding:10px;">
								<%@ include file="/WEB-INF/jsp/menu/menu_link_remittance.jsp"%>
							</div>
							<div title="회계" data-options="selected:false" style="padding:10px;">
								<%@ include file="/WEB-INF/jsp/menu/menu_link_accounting.jsp"%>
							</div>
							<div title="업무공통" data-options="selected:false" style="padding:10px">
								<%@ include file="/WEB-INF/jsp/menu/menu_link_bizcommon.jsp"%>
							</div>
							<!--
							<div title="계정관리" data-options="selected:false" style="padding:10px">
								<a id="menuAccount" href="${pageContext.request.contextPath}/admin/account" class="easyui-linkbutton" data-options="plain:true">사용자 관리</a>
							</div>
							<div title=" " data-options="selected:false" style="padding:10px">
								&nbsp;
							</div>
							 -->
						</div>