<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page errorPage = "./19viewErrorMessage.jsp" %>
<%-- <%@ page errorPage = "./18errorNullPointer.jsp" %> --%>
<!-- ���⿡ ������������ �����ִ°��� ���� �켱������ ���� -->
<!-- ���⼭ �� �����ָ� web.xml�� �����Ѵ�� ������������ ������ -->
<html>
<head><title>�ĸ����� ���</title></head>
<body>

name �Ķ���� ��: <%= request.getParameter("name").toUpperCase() %>
					<!-- toUpperCase �Ű����� ���� �̷� ������ �� -->

</body>
</html>