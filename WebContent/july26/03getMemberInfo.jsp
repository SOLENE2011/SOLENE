<%@ page contentType="text/html; charset=euc-kr" %>

<%
String memberID = (String)session.getAttribute("MEMBERID");
String name = (String)session.getAttribute("NAME");

%>
<html>
<head><title>���ǿ��� ���� ��������</title></head>
<body>
���ǿ��� ������ ������<br>
memberID�� <%= memberID %><br>
name�� <%= name %>�Դϴ�.

</body>
</html>