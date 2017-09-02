<%@page import="article.ArticleNotFoundException"%>
<%@page import="article.ReadArticleService"%>
<%@page import="article.Article"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<%
int articleId = Integer.parseInt(request.getParameter("articleId")); //read_view¿¡¼­ ³Ñ¾î¿È
String viewPage = null;
try {
	Article article = ReadArticleService.getInstance().readArticle(articleId);
	//ÀÚ¹Ùºó °´Ã¼ ÇÏ³ª ¾ò¾î³¿
	request.setAttribute("article", article);
	viewPage = "./read_view.jsp";
}catch (ArticleNotFoundException ex) {
	viewPage = "./article_not_found.jsp";
	
}
%>
<jsp:forward page="<%= viewPage %>" />