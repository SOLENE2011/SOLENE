<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<html>
<head><title>회원 목록</title></head>
<body>

PKSUN 테이블의 내용
<table width="100%" border="1">
<tr>
	<td>이름</td><td>아이디</td><td>이메일</td>
</tr>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");
/* ()에 있는 클래스들의 이름을 불러온다 */

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try{
	String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
	String dbUser = "KH07";
	String dbPass = "oracle";
	
	String query = "select * from PKSUN order by MEMBERID";
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	
	stmt = conn.createStatement();
	
	rs = stmt.executeQuery(query);
	
	while(rs.next ()) {
		/* 커서가 0번째로 감 next하면! */
		/* 그냥 커서가 움직이는 거임 */
		%>
	<tr>
		<td><%= rs.getString("NAME") %></td>
		<td><%= rs.getString("MEMBERID") %></td>
		<td><%= rs.getString("EMAIL") %></td>
	</tr>
		<%
		}
	}catch(SQLException ex) {
		out.println(ex.getMessage());
		ex.printStackTrace();
	}finally{
	if(rs !=null) try {rs.close(); } catch(SQLException ex) {}
	if(stmt != null) try {stmt.close(); } catch(SQLException ex) {}
	}

%>
</table>
</body>
</html>