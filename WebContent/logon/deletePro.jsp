<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="kh.logon.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>ȸ�� Ż��</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="memberWrap">
		<div class="innerDiv">
			<h1>Member secession</h1>
			<%
				String id = (String) session.getAttribute("memId");
				String passwd = request.getParameter("passwd");
				LogonDBBean manager = LogonDBBean.getInstance();
				int check = manager.deleteMember(id, passwd);
				if (check == 1) { /* ��й�ȣ�� ������ */
					session.invalidate(); /* LogonDBBean���� �̹� SQL������ �����ȰŰ� �̰� �α׾ƿ��ϴ°�! */
			%>

			<form action="main.jsp" name="userinput" method="post">
				<p class="desc">ȸ�������� �����Ǿ����ϴ�.</p>
				<div class="btnArea2">
					<input type="submit" value="Ok" class="btn" />
				</div>
			</form>
			<%
				} else {
			%>
			<script type="text/javascript">
				alert("��й�ȣ�� ���� �ʽ��ϴ�.");
				history.go(-1);
			</script>

			<%
				}
			%>
		</div>
	</div>
</body>
</html