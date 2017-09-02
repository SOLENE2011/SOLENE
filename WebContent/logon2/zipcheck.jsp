<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�����ȣ�˻�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="./css/popup.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<script type="text/javascript">
		function dongCheck() {
			if (document.zipForm.area3.value == "") {
				alert("���̸��� �Է��ϼ���");
				document.zipForm.area3.focus();
				return;
			}
			document.zipForm.submit();
		}

		function sendAddress(zipcode, area1, area2, area3, area4) {
			var address = area1 + " " + area2 + " " + area3 + " " + area4;
			opener.document.userinput.zipcode.value = zipcode;
			opener.document.userinput.address.value = address;
			self.close();
		}
	</script>
	<div id="zipCheck">
		<h1>�����ȣ �˻�</h1>
		<form name="zipForm" method="post" action="zipcheck.do">

			<p class="desc">
				���̸� �Է�: <input type="text" name="area3" />
			</p>
			<div>
				<input type="button" value="�˻�" onclick="dongCheck();" /> 
				<input type="hidden" name="check" value="n" />
				<!-- function zipCheck() { url = "zipcheck.do?check=y } -->
				<!-- �⺻ y�� �����Ǿ�������, zipcheck.jsp���� �˻��� ������ n�̶�� ���� hidden���� �Ѿ -->
				<!-- ó���� �˻��� ���ؼ� �ƹ� ȭ�鵵 ����� �ʱ� ���� y�� n�� �̿��Ѱ��� -->
			</div>
		</form>

		<c:if test="${check == 'n'}">			
				<c:if test="${empty zipcodeList }" >
				<p class ="desc">�˻��� ����� �����ϴ�.</p>
				</c:if>
				<c:if test="${!empty zipcodeList }" >
				<div class ="spot">�ذ˻� ��, �Ʒ� �����ȣ�� Ŭ���ϸ� �ڵ����� �Էµ˴ϴ�.</div>
			<ul>
			<c:forEach var="zipcodeList" items="${zipcodeList}">			
			<li>
			<a href="javascript:sendAddress('${zipcodeList.zipcode}','${zipcodeList.area1 }','${zipcodeList.area2 }','${zipcodeList.area3 }','${zipcodeList.area4 }')">
				${zipcodeList.zipcode}&nbsp;${zipcodeList.area1}&nbsp;${zipcodeList.area2 }&nbsp;${zipcodeList.area3 }&nbsp;${zipcodeList.area4 }
			</a>
			</li>
			</c:forEach>
			</ul>
			</c:if>
		</c:if>
	</div>
</body>
</html>