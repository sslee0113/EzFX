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

		<div class="main_content">

			<div class="menu">
				<%@ include file="/WEB-INF/jsp/menu/menuuser.jsp"%>
			</div>

			<div class="center_content">

				<div class="left_content">
					<%@ include file="/WEB-INF/jsp/left/left-dashboarduser.jsp"%>
				</div>

				<div class="right_content">
					<!-- start of right content-->


					<h2>USERS - DASH BOARD</h2>
					<p>User 그룹이 접속하면 보이는 화면 입니다</p>
			


					<!-- end of right content-->
				</div>


			</div>

			<!-- do not delete this div:clear -->
			<div class="clear"></div>


		</div>


		<div class="footer">
			<%@ include file="/WEB-INF/jsp/footer/footer.jsp"%>
		</div>

		<!-- end of body-->
	</div>
  

</body>
</html>
