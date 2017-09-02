<!-- 매인이랑 아주 비슷함! -->
<!-- 네이버 카페, 메일, 블로그 생각하기! -->
<!-- 로그인이 되어있으면 else구문을 실행함! 로그인되어있으면 카페,메일,블로그 바로 이용 -->


<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>로그인</title>
<link href="../css/style.css" rel = "stylesheet" type = "text/css" />
</head>
<body onload="begin()">
<!-- body 태그가 시작되면 begin메소드를 실행한다 -->
	<!--  before login -->
<%
	if(session.getAttribute("memId")==null){
%>
	<script type="text/javascript">
	
	function begin() {
		documetn.myform.id.focus();
	}
	function checkIt() {
		if(!document.myform.id.value){
			alert("이름을 입력하지 않으셨습니다.");
			document.myform.id.focus();
			return false;
		}
		if(!document.myform.passwd.value){
			alert("비밀번호를 입력하지 않으셨습니다.");
			document.myform.passwd.focus();
			return false;
		}
	}	
	</script>
	
	<% /* 쿠키를 불러오는 작업임 */
	Cookie[] cookie = request.getCookies();
	String id = "";
	if(cookie != null){ /* 쿠키에 값이 있다면 */
		for(Cookie cookies : cookie){
			if(cookies.getName().equals("id"))
				/* 쿠키에 있는 이름과 내가 LoginPro에서 생성한쿠키 id가 같은 쿠키 불러오기  */
				id = cookies.getValue();
			}
		}				
	%>
<div id="loginWrap">
	<h1>Member Login</h1>
	<form action="loginPro.jsp" method="post" name="myform" onsubmit="return checkIt();">
		<fieldset>
			<legend>로그인</legend>
			<dl>
				<dt>Id</dt>
				<dd><input type="text" name="id" maxlength="10" value="<%=id %>" /></dd>
				<dt>Password</dt>
				<dd><input type="password" name="passwd" maxlength="10" /></dd>
			</dl>
			<div class="btnArea">
				<input type="submit" name="Submit" value="Ok" />
				<input type="reset" value="Reset" />
				<input type="button" value="Join" onclick="javascript:window.location='inputForm.jsp'" />
			</div>
		</fieldset>
	</form>
</div>

<%
	} else {
%>

<!-- after login -->
<div id="loginWrap">
	<h1>Welcome to my world!</h1>
	<div class="afterLogin">
		<p><strong><%= session.getAttribute("memId") %></strong>님 환영합니다.</p>
		<form action="logout.jsp" method="post">
			<div class="btnArea">
				<input type="submit" name="Submit" value="Logout" />
				<input type="button" value="Modify" onclick="javascript:window.location='modify.jsp'" />
				<input type="button" value="List" onclick="javascript:window.location='/SOLENE/board/list.jsp'"></input>
			</div>
		</form>
	</div>
</div>

<% } %>
</body>
</html>
	
	
