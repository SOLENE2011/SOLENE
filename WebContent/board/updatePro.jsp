<%@page import="kh.board.BoardDBBean"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%
	request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="article" scope="page" class="kh.board.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
<%
	String pageNum = request.getParameter("pageNum");
/* list���� �Ѿ�� */
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.updateArticle(article);

	if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
<!-- 0�� �Ŀ� list.jsp�� ���ΰ�ħ�մϴ�! -->
<%
	} else {
%>
<script language="JavaScript">
	alert("��й�ȣ�� ���� �ʽ��ϴ�");
	history.go(-1);
</script>
<%
	}
%>