<%@page import="kh.board.BoardDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="article" scope="page" class="kh.board.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
<!-- writeForm���� �Ѿ�� �͵�� ���� �Ϸ��� -->
<!-- �����̸�	int num = 0, ref = 1, re_step = 0, re_level = 0; �Ѿ����  -->

<%
article.setReg_date(new Timestamp(System.currentTimeMillis()));
article.setIp(request.getRemoteAddr());

BoardDBBean dbPro = BoardDBBean.getInstance();
dbPro.insertArticle(article);

response.sendRedirect("list.jsp");

%>