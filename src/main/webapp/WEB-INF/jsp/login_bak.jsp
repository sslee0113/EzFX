<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/head/head-login.jsp" %>
</head>
<body>
<div id="main_container">
	<div class="header_login">
           <h1>Foreign Exchange System Login</h1>
           
				<c:if test="${param.error != null}">        
					<p><font color="white">☆  Login Failed.</font></p>
					<p><font color="white">☆ 연속 5회 실패 시 계정이 잠금 상태가 됩니다</font></p>					
					<c:if test="${param.count != null}"><p><font color="white">☆ <%= request.getParameter("count") %> 회 실패 했습니다</font></p></c:if>										
					<p><font color="white">☆  잠금 상태가 되면 관리자에게 문의하세요</font></p>
				</c:if>
				<c:if test="${param.logout != null}">       
					<p><font color="white">You have been logged out.</font></p>
				</c:if>
  
		 <sec:authorize access="isAnonymous()">
		   <c:url value="/login" var="loginUrl"/>
           <form action="${loginUrl}" method="post">           
             <fieldset>            
               <dl>
                 <label for="email">Username</label>
                 <input type="text" id="username" name="username" size="15"/>
               </dl>
                <dl>
                  <label for="email">Password</label>
                  <input type="password" id="password" name="password" size="16"/>
                </dl>
                <dl>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </dl>            
				                
                <dl>                  
                  <input type="submit" name="submit" id="submit" value="Login" />
                </dl>
                
              </fieldset>
            </form>
          </sec:authorize>
		  <sec:authorize access="isAuthenticated()">
		    <br><font color="white"> <sec:authentication property="principal.username" /> 로그인 중입니다.</font><br></br>
		    <!-- 
		 	  <a href="${pageContext.request.contextPath}/admin/dashboard"><font color="white">main으로 이동</font></a><br></br>
		 	-->
		 	  <a href="${pageContext.request.contextPath}/exchange/exchangeBuy"><font color="white">main으로 이동</font></a><br></br>
		        <form action="${pageContext.request.contextPath}/logout" method="post">
			      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			      <input type="submit" value="로그아웃">
			  </form> 	 
		 </sec:authorize>          
          
       </div>
</div>
</body>
</html>
