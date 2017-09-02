<%@page import="article.DeleteArticleService"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%
request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="deleteRequest" class="article.DeleteRequest" />
<jsp:setProperty name="deleteRequest" property="*" />

<%
String viewPage = null;
try {
	DeleteArticleService.getInstance().deleteArticle(deleteRequest);
	viewPage = "./delete_success.jsp";
}catch (Exception ex) {
	request.setAttribute("deleteException", ex);
	viewPage = "./delete_error.jsp";
}
%>
<jsp:forward page="<%= viewPage %>" />