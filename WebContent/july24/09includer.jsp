<%@ page contentType="text/html; charset=euc-kr" %>
<html><title>include 디렉티브</title>
<body>
<%
int number = 10;

%>

<%@ include file="10includee.jspf" %>
공통변수 DATAFOLDER = "<%= dataFolder %>"

</body>
</html>