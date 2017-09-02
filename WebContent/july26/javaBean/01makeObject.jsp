<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="kh.member.MemberInfo" %>   

<jsp:useBean id="member" scope="request" class="kh.member.MemberInfo" />

 
<%
	//MemberInfo member = new MemberInfo();
	member.setId("KH");
	member.setName("케이에이치");
	//request.setAttribute("member", member);
%>
<jsp:forward page="./02useObject.jsp" />













