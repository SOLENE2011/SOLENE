<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import ="kh.logon.LogonDBBean"%>

<% request.setCharacterEncoding("euc-kr");%>
<!-- 페이지에 있는 문자들을 euc-kr형식으로 encoding하겠다는 의미!  -->

<jsp:useBean id="member" class ="kh.logon.LogonDataBean">
	<jsp:setProperty name ="member" property="*"/>
</jsp:useBean>
<!-- 세팅작업! 그리고 inputform에서 넘어온 값들이 같은 이름을 가진 member변수에 찾아간다. -->

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
	/* private LogonDBBean() {} 객체생성을 못하게 해놔서 메서드로 생성한다! */
	manager.insertMember(member);
	response.sendRedirect("loginForm.jsp");
	//서버에서 사용자한테 login.Form으로 화면을 돌려준다
%>