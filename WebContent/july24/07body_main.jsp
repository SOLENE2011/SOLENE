<%@ page contentType="text/html; charset=euc-kr" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<html>
<head><title>INFO</title></head>
<body>

include 전 name 파라미터 값: <%= request.getParameter("name") %>
<!-- 값만 부르는데 값이 없으면 null값이 뜸  -->
<!-- 그 값을 불러와서 비교를 할때 값이 없으면 null exception  -->
<hr>

<jsp:include page="08body_sub.jsp" flush="false">
	<jsp:param name="name" value="최범균" />
</jsp:include>

<hr/>

include 후 name 파라미터 값: <%= request.getParameter("name") %>
<!-- 결과 값이 null인 이유는 include는 그쪽에서 처리하고 끝 여기까지 파라미터를 가져오진 않음! -->
</body>
</html>
