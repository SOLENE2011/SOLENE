<%@page import="kh.logon.*"%>
<%@page import="java.util.Vector"%>
<%@page import="kh.logon.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>

<%
	request.setCharacterEncoding("euc-kr");

	String check = request.getParameter("check");
	String area3 = request.getParameter("area3");
	LogonDBBean manager = LogonDBBean.getInstance();
	Vector zipcodeList = manager.zipcodeRead(area3);
	int totalList = zipcodeList.size();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
 <title>우편번호검색</title>
 <link href="../css/popup.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript">
	function dongCheck() {
		if (document.zipForm.area3.value == "") {
			alert("동이름을 입력하세요");
			document.zipForm.area3.focus();
			return;
		}
		document.zipForm.submit();
	}

	function sendAddress(zipcode, area1, area2, area3, area4) {
		var address = area1 + " " + area2 + " " +area3 + " " + area4;
		opener.document.userinput.zipcode.value = zipcode;
		opener.document.userinput.address.value = address;
		self.close();
	}
</script>
</head>

<body>
 <div id="zipCheck">
 	<h1>우편번호 검색</h1>
			<form name="zipForm" method="post" action="ZipCheck.jsp">
				
				<p class="desc"> 동이름 입력: <input type="text" name = "area3" /></p>
 	<div>
 		<input type="button" value="검색" onclick="dongCheck();" />		
 		<input type="hidden" name = "check" value="n" />
 	</div>
			</form>
			<%
				if (check.equals("n")) {
			%>
			<%
				if (zipcodeList.isEmpty()) {
			%>
			<p class ="desc">검색된 결과가 없습니다.</p>
			<%
				} else {
			%>
			<div class ="spot">
 	※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</div>
 	<ul>
			<%
				for (int i = 0; i < totalList; i++) {
							ZipcodeBean zipBean = (ZipcodeBean) zipcodeList.elementAt(i);
							String tempZipcode = zipBean.getZipcode();
							String temptArea1 = zipBean.getArea1();
							String temptArea2 = zipBean.getArea2();
							String temptArea3 = zipBean.getArea3();
							String temptArea4 = zipBean.getArea4();
			%>
<li>
 		<a href="javascript:sendAddress('<%=tempZipcode %>','<%=temptArea1 %>','<%=temptArea2 %>','<%=temptArea3 %>','<%=temptArea4 %>')">
 			<%=tempZipcode %>&nbsp;<%=temptArea1 %>&nbsp;<%=temptArea2 %>&nbsp;<%=temptArea3 %>&nbsp;<%=temptArea4 %>
 		</a>
 	</li>
<%
 	}

 		}
 %> 
 </ul>
 
 <%
 	}
 %>
 </div>
 
</body>
</html>