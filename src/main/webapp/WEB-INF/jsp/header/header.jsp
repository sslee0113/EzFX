<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div style="width:100%;background-color: ivory">
	<div class="logo">
		Ez-TransMoney
	</div>
	<!-- 
	<div class="right_header" style="width:50%;float:left;padding-left:10px">
		[Welcome Ez-TransMoney System]<a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
	</div>
	 -->

	<div style="float:right">
	<div id="usericonDiv" class="right_header_img" style="width:35px;">
		<img src='../images/icons8-user-32.png' height='20px'>
	</div>
	<div id="accountInfoDiv" class="right_header" style="width:auto;">
	<!-- 
	 style="width:50%;float:right;text-align:right;padding-right:10px">
	 -->

	<!--
		[Welcome Ez-TransMoney System]<a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>

		사용자ID : <input id="headUsername" name="headUsername" style="width:90px;background-color:transparent;border-width:0px;border:none;font-size:10px;font-weight:bold;color:white">
		사용자이름 : <input id="headFullname" name="headFullname" style="width:90px;background-color:transparent;border-width:0px;border:none;font-size:10px;font-weight:bold;color:white">
		영업점 : <input id="headBrno" name="headBrno" style="width:30px;background-color:transparent;border-width:0px;border:none;font-size:10px;font-weight:bold;color:white">
	-->
		<script>
			getAccountInfo('${pageContext.request.contextPath}');
		</script>
	</div>
	</div>

</div>