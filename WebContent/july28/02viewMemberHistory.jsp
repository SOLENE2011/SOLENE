<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="java.io.Reader" %>

<%
String memberID = request.getParameter("memberID");
%>
<html>
<head><title>회원 정보</title></head>
<body>
<%
/* Class.forName("oracle.jdbc.driver.OracleDriver");
 */
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
	String dbUser = "KH07";
	String dbPass = "oracle";
	
	String query = "select * from PKSUNH where MEMBERID = '"+memberID+"'";
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	
	rs = stmt.executeQuery(query);
	
	if(rs.next()) {
		%>
	<table border = "1">
	<tr>
		<td>아이디</td><td><%= memberID%></td>
	</tr>
	<tr>
		<td>히스토리</td>
		<td>
		<%
		String history = null;
		Reader reader = null;
		try {
			reader = rs.getCharacterStream("HISTORY");
			if (reader != null) {
				StringBuffer buff = new StringBuffer();
				char[] ch = new char[512];
				int len = -1;
				
				while((len = reader.read(ch)) !=-1) {
					/* reader의 read메서드로 ch가 -1이 아니라면 */
					buff.append(ch,0,len);
				}
				history = buff.toString();
			}
		}catch(IOException ex) {
			out.println("예외 발생:"+ex.getMessage());
		}finally {
			if(reader != null) try {reader.close(); } catch(IOException ex) {}
		}
		%>
	<%= history %>
	</td>
</tr>
	</table>
	<%
	} else {
%>
<%= memberID %> 회원의 히스토리가 없습니다.
<%
	}
}catch(SQLException ex) {
	%>
	에러 발생: <%= ex.getMessage() %>
	<%
}finally {
if(rs != null) try { rs.close(); } catch(SQLException ex) {}
if(stmt != null) try{stmt.close(); } catch(SQLException ex) {}
if(conn != null) try{conn.close(); } catch(SQLException ex) {}
}
%>
</body>
</html> 