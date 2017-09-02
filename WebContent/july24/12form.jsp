<%@ page contentType = "text/html; charset=euc-kr" %>
<%--
	<jsp:foward> 액션 태그를 실행하면
	생성했던 출력 결과는 모두 제거된다. 페이지 이동임
	http://localhost:8080/SOLENE/july24/12form.jsp
	실행결과 13to를 실행시켰지만 12form주소인걸 확인할수 있음 
--%>
<html>
<head><title>from.jsp의 제목</title></head>
<body>

이 페이지는 from.jsp가 생성한 것입니다.

<jsp:forward page="13to.jsp" />

</body>
</html>
