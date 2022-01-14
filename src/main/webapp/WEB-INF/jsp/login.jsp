<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/vendor/bootstrap/css/bootstrap.min.css"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/fonts/font-awesome-4.7.0/css/font-awesome.min.css"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/vendor/animate/animate.css"/>
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="login/vendor/css-hamburgers/hamburgers.min.css"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/vendor/animsition/css/animsition.min.css"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/vendor/select2/select2.min.css"/>
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="login/vendor/daterangepicker/daterangepicker.css"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login/css/util.css"/>
	<link rel="stylesheet" type="text/css" href="login/css/main.css"/>
<!--===============================================================================================-->
</head>
<body>
<div id="main_container">
	<div class="header_login">
  
		 <sec:authorize access="isAnonymous()">
		   <c:url value="/login" var="loginUrl"/>
              <div class="limiter">
				<div class="container-login100">
					<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
						<form class="login100-form validate-form flex-sb flex-w" action="${loginUrl}" method="post">
							<span class="login100-form-title p-b-32">
								Ez-TransMoney Login
							</span>
							

						<c:if test="${param.error != null}">        
							<span class="txt1 p-b-11">
							☆  Login Failed.<br/>
							☆ 연속 5회 실패 시 계정이 잠금 상태가 됩니다.<br/>
						<c:if test="${param.count != null}">☆ <%= request.getParameter("count") %> 회 실패 했습니다.<br/></c:if>
							☆  잠금 상태가 되면 관리자에게 문의하세요.<br/>
							</span><br/>
							<div class="wrap-input100 validate-input m-b-36">
							</div>
						</c:if>

						<c:if test="${param.logout != null}">       
							<span class="txt1 p-b-11">
							You have been logged out. <br/>
							</span><br/>
							<div class="wrap-input100 validate-input m-b-36">
							</div>
						</c:if>

							<span class="txt1 p-b-11">
								Username
							</span>
							<div class="wrap-input100 validate-input m-b-36" data-validate = "Username is required">
								<input class="input100" type="text" name="username" />
								<span class="focus-input100"></span>
							</div>
							
							<span class="txt1 p-b-11">
								Password
							</span>
							<div class="wrap-input100 validate-input m-b-12" data-validate = "Password is required">
								<span class="btn-show-pass">
									<i class="fa fa-eye"></i>
								</span>
								<input class="input100" type="password" name="password" />
								<span class="focus-input100"></span>
							</div>
							
							<div class="flex-sb-m w-full p-b-48">
							</div>

							<div class="container-login100-form-btn">
								<button class="login100-form-btn">
									Login
								</button>
							</div>

						</form>
					</div>
				</div>
			</div>
			<div id="dropDownSelect1"></div>
	
          </sec:authorize>
		  <sec:authorize access="isAuthenticated()">
		  <div class="container-login100">
			<div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
				<span class="login100-form-title p-b-32">
		    		<sec:authentication property="principal.username" /> 로그인 중입니다.
				</span>
				<div class="container-login100-form-btn">
					<form action="${pageContext.request.contextPath}/remittance/remittance">
						<button class="login100-form-btn">
							Move to main
						</button>
					</form>
					&nbsp; &nbsp;
					<form action="${pageContext.request.contextPath}/logout" method="post">
						<button class="login100-form-btn">
							Logout
						</button>
					</form>
				</div>
			</div>
		  </div>
		 </sec:authorize>          
          
       </div>
</div>

	
<!--===============================================================================================-->
	<script src="login/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/bootstrap/js/popper.js"></script>
	<script src="login/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/daterangepicker/moment.min.js"></script>
	<script src="login/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="login/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="login/js/main.js"></script>
	
</body>
</html>
