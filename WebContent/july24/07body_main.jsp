<%@ page contentType="text/html; charset=euc-kr" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<html>
<head><title>INFO</title></head>
<body>

include �� name �Ķ���� ��: <%= request.getParameter("name") %>
<!-- ���� �θ��µ� ���� ������ null���� ��  -->
<!-- �� ���� �ҷ��ͼ� �񱳸� �Ҷ� ���� ������ null exception  -->
<hr>

<jsp:include page="08body_sub.jsp" flush="false">
	<jsp:param name="name" value="�ֹ���" />
</jsp:include>

<hr/>

include �� name �Ķ���� ��: <%= request.getParameter("name") %>
<!-- ��� ���� null�� ������ include�� ���ʿ��� ó���ϰ� �� ������� �Ķ���͸� �������� ����! -->
</body>
</html>
