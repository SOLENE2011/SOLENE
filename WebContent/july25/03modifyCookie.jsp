<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.net.URLEncoder" %>
<%
Cookie[] cookies = request.getCookies();
	if(cookies != null && cookies.length >0) {
		for(int i=0 ; i<cookies.length ; i++) {
			if(cookies[i].getName().equals("name")) {
				Cookie cookie = new Cookie("name2",
						URLEncoder.encode("JSP���α׷���","EUC-KR"));
				response.addCookie(cookie);
			}
		}
	}
%>
<html>
<head><title>�� ����</title>
</head>
<body>
name ��Ű�� ���� �����մϴ�.
</body>
</html>