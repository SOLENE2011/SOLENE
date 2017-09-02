<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>

<% 
	request.setCharacterEncoding("euc-kr");
%>


<jsp:forward page="../imageboard/template/template.jsp">
	<jsp:param name="CONTENTPAGE" value="/iub/list_view.jsp"/>
</jsp:forward>
