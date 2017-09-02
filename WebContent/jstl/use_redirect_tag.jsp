<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${param.dest == '1'}">
	<c:redirect url="/use_c_set.jsp" />
	<!-- WEB으로 올라가서 이건 오류남 -->
	<!-- dest=2 로 그 이상으로 시험해야함! -->
</c:if>
<c:if test="${param.dest == '2'}">
	<c:redirect url="use_c_set.jsp" />
</c:if>
<c:if test="${param.dest == '3'}">
	<c:redirect url="/el/viewToday.jsp" context="/SOLENE" />
</c:if>
<c:if test="${param.dest == '4'}">
	<c:redirect url="http://www.youtube.com/results">
		<c:param name="search_query" value="ryu" />
	</c:redirect>
</c:if>
