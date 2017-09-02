<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>우편번호검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link href="./css/popup.css" rel="stylesheet" type="text/css" />
</head>
<body>
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
			var address = area1 + " " + area2 + " " + area3 + " " + area4;
			opener.document.userinput.zipcode.value = zipcode;
			opener.document.userinput.address.value = address;
			self.close();
		}
	</script>
	<div id="zipCheck">
		<h1>우편번호 검색</h1>
		<form name="zipForm" method="post" action="zipcheck.do">

			<p class="desc">
				동이름 입력: <input type="text" name="area3" />
			</p>
			<div>
				<input type="button" value="검색" onclick="dongCheck();" /> 
				<input type="hidden" name="check" value="n" />
				<!-- function zipCheck() { url = "zipcheck.do?check=y } -->
				<!-- 기본 y로 설정되어있지만, zipcheck.jsp에서 검색을 누르면 n이라는 값이 hidden으로 넘어감 -->
				<!-- 처음엔 검색을 안해서 아무 화면도 띄우지 않기 위해 y와 n을 이용한거임 -->
			</div>
		</form>

		<c:if test="${check == 'n'}">			
				<c:if test="${empty zipcodeList }" >
				<p class ="desc">검색된 결과가 없습니다.</p>
				</c:if>
				<c:if test="${!empty zipcodeList }" >
				<div class ="spot">※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</div>
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