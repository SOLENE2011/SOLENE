<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "java.io.IOException, java.io.FileReader" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>소스 보기</title></head>
<body>

<%
	FileReader reader = null;
	try {
		String path = request.getParameter("path"); //경로값
		reader = new FileReader(getServletContext().getRealPath(path));
								//상대경로를 받아서 절대경로로 바꿔줌!
								//FileReader는 상대경로가 안됨 절대경로로 넣어줘야함!!!
								// http://localhost:8080/SOLENE/jstl/use_out_tag.jsp?path=/jstl/use_out_tag.jsp
								 															/* web content 다음 주소부터  */
								// 이걸 실행창에 넣으면 됨!!!
%>
<pre>
소스 코드 = <%= path %>
<c:out value="<%= reader %>" escapeXml="true" />
<!-- out이 reader를 읽어서 그대로 출력함 -->

</pre>
<%
	} catch(IOException ex) {
%>
에러: <%= ex.getMessage() %>
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