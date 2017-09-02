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
<title>게시글 목록</title>
</head>
<body>
<table border="1">
<c:if test="${listModel.totalPageCount > 0}">
<tr>
	<td colspan="5">
	${listModel.startRow}-${listModel.endRow} <!-- 게시글 수 -->
	[${listModel.requestPage}/${listModel.totalPageCount}]<!-- 페이지 -->
	
	<!--  이렇게 출력됨니다. 1-10 [1/2]    -->
	
	</td>
</tr>
</c:if>

<tr>
	<td>글 번호</td>
	<td>제목</td>
	<td>작성자</td>
	<td>작성일</td>
	<td>조회수</td>
</tr>

<c:choose>
<c:when test="${listModel.hasArticle == false}">
<tr>
	<td colspan="5">
		게시글이 없습니다.
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
	
	<!-- 답변글인 경우 중첩 레벨에 따라 -> 글자 출력 -->
	
	</c:if>
	
	<!-- 여기서부터 게시글 제목 및 읽기 페이지 이동 링크 -->
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
	
	<!-- 페이지 이동 링크 -->
	<c:if test="${beginPage > 10 }">
		<a href="<c:url value="./list.jsp?p=${beginPage-1}"/>">이전</a>
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
		<a href="<c:url value="./list.jsp?p=${endPage + 1}" />">다음</a>
	</c:if>
	</td>
</tr>
</c:otherwise>
</c:choose>

<tr>
	<td colspan="5">
		<a href="writeForm.jsp">글쓰기</a>
	</td>
</tr>
</table>
<form>
<select name="searchn">
<option value="0">작성자</option>
<option value="1">제목</option>
<option value="2">내용</option>
</select>

<input type="text" name="search" size="20" maxlength="50" /> 
<input type="submit" value="검색" /> &nbsp;&nbsp;
<input type="button" value ="목록으로" onclick="javascript:window.location='list.jsp'" />

</form>
</body>
</html>