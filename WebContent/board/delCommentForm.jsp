<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>

<%
String comment_num = request.getParameter("cmn");
String content_num = request.getParameter("ctn");
String p_num = request.getParameter("p_num");
String url = "content.jsp?num="+content_num+"&pageNum="+p_num;

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<title>��ۻ���</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="./js/common.js">
function deleteSave() {
	if(document.delForm.passwd.value=="") {
		alert("��й�ȣ�� �Է��Ͻʽÿ�.")
		document.delForm.passwd.focus();
		return false;
	}
}
</script>
</head>
<body>
<div id="wrap">
	<div id="header"><h1>�ۻ���</h1></div>
	<form name=delForm action="delCommentPro.jsp" onsubmit="retrun deleteSave()">
	<input type=hidden name=content_num value=<%=content_num %> />
	<input type=hidden name=comment_num value=<%=comment_num%> />
		
	<div id="content">
	<div class="delForm">
<p>��й�ȣ�� �Է��� �ּ���</p>
<dl>
		<dt>��й�ȣ</dt>
		<dd><input type="text" name="passwd" /></dd>
</dl>
	</div>
		</div>
		
		<div id="footer" class="deleteBtn">
			<input type="submit" value="����" />
			<input type="button" value="���" onclick="javascript:window.location='<%=url%>'" />
			

</div>
</form>
</div>
</body>
</html>