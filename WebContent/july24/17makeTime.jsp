<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.util.Calendar" %>

<%
Calendar cal = Calendar.getInstance();
request.setAttribute("time",cal);


/* response.sendRedirect("18viewTime.jsp"); ½ÇÇà¾È´ï*/
/*  */
%>

<jsp:forward page="18viewTime.jsp" />
