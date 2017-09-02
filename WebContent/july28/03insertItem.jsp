<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.SQLException" %>
<%
String idValue = request.getParameter("id");

Connection conn = null;
PreparedStatement pstmtItem = null;
PreparedStatement pstmtDetail = null;

String jdbcDriver = "jdbc:oracle:thin:@istudy.iptime.org:7000:ORCL";
String dbUser = "KH07";
String dbPass = "oracle";

Throwable occuredException = null;

try {
	int id = Integer.parseInt(idValue);
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	conn.setAutoCommit(false);
	/* 자동으로 Commit되는건 false */
	/* 결제와 표 예매가 완전하게 commit되어야함 */
	/* 결제만 되고 표를 못받으면 안댐 */
	/* 트랜잭션 여러단계를 하나로 처리 */
	/* conn.setAutoCommit(false) 트랜잭션을 시작한다는 의미 */
	
	pstmtItem = conn.prepareStatement("insert into PKSUN_IT values(?, ?)");
	pstmtItem.setInt(1, id);
	pstmtItem.setString(2, "name " + id );
	pstmtItem.executeUpdate();
	
	if(request.getParameter("error") != null) {
		throw new Exception("의도적 예외 발생");
		/* 이게 정전이라고 생각하자 */
		
	}
	pstmtDetail = conn.prepareStatement("insert into PKSUN_IT_D values(?, ?)");
	pstmtDetail.setInt(1, id);
	pstmtDetail.setString(2, "상세 설명" + id);
	pstmtDetail.executeUpdate();
	
	conn.commit();
	/* 문제가 없으면 트랜잭션을 commit 한다 */
} catch(Throwable e) {
	if(conn != null) {
		try {
			conn.rollback();
			
		} catch(SQLException ex) {}
		
	}
	occuredException = e;
	
}finally {
	if(pstmtItem != null)
		try { pstmtItem.close(); } catch(SQLException ex) {}
	if(pstmtDetail != null) 
		try { pstmtDetail.close(); } catch(SQLException ex) {}
	if(conn != null) try { conn.close(); } catch(SQLException ex){}
}
%>

<html>
<head><title>ITEM 값 입력</title></head>
<body>
<% if (occuredException != null) { %>
에러가 발생하였음: <%= occuredException.getMessage() %>
<% } else { %>
데이터가 성공적으로 들어감 for type PreparedStatement
<% } %>
</body>
</html>