<%@ page contentType="text/html; charset=euc-kr"%>
<%
	request.setAttribute("name", "SOLENE");
%>
<html>
<head>
<title>EL Object</title>
</head>
<body>

	요청 URI: ${pageContext.request.requestURI}
	<br>

	<%-- 
	<%= pageContext.getRequest().getRequestURI()%>
 --%>
	request의 name 속성: ${requestScope.name}
	 
	 <br>
	<%--
	<%= request.getAttribute("name")%>
 --%>
	
	<FORM action="useELObject.jsp" method="post">
 코드 : <input type="text" name="code"> 
   											<!-- request.getParameter!! -->
      <input type="submit" value="확인">
</FORM>

	code 파라미터: ${param.code}
	<%--<%= request.getParameter("code")%>
 --%>
	
</body>
</html>
