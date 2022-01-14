<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<sec:authorize access="isAuthenticated()">
	<div class="sidebarmenu">
		<a class="menuitem_green">접속 계정 : <sec:authentication
				property="principal.username" /><br></a> <a
			class="menuitem_red">권한 : <sec:authorize
				access="hasRole('ROLE_ADMIN')"> Administrators</sec:authorize>
			<sec:authorize access="hasRole('ROLE_USER')"> Users</sec:authorize></a>
	</div>
</sec:authorize>
<div class="sidebar_box">
	<div class="sidebar_box_top"></div>
	<div class="sidebar_box_content">
		<h3>Page Description</h3>
		<img src="${pageContext.request.contextPath}/images/info.png" alt="" title="" class="sidebar_icon_right" />
		<p>
			EDI MGMT의 상태를 모니터링 하는 Dash Board 입니다<br>
						
		</p>
	</div>
	<div class="sidebar_box_bottom"></div>
</div>

<!-- 
<div class="sidebar_box">
	<div class="sidebar_box_top"></div>
	<div class="sidebar_box_content">
		<h4>Important notice</h4>
		<img src="${pageContext.request.contextPath}/images/notice.png" alt="" title=""
			class="sidebar_icon_right" />
		<p>
		  컬럼이 노란색으로 표시된 서버는 장애가 발생한 서버입니다	
		</p>
	</div>
	<div class="sidebar_box_bottom"></div>
</div>
 -->
