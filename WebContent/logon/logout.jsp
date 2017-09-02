<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>

<%
	session.invalidate();
	response.sendRedirect("main.jsp");
%>