<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<html>
<head>
<title>회원 목록</title>
</head>
<body>

	MEMBMER 테이블의 내용
	<table width="100%" border="1">
		<tr>
			<td>이름</td>
			<td>아이디</td>
			<td>이메일</td>
		</tr>
		<%
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;

			try {
				//String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
				String query = "select * from MEMBER order by USERID";
				conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/pool");
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("USERNAME")%></td>
			<td><%=rs.getString("USERID")%></td>
			<td><%=rs.getString("USEREMAIL")%></td>
		</tr>
		<%
			}
			} finally {
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException ex) {
					}
				if (stmt != null)
					try {
						stmt.close();
					} catch (SQLException ex) {
					}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException ex) {
					}
			}
		%>
	</table>

</body>
</html>
