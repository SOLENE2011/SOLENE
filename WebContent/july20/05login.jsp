<%@ page contentType="text/html; charset=euc-kr" %>
<%
String id = request.getParameter("memberId");
if (id.equals("KH21")) {
	response.sendRedirect("01requestInfo.jsp");
/* response.sendRedirect("../july20/01requestInfo.jsp"); */
/* response.sendRedirect("./01requestInfo.jsp"); */
/* response.sendRedirect("01requestInfo.jsp"); */
/* �̷��� 3���� ������ */
/* ������� ��δ� ���� WEB-INF��� ���� �߽��� ���⿡ ���� ���� ������ ������ */
/* �׷��� �� 3���� �����Ѱ��� */
/* �׸���requst Ư���� ��� ���������� ��θ� �˰� ����! ���� ��û�Ѱ� �о ���� �Ŵϱ� */
} else {

%>

<html>
<head><title>�α��ο� ����</title></head>
<body>
���̵�KH21�� �ƴմϴ�.
</body>
</html>

<%
}
%>
