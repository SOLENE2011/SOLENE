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
<title>로그인성공</title>
</head>
<body>로그인에 성공했습니다.
</body>
</html>
<%
	} else {
%>
<script>
	alert("로그인에 실패하였습니다.");
	history.go(-1);
</script>
<%
	}
%>