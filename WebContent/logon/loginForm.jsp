<!-- �����̶� ���� �����! -->
<!-- ���̹� ī��, ����, ��α� �����ϱ�! -->
<!-- �α����� �Ǿ������� else������ ������! �α��εǾ������� ī��,����,��α� �ٷ� �̿� -->


<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�α���</title>
<link href="../css/style.css" rel = "stylesheet" type = "text/css" />
</head>
<body onload="begin()">
<!-- body �±װ� ���۵Ǹ� begin�޼ҵ带 �����Ѵ� -->
	<!--  before login -->
<%
	if(session.getAttribute("memId")==null){
%>
	<script type="text/javascript">
	
	function begin() {
		documetn.myform.id.focus();
	}
	function checkIt() {
		if(!document.myform.id.value){
			alert("�̸��� �Է����� �����̽��ϴ�.");
			document.myform.id.focus();
			return false;
		}
		if(!document.myform.passwd.value){
			alert("��й�ȣ�� �Է����� �����̽��ϴ�.");
			document.myform.passwd.focus();
			return false;
		}
	}	
	</script>
	
	<% /* ��Ű�� �ҷ����� �۾��� */
	Cookie[] cookie = request.getCookies();
	String id = "";
	if(cookie != null){ /* ��Ű�� ���� �ִٸ� */
		for(Cookie cookies : cookie){
			if(cookies.getName().equals("id"))
				/* ��Ű�� �ִ� �̸��� ���� LoginPro���� ��������Ű id�� ���� ��Ű �ҷ�����  */
				id = cookies.getValue();
			}
		}				
	%>
<div id="loginWrap">
	<h1>Member Login</h1>
	<form action="loginPro.jsp" method="post" name="myform" onsubmit="return checkIt();">
		<fieldset>
			<legend>�α���</legend>
			<dl>
				<dt>Id</dt>
				<dd><input type="text" name="id" maxlength="10" value="<%=id %>" /></dd>
				<dt>Password</dt>
				<dd><input type="password" name="passwd" maxlength="10" /></dd>
			</dl>
			<div class="btnArea">
				<input type="submit" name="Submit" value="Ok" />
				<input type="reset" value="Reset" />
				<input type="button" value="Join" onclick="javascript:window.location='inputForm.jsp'" />
			</div>
		</fieldset>
	</form>
</div>

<%
	} else {
%>

<!-- after login -->
<div id="loginWrap">
	<h1>Welcome to my world!</h1>
	<div class="afterLogin">
		<p><strong><%= session.getAttribute("memId") %></strong>�� ȯ���մϴ�.</p>
		<form action="logout.jsp" method="post">
			<div class="btnArea">
				<input type="submit" name="Submit" value="Logout" />
				<input type="button" value="Modify" onclick="javascript:window.location='modify.jsp'" />
				<input type="button" value="List" onclick="javascript:window.location='/SOLENE/board/list.jsp'"></input>
			</div>
		</form>
	</div>
</div>

<% } %>
</body>
</html>
	
	
