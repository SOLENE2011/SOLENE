<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="kh.member.MemberInfo" %>   

<jsp:useBean id="member" scope="request" 
          class="kh.member.MemberInfo" />

<html>
<head><title>인사말</title></head>
<body>
<%
	//MemberInfo member = 
	//(MemberInfo)request.getAttribute("member");
%>
<%= member.getName() %> (<%= member.getId() %>) 회원님
안녕하세요.

</body>
</html>
