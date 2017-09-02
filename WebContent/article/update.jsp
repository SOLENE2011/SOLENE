<%@page import="article.UpdateArticleService"%>
<%@page import="article.Article"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%
request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="updateRequest" 
	class="article.UpdateRequest" />
<jsp:setProperty name="updateRequest" property="*" />

<%
String viewPage = null;
try {
	Article article= UpdateArticleService.getInstance().update(updateRequest);
	request.setAttribute("updatedArticle", article);
	viewPage = "./update_success.jsp";
}catch (Exception ex) {
	request.setAttribute("updateException", ex);
	viewPage = "./update_error.jsp";
}
%>
<jsp:forward page="<%= viewPage %>" />