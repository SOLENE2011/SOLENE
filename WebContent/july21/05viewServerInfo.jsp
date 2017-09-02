<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head><title>서버 정보 출력</title></head>
<body>

서버정보: <%= application.getServerInfo() %><br>
서블릿 규약 메이저 버전: <%= application.getMajorVersion() %><br>
서블릿 규약 마이너 버전: <%= application.getMinorVersion() %>

<!-- 웹 어플리케이션 웹을 기반으로 작동하는 프로그램! -->
<!-- 인터넷에서 동작하는 것이 모든것이 웹 어플리케이션임 -->
<!-- 웹 어플리케이션은 내프로젝트!!!!! -->

</body>
</html>