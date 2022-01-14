<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>

<script>
alert('패스워드 유효기간이 지났습니다. 다시 로그인 하면 패스워드 변경 페이지로 이동합니다');
document.location = "/logout";
</script>


</body>
</html>