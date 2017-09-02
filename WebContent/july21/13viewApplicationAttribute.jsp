<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.util.Enumeration" %>
<html>
<head><title>application 기본 객체 속성 보기</title></head>
<body>
<%
Enumeration attrEnum = application.getAttributeNames();
while( attrEnum.hasMoreElements() ) {
	String name = (String)attrEnum.nextElement();
	Object value = application.getAttribute(name);
	                              /* 이름의 값을 가져온다. */
%>
application 속성  : <b><%= name %></b> = <%= value %><br>
<%
}
%>
</body>
</html>