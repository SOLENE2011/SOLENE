<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.net.URLDecoder" %>

<%
String memberId = (String)session.getAttribute("MEMBERID");
boolean login = memberId ==null? false : true;
%>

<%
Cookie[] cookies = request.getCookies();
if(cookies != null && cookies.length>0){
	for(int i=0; i<cookies.length;i++){
		%>
		<%= cookies[i].getName() %> =
		<%= URLDecoder.decode(cookies[i].getValue(), "euc-kr") %>
	<%	
	}
}
%> <br>

<html>
<head><title>�α��ο��� �˻�</title></head>
<body>
<%
if(login) {
	%>
���̵� "<%= memberId %>"�� �α��� �� ����
<%
} else {
%>
�α������� ���� ����
<%
}
%>
</body>
</html>