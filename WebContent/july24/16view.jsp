<%@ page contentType="text/html; charset=euc-kr" %>

<%
String code = request.getParameter("code");
String viewPageURI = null;

	if (code.equals("A")) {
		viewPageURI = "./viewModule/a.jsp";
		} else if(code.equals("B")) {
		viewPageURI = "./viewModule/b.jsp";
		}else if (code.equals("C")) {
		viewPageURI = "./viewModule/c.jsp";
		}
	
	%>
	<jsp:forward page= "<%= viewPageURI %>" />
	<!--       / 최상위폴더 -->
	<!--      ./ 현재폴더에서 찾기 -->
	<!--      ../ 하나 상위 폴더로 감 -->
	