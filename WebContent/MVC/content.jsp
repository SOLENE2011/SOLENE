<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="color.jspf" %>

<html>
<head>
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
a:link { color:black; text-decoration:none;}a:link { color:black; text-decoration:none; }
a:visited {  }
a:active { text-decoration:underline; }
a:hover { text-decoration:underline; background-image:url('text_dottdeline.gif'); background-repeat:repeat-x; background-position:50% 100%; }

</style>
<style>

@font-face {font-family:����; src:url();}
body,td,a,div,p,pre,input,textarea {font-family:����;font-size:9pt;}
</style>
</head>

<body bgcolor="${bodyback_c}">
<center><b>�� ���� ����</b>
<br>
<form>

<table width="500" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c}">�۹�ȣ</td>
		<td align="center" width="125" align="center">${article.num}</td>
		<td align="center" width="125" bgcolor="${value_c}">��ȸ��</td>
		<td align="center" width="125" align="center">${article.readcount}</td>
	</tr>
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c}">�ۼ���</td>
		<td align="center" width="125" align="center">${article.writer}</td>
		<td align="center" width="125" bgcolor="${value_c}">�ۼ���</td>
		<td align="center" width="125" align="center">${article.reg_date}</td>
	</tr>
	
	<tr height="30">
		<td align="center" width="125" bgcolor="${value_c}">������</td>
		<td align="center" width="375" align="center" colspan="3">${article.subject}</td>
	</tr>
	
	<tr>
		<td align="center" width="125" bgcolor="${value_c}">�۳���</td>
		<td align="left" width="375" colspan="3"><pre>${article.content}</pre></td>
	</tr>
	
	<tr height="30">
		<td colspan="4" bgcolor="${value_c}" align="right">	
			<input type="button" value="�ۼ���"	
			onclick="document.location.href='/SOLENE/MVC/updateForm.do?num=${article.num}&pageNum=${pageNum}'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="�ۻ���"	
			onclick="document.location.href='/SOLENE/MVC/deleteForm.do?num=${article.num}&pageNum=${pageNum}'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="��۾���"	
			onclick="document.location.href='/SOLENE/MVC/writeForm.do?num=${article.num}&ref=${article.ref}&re_step=${article.re_step}&re_level=${article.re_level}'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="�۸��"	
			onclick="document.location.href='/SOLENE/MVC/list.do?pageNum=${pageNum}'">
		</td>
	</tr>
</form>	

<form method=post name="comment" action="/SOLENE/MVC/commentPro.do">
	<tr bgcolor="${value_c}" align=center>
		<td>�ڸ�Ʈ �ۼ�</td>
		<td colspan=2>
		<textarea name=commentt rows="6" cols="40"></textarea>
		<input type="hidden" name="content_num" value="${article.num}">
		<input type="hidden" name="p_num" value="${pageNum}">
		<input type="hidden" name="comment_num" value="${count+1}"></td>
		
		<td align=center>�ۼ���<br>
		<c:if test="${session.getattribute('memId')!=null}">
			<input type="text" name="commenter" size="8" value="<%= c.getId() %>">
		</c:if>
		<c:if test="${session.getattribute('memId')=null}">
			<input type="text" name="commenter" size="8">
		</c:if>
			<br>��й�ȣ<br>
			<input type="password" name="passwd" size="10">
			<p>
			<input type="submit" value="�ڸ�Ʈ�ޱ�"	
		</td>
	</tr>
</form>
</table>

<c:if test="${count>0}">
</c:if>

</body>
</html>