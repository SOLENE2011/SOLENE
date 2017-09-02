<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.InputStream" %>

<%
InputStream is = request.getInputStream();
ServletOutputStream os = response.getOutputStream();

os.write('[');
os.write(request.getContentType().getBytes());
os.write(']');
os.write('\n');

int data = -1;
while ((data = is.read()) != -1) {
	os.write(data);
}
%>
