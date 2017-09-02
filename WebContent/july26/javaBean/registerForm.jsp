<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입</title>
<link href="style.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="<%= bodyback_c %>">
<form action="registerPro.jsp" name="regForm" method="post" onsubmit="return inputCheck()">
	<table border="1" cellpadding="5" cellspacing="0" width="800">
		<colgroup>
			<col width="20%" />
			<col width="*" />
			<col width="30%" />
		</colgroup>
		<tr>
			<td colspan="3"><strong>회원가입</strong></td>
		</tr>
		<tr>
			<th bgcolor="<%= title_c %>">아이디</th>
			<td bgcolor="<%= value_c %>"><input type="text" name="id" size="20" /></td>
			<td bgcolor="<%= value_c %>">아이디를 입력하세요.</td>
		</tr>
		<tr>
			<th bgcolor="<%= title_c %>">비밀번호</th>
			<td bgcolor="<%= value_c %>"><input type="text" name="passwd" size="20" /></td>
			<td bgcolor="<%= value_c %>">비밀번호를 입력하세요.</td>
		</tr>
		<tr>
			<th bgcolor="<%= title_c %>">비밀번호</th>
			<td bgcolor="<%= value_c %>"><input type="text" name="repasswd" size="20" /></td>
			<td bgcolor="<%= value_c %>">비밀번호를 재입력하세요.</td>
		</tr>
		<tr>
			<th bgcolor="<%= title_c %>">이름</th>
			<td bgcolor="<%= value_c %>"><input type="text" name="name" size="20" /></td>
			<td bgcolor="<%= value_c %>">이름을 입력하세요.</td>
		</tr>
		<tr>
			<th bgcolor="<%= title_c %>">이메일</th>
			<td bgcolor="<%= value_c %>"><input type="text" name="email" size="30" /></td>
			<td bgcolor="<%= value_c %>">이메일 입력하세요.</td>
		</tr>
		<tr>
			<th bgcolor="<%= title_c %>">전화번호</th>
			<td bgcolor="<%= value_c %>"><input type="text" name="tel" size="20" /></td>
			<td bgcolor="<%= value_c %>">전화번호 입력하세요.</td>
		</tr>
		<tr>
			<td colspan="3" height="50" align="center"><input type="submit" value="회원가입" /> <input type="reset" value="다시작성" ></td>
		</tr>
	</table>
</form>
</body>
</html>