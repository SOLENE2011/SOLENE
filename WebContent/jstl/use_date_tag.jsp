<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>dateFormat태그 사용</title>
</head>
<body>

	<c:set var="now" value="<%=new java.util.Date()%>" />
	<!--set 태그로 객체생성  -->
	<fmt:formatDate value="${now}" type="date" dateStyle="full" />
	<br>
	<fmt:formatDate value="${now}" type="date" dateStyle="short" />
	<br>
	<fmt:formatDate value="${now}" type="time" />
	<br>
	<fmt:formatDate value="${now}" type="both" dateStyle="full" timeStyle="full" />
	<br>
	<fmt:formatDate value="${now}" pattern="z a h:mm" />
	<br>
	<!-- 내가 준 스타일 -->
	<%-- both 날짜 시간 모두 --%>

</body>
</html>