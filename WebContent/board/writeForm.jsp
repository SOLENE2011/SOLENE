<%@page import="kh.logon.LogonDBBean"%>
<%@page import="kh.logon.LogonDataBean"%>
<%@ page contentType="text/html; charset=euc-kr"  pageEncoding="euc-kr"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<head>
<title>�Խ���</title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
<script type="text/javascript" src="js/test.js"></script>

<!-- �տ� ȸ������ �Ҷ� -->
<!-- <script type="text/javascript"> -->
<!-- ȸ�������Ҷ��� jsp ���� �ȿ� script������ �����ϰ� �־�����  -->
<!-- �Խ��ǿ����� src="script.js" ���Ϸ� �����Ŵ~! -->
</head>
<%
	int num = 0, ref = 1, re_step = 0, re_level = 0;
	LogonDataBean c = null;
	if(session.getAttribute("memId")!=null) {
		String id = (String)session.getAttribute("memId");
		LogonDBBean m = LogonDBBean.getInstance();
		c = m.getMember(id);
	}
	
	try {
		if (request.getParameter("num") != null) {
			/* writeForm�� list������ ���� content������ ��! */
			/* list�� num�̶�� �Ķ���ʹ� ����! �׷��� if���� true�̱� ������ {} �ȿ� ������� ���ص� */
			/* �Ѿ������ content���� �Ѿ�� �� �־�! */
			/* ����  num = 0, ref = 1, re_step = 0, re_level = 0; ���� setting */
			num = Integer.parseInt(request.getParameter("num"));
			ref = Integer.parseInt(request.getParameter("ref"));
			re_step = Integer.parseInt(request.getParameter("re_step"));
			re_level = Integer.parseInt(request.getParameter("re_level"));
			/* �� ���� ���°��� �亯�� ���°��� �Ǵ��Ҽ� ���� */

		}
%>

<div id="wrap">
		<div id="header"><h1>���ۼ�</h1></div>
		<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
										<!-- action�� ��μ��� -->	<!-- �� �޼���  script.js���Ͽ� ���� -->
		<input type="hidden" name="num" value="<%=num%>"> 
		<inpu type="hidden" name="ref" value="<%=ref%>"> 
		<input type="hidden" name="re_step" value="<%=re_step%>"> 
		<input type="hidden" name="re_level" value="<%=re_level%>">
		<!-- ���� if�� setting�� ���� ���� writeForm�� ���� ����  -->
		<div id="content">
		 <table>
				<colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
				
				
				<tr>
					<th>�̸�</th>
					 <% 
					if(session.getAttribute("memId")!=null) {
					
					%>
					<td><input type="text" size="10" maxlength="10" name="writer" value="<%=c.getName() %>"></td>
					<%
					}else {
					%>
					<td><input type="text" size="10" maxlength="10" name="writer"></td>
					<%
					}
					%>
				
				</tr>
				<tr>
					
					<th>����</th>
					<td>
						<% if(request.getParameter("num") == null) { %>
						<input type="text" name="subject" />
						<% } else { %>
						<input type="text" name="subject" value="[re]" />
						<% } %>
					</td>
				</tr>
				<tr>
					<th>E-mail</th>
					<%
					if(session.getAttribute("memId") != null) {
					%>
					<td><input type="text" size="40" maxlength="30"	name="email" value="<%=c.getEmail() %>"></td>
					<% }else { %>
					<td><input type="text" size="40" maxlength="30"	name="email"></td>
					<% } %>
				</tr>
				
				<tr>
				<th>����</th>
					<td><textarea name="content"></textarea></td>
				</tr>
				<tr>
					<th>��й�ȣ</th>
					<td><input type="password" name="passwd" /></td>
				</tr>
			</table>
			</div>
			<div id="footer">
				<input type="submit" value="�۾���" /> 
				<input type="reset" value="�ٽ��ۼ�" />
				<input type="button" value="��Ϻ���" onclick="window.location='list.jsp'"/>
			</div>
		</form>
		</div>
					<%
}catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>