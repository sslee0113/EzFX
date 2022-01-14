<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>

<script>
alert('패스워드 유효기간이 지났습니다. 패스워드를 변경해 주세요');
document.location = "/expired/password";
</script>


</body>
</html>