<%@page import="pds.FileDownloadHelper"%>
<%@page import="pds.PdsItemNotFoundException"%>
<%@page import="pds.IncreaseDownloadCountService"%>
<%@page import="pds.GetPdsItemService"%>
<%@page import="pds.PdsItem"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.net.URLEncoder" %>


<%
int id = Integer.parseInt(request.getParameter("id"));
try {
	PdsItem item = GetPdsItemService.getInstance().getPdsItem(id);
	
	response.reset();
	
	String fileName = new String(item.getFileName().getBytes("euc-kr"), "iso-8859-1");
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName+"\"");
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setContentLength((int)item.getFileSize());
	response.setHeader("Pragma", "no-chche;");
	response.setHeader("Expires", "-1;");
	
	FileDownloadHelper.copy(item.getRealPath(),	response.getOutputStream());
	
	response.getOutputStream().close();
	
	IncreaseDownloadCountService.getInstance().increaseCount(id);
	
}catch (PdsItemNotFoundException ex) {
	response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	
}
%>


<html>
<head>
<title></title>
</head>
<body>

</body>
</html>