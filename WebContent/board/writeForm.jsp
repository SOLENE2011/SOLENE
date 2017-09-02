<%@page import="kh.logon.LogonDBBean"%>
<%@page import="kh.logon.LogonDataBean"%>
<%@ page contentType="text/html; charset=euc-kr"  pageEncoding="euc-kr"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<head>
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
<script type="text/javascript" src="js/test.js"></script>

<!-- 앞에 회원가입 할때 -->
<!-- <script type="text/javascript"> -->
<!-- 회원가입할때는 jsp 파일 안에 script내용을 포함하고 있었지만  -->
<!-- 게시판에서는 src="script.js" 파일로 연결시킴~! -->
</head>
<%
	int num = 0, ref = 1, re_step = 0, re_level = 0;
	LogonDataBean c = null;
	if(session.getAttribute("memId")!=null) {
		String id = (String)session.getAttribute("memId");
		LogonDBBean m = LogonDBBean.getInstance();
		c = m.getMember(id);
	}
	
	try {
		if (request.getParameter("num") != null) {
			/* writeForm은 list에서도 오고 content에서도 와! */
			/* list에 num이라는 파라미터는 없어! 그래서 if문이 true이기 때문에 {} 안에 내용들이 실해됨 */
			/* 넘어오려면 content에서 넘어올 수 있어! */
			/* 위에  num = 0, ref = 1, re_step = 0, re_level = 0; 으로 setting */
			num = Integer.parseInt(request.getParameter("num"));
			ref = Integer.parseInt(request.getParameter("ref"));
			re_step = Integer.parseInt(request.getParameter("re_step"));
			re_level = Integer.parseInt(request.getParameter("re_level"));
			/* 새 글을 쓰는건지 답변을 쓰는건지 판단할수 있음 */

		}
%>

<div id="wrap">
		<div id="header"><h1>글작성</h1></div>
		<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
										<!-- action도 경로설정 -->	<!-- 이 메서드  script.js파일에 있음 -->
		<input type="hidden" name="num" value="<%=num%>"> 
		<inpu type="hidden" name="ref" value="<%=ref%>"> 
		<input type="hidden" name="re_step" value="<%=re_step%>"> 
		<input type="hidden" name="re_level" value="<%=re_level%>">
		<!-- 위에 if문 setting을 통한 값을 writeForm에 같이 보냄  -->
		<div id="content">
		 <table>
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
				
				
				<tr>
					<th>이름</th>
					 <% 
					if(session.getAttribute("memId")!=null) {
					
					%>
					<td><input type="text" size="10" maxlength="10" name="writer" value="<%=c.getName() %>"></td>
					<%
					}else {
					%>
					<td><input type="text" size="10" maxlength="10" name="writer"></td>
					<%
					}
					%>
				
				</tr>
				<tr>
					
					<th>제목</th>
					<td>
						<% if(request.getParameter("num") == null) { %>
						<input type="text" name="subject" />
						<% } else { %>
						<input type="text" name="subject" value="[re]" />
						<% } %>
					</td>
				</tr>
				<tr>
					<th>E-mail</th>
					<%
					if(session.getAttribute("memId") != null) {
					%>
					<td><input type="text" size="40" maxlength="30"	name="email" value="<%=c.getEmail() %>"></td>
					<% }else { %>
					<td><input type="text" size="40" maxlength="30"	name="email"></td>
					<% } %>
				</tr>
				
				<tr>
				<th>내용</th>
					<td><textarea name="content"></textarea></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="passwd" /></td>
				</tr>
			</table>
			</div>
			<div id="footer">
				<input type="submit" value="글쓰기" /> 
				<input type="reset" value="다시작성" />
				<input type="button" value="목록보기" onclick="window.location='list.jsp'"/>
			</div>
		</form>
		</div>
					<%
}catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>