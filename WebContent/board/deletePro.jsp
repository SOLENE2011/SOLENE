<%@page import="kh.board.BoardDBBean"%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%
request.setCharacterEncoding("euc-kr");
%>

<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String passwd = request.getParameter("passwd");

BoardDBBean dbPro = BoardDBBean.getInstance();
int check = dbPro.deleteArticle(num, passwd);

if(check == 1) {
	//글 삭제가 성공하면
	%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%= pageNum %>">
<!-- 0초후에 list.jsp로 새로고침한다 -->
<% 
}else {
%>
<script language="JavaScript">
alert("비밀번호가 맞지 않습니다");
history.go(-1);
</script>
<%
}
%>