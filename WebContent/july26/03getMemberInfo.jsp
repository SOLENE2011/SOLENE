<%@ page contentType="text/html; charset=euc-kr" %>

<%
String memberID = (String)session.getAttribute("MEMBERID");
String name = (String)session.getAttribute("NAME");

%>
<html>
<head><title>세션에서 정보 가져오기</title></head>
<body>
세션에서 가져온 정보는<br>
memberID는 <%= memberID %><br>
name은 <%= name %>입니다.

</body>
</html>