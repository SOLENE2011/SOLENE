<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<html>
<head><title>ȸ�� ���</title></head>
<body>

PKSUN ���̺��� ����
<table width="100%" border="1">
<tr>
	<td>�̸�</td><td>���̵�</td><td>�̸���</td>
</tr>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");
/* ()�� �ִ� Ŭ�������� �̸��� �ҷ��´� */

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
		/* Ŀ���� 0��°�� �� next�ϸ�! */
		/* �׳� Ŀ���� �����̴� ���� */
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