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
/* list에서 넘어옴 */
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.updateArticle(article);

	if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
<!-- 0초 후에 list.jsp로 새로고침합니다! -->
<%
	} else {
%>
<script language="JavaScript">
	alert("비밀번호가 맞지 않습니다");
	history.go(-1);
</script>
<%
	}
%>