<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<fmt:setLocale value="en" />
<!-- 영어 -->
<fmt:bundle basename="resource.message">
<!-- properties가 하나일때 번들을 사용함  -->
	<fmt:message key="TITLE" var="title" />
	<html>
<head>
<title>${title}</title>
</head>
<body>

	<fmt:message key="GREETING" />
	<br>
	<c:if test="${! empty param.id}">
	<!-- id값이 전송되면 -->
		<fmt:message key="VISITOR">
		<!-- VISITOR을 갖다 씀 -->
			<fmt:param value="${param.id}" />
		</fmt:message>
	</c:if>

</body>
	</html>
</fmt:bundle>