<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.util.Enumeration" %>
<html>
<head><title>초기화 파라미터 읽어오기</title></head>
<body>

초기화 파라미터 목록:
<ul>
<%
Enumeration initParamEnum = application.getInitParameterNames();
/* JSP객체도 결국 JAVA에서 파생된거임
그래서 앞에는 JAVA객체고 뒤엔 JSP객체지만 이렇게 사용 가능한거임
application객체는 웹 어플리케이션에 대한 정보를 저장함 
application.getInitParameterNames() 은
웹 어플리케이션 초기화 파라미터의 이름 목록을 리턴함
내 프로젝트는 웹어플리케이션이라고 생각하자★
*/
while(initParamEnum.hasMoreElements()) {
	String initParamName = (String)initParamEnum.nextElement();
%>
<!-- li 는 목록요소 -->
<li><%= initParamName %> = 
	<%= application.getInitParameter(initParamName) %>
<%
}
%>
</ul>
</body>
</html>