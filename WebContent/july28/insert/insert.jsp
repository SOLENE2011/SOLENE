<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%
request.setCharacterEncoding("euc-kr");

String memberID = request.getParameter("memberID");
String password = request.getParameter("password");
String name = request.getParameter("name");
String email = request.getParameter("email");

Connection conn = null;
PreparedStatement pstmt = null;

try {
	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
	String dbUser = "KH07";
	String dbPass = "oracle";
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	
	pstmt = conn.prepareStatement("insert into PKSUN values(?, ?, ?, ?)");
	
	pstmt.setString(1, memberID);
	pstmt.setString(2, password);
	pstmt.setString(3, name);
	pstmt.setString(4, email);
	
	pstmt.executeUpdate();	
} finally {
	if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	if(conn != null) try { conn.close(); } catch(SQLException ex) {}
	
}
%>
<html>
<head><title>삽입</title></head>
<body>
PKSUN 테이블에 새로운 레코드를 삽입했습니다
</body>
</html>