<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="kh.member.MemberInfo" %>   

<jsp:useBean id="member" scope="request" 
          class="kh.member.MemberInfo" />

<html>
<head><title>�λ縻</title></head>
<body>
<%
	//MemberInfo member = 
	//(MemberInfo)request.getAttribute("member");
%>
<%= member.getName() %> (<%= member.getId() %>) ȸ����
�ȳ��ϼ���.

</body>
</html>
