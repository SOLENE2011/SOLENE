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
	//�� ������ �����ϸ�
	%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%= pageNum %>">
<!-- 0���Ŀ� list.jsp�� ���ΰ�ħ�Ѵ� -->
<% 
}else {
%>
<script language="JavaScript">
alert("��й�ȣ�� ���� �ʽ��ϴ�");
history.go(-1);
</script>
<%
}
%>