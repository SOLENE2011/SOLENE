<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String value = request.getParameter("ck");

	if (id.equals(password)) {
		session.setAttribute("MEMBERID", id);
		if(value!=null && value.equals("checked")){
			Cookie cookie = new Cookie("id",URLEncoder.encode(id));
			cookie.setMaxAge(60);
			response.addCookie(cookie);
		}
%>
<html>
<head>
<title>�α��μ���</title>
</head>
<body>�α��ο� �����߽��ϴ�.
</body>
</html>
<%
	} else {
%>
<script>
	alert("�α��ο� �����Ͽ����ϴ�.");
	history.go(-1);
</script>
<%
	}
%>