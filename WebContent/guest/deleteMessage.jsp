<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@page import="service.DeleteMessageService"%>
<%@page import="service.InvalidMessagePasswordException"%>
<%@ page errorPage="errorView.jsp" %>

<%
int messageId = Integer.parseInt(request.getParameter("messageId"));
String password = request.getParameter("password");
boolean invalidPassword = false;
try {
	DeleteMessageService deleteService = DeleteMessageService.getInstance();
	deleteService.deleteMessage(messageId, password);
	
	
}catch( InvalidMessagePasswordException ex) {
	invalidPassword = true;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�޽��� ����</title>
</head>
<body>
<% if (!invalidPassword) { %>
�޽����� �����Ͽ����ϴ�.
<% } else { %>
�Է��� ��ȣ�� �ùٸ��� �ʽ��ϴ�. ��ȣ�� Ȯ�����ּ���.
<% } %>
<br/>
<a href="list.jsp">[��Ϻ���]</a>
</body>
</html>