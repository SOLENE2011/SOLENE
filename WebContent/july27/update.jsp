<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>

<%
request.setCharacterEncoding("euc-kr");

String memberID = request.getParameter("memberID");
String name = request.getParameter("name");

int updateCount = 0;

Class.forName("oracle.jdbc.driver.OracleDriver");

Connection conn = null;
Statement stmt = null;

try {
	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
	String dbUser="KH07";
	String dbPass="oracle";
	
	String query = "update PKSUN set NAME = '"+name+"' where MEMBERID= '"+memberID+"'";

	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	updateCount = stmt.executeUpdate(query);

} finally {
	if(stmt != null) try {stmt.close(); } catch(SQLException ex) {}
	if(conn != null) try{conn.close(); } catch(SQLException ex) {}
}

%>
<html>
<head><title>이름 변경</title></head>
<body>
<% if(updateCount > 0) { %>
	<%= memberID %>의 이름을 <%= name %>(으)로 변경
	<% } else { %>
	<%= memberID %> 아이디가 존재하지 않음
<% 
}
%>

</body>
</html>