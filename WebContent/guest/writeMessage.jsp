<%@page import="service.WriteMessageService"%>
<%@ page import ="model.*" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page errorPage="errorView.jsp" %>

<%
request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="message"  class="model.Message">
<jsp:setProperty name="message" property="*" />
</jsp:useBean>

<%
WriteMessageService writeService = WriteMessageService.getInstance();
writeService.write(message);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>���� �޽��� ����</title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
</head>
<body>
<div id="wrap">

	<div id="content">
		<div class="delForm">
<p>���Ͽ� �޽����� ������ϴ�.</p>
			<span class="delBtn"><input type="button" value="���" onclick="javascript:window.location='list.jsp'" /></span>
		</div>
	</div>
		
</div>
</body>
</html>