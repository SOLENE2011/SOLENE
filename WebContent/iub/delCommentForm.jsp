<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>

<%
String comment_num = request.getParameter("cmn");
String content_num = request.getParameter("ctn");
String p_num = request.getParameter("page");
String url = "list.jsp?num="+content_num+"&pageNum="+p_num;
String themeId = request.getParameter("id");
System.out.println(themeId+"delcommentForm" );
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<title>댓글삭제</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="./js/common.js">
function deleteSave() {
	if(document.delForm.passwd.value=="") {
		alert("비밀번호를 입력하십시요.")
		document.delForm.passwd.focus();
		return false;
	}
}
</script>
</head>
<body>
<div id="wrap">
	<div id="header"><h1>글삭제</h1></div>
	<form name=delForm action="delCommentPro.jsp" onsubmit="retrun deleteSave()">
	<input type=hidden name=content_num value=<%=content_num %> />
	<input type=hidden name=comment_num value=<%=comment_num%> />
	<input type="hidden" name = "id" value = <%=themeId %> />	
	<div id="content">
	<div class="delForm">
<p>비밀번호를 입력해 주세요</p>
<dl>
		<dt>비밀번호</dt>
		<dd><input type="text" name="passwd" /></dd>
</dl>
	</div>
		</div>
		
		<div id="footer" class="deleteBtn">
			<input type="submit" value="삭제" />
			<input type="button" value="취소" onclick="javascript:window.location='<%=url%>'" />
			

</div>
</form>
</div>
</body>
</html>