<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.Iterator" %>

<html>
<head>
<title>업로드 정보</title>
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
		요청 파라미터: <%= name %>=<%= value %><br>
<%
		}else {
			String name = item.getFieldName();
			String fileName = item.getName();
			String contentType = item.getContentType();
			boolean isInMemory = item.isInMemory();
			long sizeInBytes = item.getSize();
			
%>	
 파일 : <%= name %>, <%= fileName %>, <%= sizeInBytes %>
 <%= isInMemory ? "메모리저장" : "임시파일저장" %>
 <br>
 <%
		}
	}
} else {

%>
multipart/form 요청이 아님.
<%
}
%>
</body>
</html>