<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page errorPage = "./19viewErrorMessage.jsp" %>
<%-- <%@ page errorPage = "./18errorNullPointer.jsp" %> --%>
<!-- 여기에 에러페이지를 정해주는것이 제일 우선순위가 높아 -->
<!-- 여기서 안 정해주면 web.xml에 설정한대로 에러페이지가 설정됨 -->
<html>
<head><title>파리미터 출력</title></head>
<body>

name 파라미터 값: <%= request.getParameter("name").toUpperCase() %>
					<!-- toUpperCase 매개변수 없음 이런 식으로 씀 -->

</body>
</html>