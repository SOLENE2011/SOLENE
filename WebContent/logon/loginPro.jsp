<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import = "kh.logon.LogonDBBean"%>

<% request.setCharacterEncoding("euc-kr"); %>

<%

	String id 		= request.getParameter("id");
	String passwd 	= request.getParameter("passwd");

	LogonDBBean manager = LogonDBBean.getInstance();
	int check = manager.userCheck(id, passwd);
	
	if(check==1){ /* ��������  */
		session.setAttribute("memId",id);
		/* ��Ű �����ϴ� �۾� */
		Cookie cookie = new Cookie("id",id);
		cookie.setMaxAge(5*60); /* 5�� */
		response.addCookie(cookie);	
		
		response.sendRedirect("main.jsp");
		/* sendRedirect�� ���⶧���� ��Ű�� session�� ������ main�� �ٽ� ó������ ����!  */
		/* sendRedirect �ƿ�  URL�� �ٲ�� forward�� page�� �ٲ�� URL�� �����ϴ�. */
	} else if(check==0){ /* ��������  */
%>
<script type="text/javascript">
 	alert("��й�ȣ�� ���� �ʽ��ϴ�.");
	history.go(-1);
</script>
<% }else{ %> <!-- -1�̶�� sql���� ���� ���̾����� rs.next() ���� ������ -1�� return�߾��� (LogonDBBean.java)  -->
<script type="text/javascript">
 	alert("���̵� ���� �ʽ��ϴ�.");
	history.go(-1);
</script>
<%} %>
