<%@ page contentType="text/html; charset=euc-kr" %>
<%
String name = request.getParameter("name");
String value= request.getParameter("value");

if ( name != null && value != null) {
application.setAttribute(name, value);
/* �̸��� name�� �Ӽ��� ���� value�� �����Ѵ�. */
}
%>

<html>
<head><title>application �Ӽ� ����</title></head>
<body>
<%
if(name != null && value != null) {
	%>
	application �⺻ ��ü�� �Ӽ� ����:
	<%= name %> = <%= value %>
	<%
} else{
%>
application �⺻ ��ü�� �Ӽ� ���� ����
<!-- �����Ű�� ?name=kk&value=54�ָ� ��� ��µ�! -->
<%
}
%>
</body>
</html>