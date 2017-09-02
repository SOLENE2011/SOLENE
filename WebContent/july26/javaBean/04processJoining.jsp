<%@ page contentType = "text/html; charset=euc-kr" %> 
<%
	request.setCharacterEncoding("euc-kr");  
%>
<jsp:useBean id="memberInfo" class="kh.member.MemberInfo" scope="page"/> 
<jsp:setProperty name="memberInfo" property="*" />
<%--
 <%
   String id = request.getParameter("id");
   String name = request.getParameter("name");
   String email = request.getParameter("email");
   String address = request.getParameter("address");
   memberInfo.setId(id);
   memberInfo.setName(name);
   memberInfo.setEmail(email);
   memberInfo.setAddress(address);
 
 %>

 --%>
<jsp:setProperty name="memberInfo" property="password"
				 value="<%= memberInfo.getId() %>" />
<html>
<head><title>가입</title></head>
<body>

<table width="400" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td>아이디</td>
	<td><%=memberInfo.getId() %></td>
	<td>암호</td>
	<td><jsp:getProperty name="memberInfo" property="password" /></td>
</tr>
<tr>
	<td>이름</td>
	<td><jsp:getProperty name="memberInfo" property="name" /></td>
	<td>이메일</td>
	<td><jsp:getProperty name="memberInfo" property="email" /></td>
</tr>
<tr>
	<td>주소</td>
	<td colspan="3">
	<jsp:getProperty name="memberInfo" property="address" />
	</td>
</tr>
</table>

</body>
</html>
