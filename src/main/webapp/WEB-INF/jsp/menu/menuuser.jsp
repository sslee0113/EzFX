<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<ul>

<!-- 
	<li><a href="/user/dashboard">Dash Board</a></li>
-->
	<li><a>EDI MGMT 운영<!--[if IE 7]><!--></a> <!--<![endif]--> <!--[if lte IE 6]><table><tr><td><![endif]-->
		<ul>
			<li><a href="${pageContext.request.contextPath}/user/iaudit" title="">1. VAN to BK 문서관리</a></li>
			<li><a href="${pageContext.request.contextPath}/user/oaudit" title="">2. BK to VAN 문서관리</a></li>
			<li><a href="${pageContext.request.contextPath}/user/statistics" title="">3. 통계관리</a></li>
		</ul> <!--[if lte IE 6]></td></tr></table></a><![endif]--></li>
 
</ul>