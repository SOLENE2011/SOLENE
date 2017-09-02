<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	HashMap<String,Object> mapData = new HashMap<String,Object>();
	//Object ��� ���� �� �� ����
	mapData.put("name", "SOLENE");
	mapData.put("today", new java.util.Date());
%>
<c:set var="intArray" value="<%= new int[] {1,2,3,4,5} %>" />
<c:set var="map" value="<%= mapData %>" />
<html>
<head><title>forEach �±�</title></head>
<body>
<h4>1���� 100���� Ȧ���� ��</h4>
<c:set var="sum" value="0" />
<c:forEach var="i" begin="1" end="100" step="2">
<!-- map�� �� �׸��� ó���Ҷ� ����� -->
<!-- 1���� 100���� 1�� ������! Ȧ�� -->
<c:set var="sum" value="${sum + i}" />
</c:forEach>
��� = ${sum}
<!-- el���� ����� -->
<h4>������: 4��</h4>
<ul>
<c:forEach var="i" begin="1" end="9">
<!-- step �����Ǹ� 1�� ���� -->
	<li>4 * ${i} = ${4 * i}
</c:forEach>
</ul>

<h4>int�� �迭</h4>

<c:forEach var="i" items="${intArray}" begin="2" end="4" varStatus="status">
	${status.index}-${status.count}-[${i}] <br />
	<!-- 2-1-[3] 
		3-2-[4] 
		4-3-[5] --> 
</c:forEach>

<h4>Map</h4>

<c:forEach var="i" items="${map}">
<!-- map���� ������ i�� ���� -->
	${i.key} = ${i.value}<br>
</c:forEach>

</body>
</html>
