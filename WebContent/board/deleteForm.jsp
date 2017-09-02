<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>글삭제</title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
<script type="text/javascript" src="js/common.js">
function deleteSave() {
	if(document.delForm.passwd.value=="") {
		alert("비밀번호를 입력하십시요");
		document.delForm.passwd.focus();
		return false;
	}
}
</script>
<body>


<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>



<div id="wrap">
	<div id="header"><h1>글삭제</h1></div>
	
<form name="delForm" action="deletePro.jsp?pageNum=<%= pageNum %>"
			onsubmit="return deleteSave()">
			
			<input type="hidden" name="num" value="<%= num %>" />
		<div id="content">
			<div class="delForm">
				<p>비밀번호를 입력해주세요.</p>
				<dl>
					<dt>비밀번호</dt>
					<dd><input type="text" name="passwd" /></dd>
				</dl>
			</div>
		</div>
			
			<div id="footer" class="deleteBtn">	
			<input type="submit" value="글삭제"> 
			<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'">
				
		</div>
	</form>
</div>	
</body>
</html>