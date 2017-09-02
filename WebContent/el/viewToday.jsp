<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page session="false" %>
<%@ taglib prefix="elfunc" uri="/WEB-INF/el-functions.tld" %>
<!-- prefix 접두사 -->
<!-- uri에 있는 tld를 elfunc이라는 별칭으로 사용하겠다  -->
<%
	java.util.Date today = new java.util.Date();
	request.setAttribute("today", today);
%>
<html>
<head><title>EL 함수 호출</title></head>
<body>

오늘은 <b>${elfunc:dateFormat(today) }</b> 입니다.

</body>
</html>
