<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import = "kh.logon.LogonDBBean"%>

<% request.setCharacterEncoding("euc-kr"); %>

<%

	String id 		= request.getParameter("id");
	String passwd 	= request.getParameter("passwd");

	LogonDBBean manager = LogonDBBean.getInstance();
	int check = manager.userCheck(id, passwd);
	
	if(check==1){ /* 인증성공  */
		session.setAttribute("memId",id);
		/* 쿠키 생성하는 작업 */
		Cookie cookie = new Cookie("id",id);
		cookie.setMaxAge(5*60); /* 5분 */
		response.addCookie(cookie);	
		
		response.sendRedirect("main.jsp");
		/* sendRedirect로 가기때문에 쿠키와 session을 가지고 main을 다시 처음부터 돈다!  */
		/* sendRedirect 아예  URL이 바뀌고 forward는 page만 바뀌고 URL은 동일하다. */
	} else if(check==0){ /* 인증실패  */
%>
<script type="text/javascript">
 	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);
</script>
<% }else{ %> <!-- -1이라면 sql문이 돌고 값이없으면 rs.next() 값이 없으면 -1을 return했었음 (LogonDBBean.java)  -->
<script type="text/javascript">
 	alert("아이디가 맞지 않습니다.");
	history.go(-1);
</script>
<%} %>
