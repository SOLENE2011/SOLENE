<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import ="kh.logon.LogonDBBean"%>

<% request.setCharacterEncoding("euc-kr");%>
<!-- �������� �ִ� ���ڵ��� euc-kr�������� encoding�ϰڴٴ� �ǹ�!  -->

<jsp:useBean id="member" class ="kh.logon.LogonDataBean">
	<jsp:setProperty name ="member" property="*"/>
</jsp:useBean>
<!-- �����۾�! �׸��� inputform���� �Ѿ�� ������ ���� �̸��� ���� member������ ã�ư���. -->

<!--   	
   	private String id = request.getParameter("id");
	private String passwd = request.getParameter("passwd");
	private String name = request.getParameter("name");
	private String jumin1 = request.getParameter("jumin1");
	private String jumin2 = request.getParameter("jumin2");
	private String email = request.getParameter("email");
	private String blog = request.getParameter("blog");
	private Timestamp reg_date = request.getParameter("reg_date");
	private String zipcode = request.getParameter("zipcode");
	private String address = request.getParameter("address");
	
	
	member.setId(rs.getString("id"));
	member.setPasswd(rs.getString("passwd"));
	member.setName(rs.getString("name"));
	member.setJumin1(rs.getString("jumin1"));
	member.setJumin2(rs.getString("jumin2"));
	member.setEmail(rs.getString("email"));
	member.setBlog(rs.getString("blog"));
	member.setZipcode(rs.getString("zipcode"));
	member.setAddress(rs.getString("address"));
	member.setReg_date(rs.getTimestamp("reg_date"));
 -->
<%
	member.setReg_date(new Timestamp(System.currentTimeMillis()));
	LogonDBBean manager = LogonDBBean.getInstance();
	/* private LogonDBBean() {} ��ü������ ���ϰ� �س��� �޼���� �����Ѵ�! */
	manager.insertMember(member);
	response.sendRedirect("loginForm.jsp");
	//�������� ��������� login.Form���� ȭ���� �����ش�
%>