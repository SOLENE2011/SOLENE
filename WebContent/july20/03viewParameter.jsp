<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Map" %>

<%
request.setCharacterEncoding("euc-kr");
%>
<html>
<head><title>요청 파라미터 출력</title></head>
<body>
<b>request.getParameter() 메소드 사용</b>
name 파라미터 = <%= request.getParameter("name") %> <br>
<!-- 이름이 name인 파라미터의 값을 구해옴 -->
address 파라미터 = <%= request.getParameter("address") %>
<p>
<b>request.getParameterValue() 메소드 사용</b><br>
<%
String[] values = request.getParameterValues("pet");
if(values != null) {
	for(int i=0; i<values.length; i++) {
		%>
		<%=values[i] %>
		
	<%
	
	}
}
%>
<p>
<b>request.getParameterNames() 메소드 사용</b><br>
<%
Enumeration paramEnum = request.getParameterNames();
while(paramEnum.hasMoreElements()) {
String name = (String)paramEnum.nextElement();
%>
<%= name %>
<%
}
%>

<p>
<b>request.getParameterMap() 메소드 사용</b><br>
<%
	Map parameterMap = request.getParameterMap();
	String[] nameParam = (String[])parameterMap.get("name");
	if (nameParam != null) {
%>
name = <%= nameParam[0] %>
<%
	}
%>
</body>
</html>





