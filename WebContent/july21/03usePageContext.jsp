<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head><title>pageContext �⺻ ��ü</title></head>
<body>
<%
	HttpServletRequest httpRequest =
	(HttpServletRequest)pageContext.getRequest();
/* pageContext.getRequest�� request �⺻ ��ü�� ���Ѵٴ� �ǹ�  */
%>

request �⺻ ��ü�� pageContext.getRequest()�� ���Ͽ���:
 <%= request == httpRequest %>
 
 <br>
 
 pageContext.getOut() �޼��带 ����� ������ ���:
 <!-- pageContext.getOut() �̰� out �⺻ ��ü�� ���Ѵ�. -->
 <% pageContext.getOut().println("�ȳ��ϼ���!"); %>
<br>
<br>
<%
out.println("�ȳ��ϼ���!");
/* ���� pageContext.getOut().println("�ȳ��ϼ���!");������ */
%>


</body>
</html>