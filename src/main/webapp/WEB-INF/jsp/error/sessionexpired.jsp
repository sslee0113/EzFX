<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>

<script>
//alert('세션이 만료되었습니다');
document.location = '${pageContext.request.contextPath}'; 
</script>

</body>
</html>