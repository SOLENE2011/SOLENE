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
<head><title>로그인여부 검사</title></head>
<body>
<%
if(login) {
	%>
아이디 "<%= memberId %>"로 로그인 한 상태
<%
} else {
%>
로그인하지 않은 상태
<%
}
%>
</body>
</html>