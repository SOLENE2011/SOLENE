<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.net.*"%>
<html>
<head>
<title>�α�����</title>
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
���̵�<input type="text" name="id" size="10" value = <%=checkId %>>
��ȣ<input type="password" name="password" size="10">
���̵�����<input type="checkbox" name="ck" value="checked"> 
<input type="submit" value="�α���">

</form>
</body>
</html>