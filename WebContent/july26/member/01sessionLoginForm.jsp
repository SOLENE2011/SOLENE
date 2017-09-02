<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.net.*"%>
<html>
<head>
<title>로그인폼</title>
</head>
<body>
	<form
		action="<%=request.getContextPath()%>/july26/member/02sessionLogin.jsp" method="post">
		
<%
		Cookie[] cookies = request.getCookies();
		String checkId ="";
		
		for(int i =0 ; i<cookies.length; i++){
			if(cookies[i].getName().equals("id")){
				checkId = URLDecoder.decode(cookies[i].getValue(),"euc-kr");
			}
		}
		
		%>
아이디<input type="text" name="id" size="10" value = <%=checkId %>>
암호<input type="password" name="password" size="10">
아이디저장<input type="checkbox" name="ck" value="checked"> 
<input type="submit" value="로그인">

</form>
</body>
</html>