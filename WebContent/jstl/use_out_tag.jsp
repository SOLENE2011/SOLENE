<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "java.io.IOException, java.io.FileReader" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>�ҽ� ����</title></head>
<body>

<%
	FileReader reader = null;
	try {
		String path = request.getParameter("path"); //��ΰ�
		reader = new FileReader(getServletContext().getRealPath(path));
								//����θ� �޾Ƽ� �����η� �ٲ���!
								//FileReader�� ����ΰ� �ȵ� �����η� �־������!!!
								// http://localhost:8080/SOLENE/jstl/use_out_tag.jsp?path=/jstl/use_out_tag.jsp
								 															/* web content ���� �ּҺ���  */
								// �̰� ����â�� ������ ��!!!
%>
<pre>
�ҽ� �ڵ� = <%= path %>
<c:out value="<%= reader %>" escapeXml="true" />
<!-- out�� reader�� �о �״�� ����� -->

</pre>
<%
	} catch(IOException ex) {
%>
����: <%= ex.getMessage() %>
<% 
	} finally {
		if (reader != null)
			try {
				reader.close();
			} catch(IOException ex) {}
	}
%>

</body>
</html>