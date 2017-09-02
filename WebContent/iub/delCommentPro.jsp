<%@page import="kh.board.CommentDBBean"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.Timestamp" %>

<%
request.setCharacterEncoding("euc-kr");

%>

<%
int content_num = Integer.parseInt(request.getParameter("content_num"));
int comment_num = 1;
if(request.getParameter("comment_num")!=null){
	comment_num = Integer.parseInt(request.getParameter("comment_num"));
}
int comment_num1 = Integer.parseInt(request.getParameter("comment_num"));

String themeId = request.getParameter("id");
String passwd = request.getParameter("passwd");

CommentDBBean cmtPro = CommentDBBean.getInstance();
int check = cmtPro.deleteComment(content_num, passwd, comment_num);

if(check==1) {
%>
<meta http-equiv=Refresh content="0;url=read.jsp?num=<%=content_num%>&pageNum=<%=comment_num %>&id=<%=themeId %>">
<% }else{ %>
	<script language="javascript">
	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);
	</script>
	<% } %>
	