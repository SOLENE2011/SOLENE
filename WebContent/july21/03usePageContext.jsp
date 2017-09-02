<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head><title>pageContext 기본 객체</title></head>
<body>
<%
	HttpServletRequest httpRequest =
	(HttpServletRequest)pageContext.getRequest();
/* pageContext.getRequest는 request 기본 객체를 구한다는 의미  */
%>

request 기본 객체와 pageContext.getRequest()의 동일여부:
 <%= request == httpRequest %>
 
 <br>
 
 pageContext.getOut() 메서드를 사용한 데이터 출력:
 <!-- pageContext.getOut() 이건 out 기본 객체를 구한다. -->
 <% pageContext.getOut().println("안녕하세요!"); %>
<br>
<br>
<%
out.println("안녕하세요!");
/* 위에 pageContext.getOut().println("안녕하세요!");랑같음 */
%>


</body>
</html>