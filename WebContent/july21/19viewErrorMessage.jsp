<%@ page isErrorPage="true" %>
<%@ page contentType="text/html; charset=euc-kr" %>
<html><head><title>에러 페이지</title>

<script>
function showDetail() {
	d=document.getElementByld('detail');
	d.style.display = 'block';
}
</script>
</head>
<body>
<h3 id="header"> <%= exception.getClass().getName() %> </h3>
<div id = "main">
	<%= exception.getMessage() %>
	<input type= "button" onClick="showDetail()" value="상세보기">
	<div id="detail" style="display:none">
	<% exception.printStackTrace(new java.io.printWriter(out)); %>
</div>
</body>
</html>
