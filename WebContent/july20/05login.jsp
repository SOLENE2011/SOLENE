<%@ page contentType="text/html; charset=euc-kr" %>
<%
String id = request.getParameter("memberId");
if (id.equals("KH21")) {
	response.sendRedirect("01requestInfo.jsp");
/* response.sendRedirect("../july20/01requestInfo.jsp"); */
/* response.sendRedirect("./01requestInfo.jsp"); */
/* response.sendRedirect("01requestInfo.jsp"); */
/* 이렇게 3개나 가능함 */
/* 기억하자 경로는 현재 WEB-INF라는 곳이 중심임 여기에 웹이 돌때 기준이 여기임 */
/* 그래서 저 3개가 가능한거임 */
/* 그리고requst 특성상 어느 정도까지는 경로를 알고 있음! 내가 요청한걸 읽어서 오는 거니까 */
} else {

%>

<html>
<head><title>로그인에 실패</title></head>
<body>
아이디가KH21이 아닙니다.
</body>
</html>

<%
}
%>
