<%@ page contentType="text/html; charset=euc-kr"%>
<%
	request.setAttribute("name", "SOLENE");
%>
<html>
<head>
<title>EL Object</title>
</head>
<body>

	��û URI: ${pageContext.request.requestURI}
	<br>

	<%-- 
	<%= pageContext.getRequest().getRequestURI()%>
 --%>
	request�� name �Ӽ�: ${requestScope.name}
	 
	 <br>
	<%--
	<%= request.getAttribute("name")%>
 --%>
	
	<FORM action="useELObject.jsp" method="post">
 �ڵ� : <input type="text" name="code"> 
   											<!-- request.getParameter!! -->
      <input type="submit" value="Ȯ��">
</FORM>

	code �Ķ����: ${param.code}
	<%--<%= request.getParameter("code")%>
 --%>
	
</body>
</html>
