<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head><title>out 기본 객체 사용</title></head>
<body>
<%
out.println("안녕하세요?");
%>
<!-- (%=) 안에는 리턴값이 void인 것은 들어갈수 없음   -->
<!-- println은 % 로 실행시킬수 있지만 -->
<!-- 다른 메서드들은 %=으로 해야함  -->
<!-- 그리고 %안에 메소드실행은 세미콜론; 꼭 필요함 -->
<br>
out 기본 객체를 사용하여
<%
out.println("출력한 결과입니다.");
%>
</body>
</html>