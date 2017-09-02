<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>catch 태그</title></head>
<body>

<!-- 예외를 발생시키는 예제 -->

<c:catch var="ex">
name 파라미터의 값 = <%= request.getParameter("name") %><br>
<%  if (request.getParameter("name").equals("test")) {  %>
${param.name}은 test 입니다.
<%  }   %>
</c:catch>
<!-- catch를 통해 예외 처리 -->

<p>
<c:if test="${ex != null}">
예외가 발생하였습니다:<br>
${ex}
</c:if>

</body>
</html>