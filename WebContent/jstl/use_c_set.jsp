<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="jstl.Member" %>       
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- jstl�� �� ���� �ݵ�� �ʿ���!!!! ��Ī c  ��ġ�� WEB-INF/lib�� ����  -->
<%
	Member member = new Member(); 

/* public class Member {

	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
 */

	HashMap<String, String> pref = new HashMap<String, String>();
%>  
<html>
<body>
<%--
set�±״� ������ �����Ҷ� ����Ѵ�. �׸��� �⺻��ü�� ������ �Ӽ����������Ѵ�.
<c:set var="member" value="<%= member %>" scope="request"/>
<c:set target="${member}" property="name" value="�ֹ���" />

Member member = new Member();
member.setName("�ֹ���");
pageContext.setAttribute("member", member);

${member.name}
Member member=(Member)pageContext.getAttribute("member");
member.getName();
 --%>
<c:set var="member" value="<%= member %>" scope="page" />
<!-- member��ü��  member��� �̸�����(var) -->
<!-- member��� �̸��� ���Ƽ� �򰥸��� �ִµ� �տ� member�� �׳� �̸��̰� �ڿ� ����� Member member = new Member();  ��ü ������ �̸� member��!! -->

<c:set target="${member}" property="name" value="SOLENE" />
<!-- ������ ����� member  -->
<!-- target�̿��ؼ� ������  -->

<c:set var="pref" value="<%= pref %>" />
<!--  ������ �����ϴ� �̸� var = "pref"  -->
<!-- ���� �⺻���� page -->

<c:set var="favoriateColor" value="#{pref.color}" />
									<!-- el #���� ���� ���� -->
									<!-- #�� ��ٷȴ� ó���ϱ� ������ $���� ������!! -->
									<!-- hashMap�� ���� ���鵿���ҰŰ� �ƴϸ� ���۾��Ұ��� -->

ȸ�� �̸�: ${member.name},
�����ϴ� ��: ${favoriateColor}

<br />
<c:set target="${pref}" property="color" value="red" />
				<!-- HashMap -->
				<!-- key : color  value = red-->

���� ���� �����ϴ� ��: ${favoriateColor}

</body>
</html>