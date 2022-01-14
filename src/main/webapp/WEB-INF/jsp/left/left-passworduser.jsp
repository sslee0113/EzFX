<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<sec:authorize access="isAuthenticated()">
<div id="authOjb" style="display:none" name="<sec:authentication property="principal.username" />"></div>
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
		<img src="/images/info.png" alt="" title="" class="sidebar_icon_right" />
		<p>
			패스워드 변경 페이지 입니다<br>
						
		</p>
	</div>
	<div class="sidebar_box_bottom"></div>
</div>

<div class="sidebar_box">
	<div class="sidebar_box_top"></div>
	<div class="sidebar_box_content">
		<h4>Important notice</h4>
		<img src="/images/notice.png" alt="" title=""
			class="sidebar_icon_right" />
		<p>
			- 패스워드는 DB에 단뱡향 암호화 되어 저장됩니다<br>
			- 관리자도 변경된 패스워드를 알 수 없습니다<br>
			- 신중하게 변경하세요
		</p>
	</div>
	<div class="sidebar_box_bottom"></div>
</div>

