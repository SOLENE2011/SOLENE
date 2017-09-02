<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	HashMap<String,Object> mapData = new HashMap<String,Object>();
	//Object 모든 것이 들어갈 수 있음
	mapData.put("name", "SOLENE");
	mapData.put("today", new java.util.Date());
%>
<c:set var="intArray" value="<%= new int[] {1,2,3,4,5} %>" />
<c:set var="map" value="<%= mapData %>" />
<html>
<head><title>forEach 태그</title></head>
<body>
<h4>1부터 100까지 홀수의 합</h4>
<c:set var="sum" value="0" />
<c:forEach var="i" begin="1" end="100" step="2">
<!-- map의 각 항목을 처리할때 사용함 -->
<!-- 1부터 100까지 1씩 증가함! 홀수 -->
<c:set var="sum" value="${sum + i}" />
</c:forEach>
결과 = ${sum}
<!-- el통해 출력함 -->
<h4>구구단: 4단</h4>
<ul>
<c:forEach var="i" begin="1" end="9">
<!-- step 생략되면 1씩 증가 -->
	<li>4 * ${i} = ${4 * i}
</c:forEach>
</ul>

<h4>int형 배열</h4>

<c:forEach var="i" items="${intArray}" begin="2" end="4" varStatus="status">
	${status.index}-${status.count}-[${i}] <br />
	<!-- 2-1-[3] 
		3-2-[4] 
		4-3-[5] --> 
</c:forEach>

<h4>Map</h4>

<c:forEach var="i" items="${map}">
<!-- map에서 꺼내서 i에 저장 -->
	${i.key} = ${i.value}<br>
</c:forEach>

</body>
</html>
