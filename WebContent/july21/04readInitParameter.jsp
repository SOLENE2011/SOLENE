<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.util.Enumeration" %>
<html>
<head><title>�ʱ�ȭ �Ķ���� �о����</title></head>
<body>

�ʱ�ȭ �Ķ���� ���:
<ul>
<%
Enumeration initParamEnum = application.getInitParameterNames();
/* JSP��ü�� �ᱹ JAVA���� �Ļ��Ȱ���
�׷��� �տ��� JAVA��ü�� �ڿ� JSP��ü���� �̷��� ��� �����Ѱ���
application��ü�� �� ���ø����̼ǿ� ���� ������ ������ 
application.getInitParameterNames() ��
�� ���ø����̼� �ʱ�ȭ �Ķ������ �̸� ����� ������
�� ������Ʈ�� �����ø����̼��̶�� �������ڡ�
*/
while(initParamEnum.hasMoreElements()) {
	String initParamName = (String)initParamEnum.nextElement();
%>
<!-- li �� ��Ͽ�� -->
<li><%= initParamName %> = 
	<%= application.getInitParameter(initParamName) %>
<%
}
%>
</ul>
</body>
</html>