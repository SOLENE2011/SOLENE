<%@page import="kh.board.BoardDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="article" scope="page" class="kh.board.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
<!-- writeForm에서 넘어온 것들로 셋팅 완료함 -->
<!-- 새글이면	int num = 0, ref = 1, re_step = 0, re_level = 0; 넘어왔음  -->

<%
article.setReg_date(new Timestamp(System.currentTimeMillis()));
article.setIp(request.getRemoteAddr());

BoardDBBean dbPro = BoardDBBean.getInstance();
dbPro.insertArticle(article);

response.sendRedirect("list.jsp");

%>