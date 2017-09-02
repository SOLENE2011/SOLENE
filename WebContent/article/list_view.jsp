<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
response.setHeader("Pragma", "No=cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 1L);

String search = (String)request.getParameter("search");

%>

<html>
<head>
<title>�Խñ� ���</title>
</head>
<body>
<table border="1">
<c:if test="${listModel.totalPageCount > 0}">
<tr>
	<td colspan="5">
	${listModel.startRow}-${listModel.endRow} <!-- �Խñ� �� -->
	[${listModel.requestPage}/${listModel.totalPageCount}]<!-- ������ -->
	
	<!--  �̷��� ��µʴϴ�. 1-10 [1/2]    -->
	
	</td>
</tr>
</c:if>

<tr>
	<td>�� ��ȣ</td>
	<td>����</td>
	<td>�ۼ���</td>
	<td>�ۼ���</td>
	<td>��ȸ��</td>
</tr>

<c:choose>
<c:when test="${listModel.hasArticle == false}">
<tr>
	<td colspan="5">
		�Խñ��� �����ϴ�.
	</td>
</tr>
</c:when>
<c:otherwise>
<c:forEach var="article" items="${listModel.articleList}">
<tr>
	<td>${article.id}</td>
	<td>
	<c:if test="${article.level > 0 }">
	<c:forEach begin="1" end="${article.level }">-</c:forEach>&gt;
	
	<!-- �亯���� ��� ��ø ������ ���� -> ���� ��� -->
	
	</c:if>
	
	<!-- ���⼭���� �Խñ� ���� �� �б� ������ �̵� ��ũ -->
	<c:set var="query" value="articleId=${article.id }&p=${listModel.requestPage }" />
	<a href="<c:url value="./read.jsp?${query}" />">
	${article.title}
	</a>
	</td>
	<td>${article.writerName }</td>
	<td>${article.postingDate }</td>
	<td>${article.readCount }</td>
</tr>
</c:forEach>

<tr>
	<td colspan="5">
	
	<!-- ������ �̵� ��ũ -->
	<c:if test="${beginPage > 10 }">
		<a href="<c:url value="./list.jsp?p=${beginPage-1}"/>">����</a>
	</c:if>
	
	<c:if test="${search!= null }">
	<c:forEach var="pno" begin="${beginPage}" end="${endPage}">
	<a href="<c:url value="./list.jsp?p=${pno}&searchn=${searchn }&search=${search }" />">[${pno}]</a>
	</c:forEach>	
	</c:if>
	<c:if test="${search==null }">
	<c:forEach var="pno" begin="${beginPage}" end="${endPage}">
		<a href="<c:url value="./list.jsp?p=${pno}" />">[${pno}]</a>
	</c:forEach>
	</c:if>
	<c:if test="${endPage < listModel.totalPageCount}">
		<a href="<c:url value="./list.jsp?p=${endPage + 1}" />">����</a>
	</c:if>
	</td>
</tr>
</c:otherwise>
</c:choose>

<tr>
	<td colspan="5">
		<a href="writeForm.jsp">�۾���</a>
	</td>
</tr>
</table>
<form>
<select name="searchn">
<option value="0">�ۼ���</option>
<option value="1">����</option>
<option value="2">����</option>
</select>

<input type="text" name="search" size="20" maxlength="50" /> 
<input type="submit" value="�˻�" /> &nbsp;&nbsp;
<input type="button" value ="�������" onclick="javascript:window.location='list.jsp'" />

</form>
</body>
</html>