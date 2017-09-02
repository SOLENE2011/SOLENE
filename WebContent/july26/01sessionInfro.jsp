<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%@page session = "true" %>
<%
Date time = new Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

%>


<html>
<head><title>技记沥焊</title></head>
<body>
技记ID: <%= session.getId() %><br>
<%
time.setTime(session.getCreationTime());

%>
技记积己矫埃: <%= formatter.format(time) %> <br>
<%
time.setTime(session.getLastAccessedTime());
%>
弥辟立辟矫埃: <%= formatter.format(time) %>

</body>
</html>