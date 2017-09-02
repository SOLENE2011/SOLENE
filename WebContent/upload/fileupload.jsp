<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.Iterator" %>

<html>
<head>
<title>���ε� ����</title>
</head>
<body>
<%
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart) {
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	List<FileItem> items = upload.parseRequest(request);
	
	Iterator<FileItem> iter = items.iterator();
	
	while (iter.hasNext()) {
		FileItem item = iter.next();
		
		if(item.isFormField()) {
			String name = item.getFieldName();
			String value = item.getString("euc-kr");
			%>
		��û �Ķ����: <%= name %>=<%= value %><br>
<%
		}else {
			String name = item.getFieldName();
			String fileName = item.getName();
			String contentType = item.getContentType();
			boolean isInMemory = item.isInMemory();
			long sizeInBytes = item.getSize();
			
%>	
 ���� : <%= name %>, <%= fileName %>, <%= sizeInBytes %>
 <%= isInMemory ? "�޸�����" : "�ӽ���������" %>
 <br>
 <%
		}
	}
} else {

%>
multipart/form ��û�� �ƴ�.
<%
}
%>
</body>
</html>