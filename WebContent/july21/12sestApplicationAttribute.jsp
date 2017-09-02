<%@ page contentType="text/html; charset=euc-kr" %>
<%
String name = request.getParameter("name");
String value= request.getParameter("value");

if ( name != null && value != null) {
application.setAttribute(name, value);
/* 이름이 name인 속성의 값을 value로 지정한다. */
}
%>

<html>
<head><title>application 속성 지정</title></head>
<body>
<%
if(name != null && value != null) {
	%>
	application 기본 객체의 속성 설정:
	<%= name %> = <%= value %>
	<%
} else{
%>
application 기본 객체의 속성 설정 안함
<!-- 실행시키고 ?name=kk&value=54주면 결과 출력됨! -->
<%
}
%>
</body>
</html>