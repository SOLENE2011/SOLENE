<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="jstl.Member" %>       
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- jstl은 이 줄이 반드시 필요함!!!! 별칭 c  위치는 WEB-INF/lib에 있음  -->
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
set태그는 변수를 설정할때 사용한다. 그리고 기본객체의 영역에 속성설정까지한다.
<c:set var="member" value="<%= member %>" scope="request"/>
<c:set target="${member}" property="name" value="최범균" />

Member member = new Member();
member.setName("최범균");
pageContext.setAttribute("member", member);

${member.name}
Member member=(Member)pageContext.getAttribute("member");
member.getName();
 --%>
<c:set var="member" value="<%= member %>" scope="page" />
<!-- member객체를  member라는 이름으로(var) -->
<!-- member라는 이름이 같아서 헷갈릴수 있는데 앞에 member는 그냥 이름이고 뒤에 멤버는 Member member = new Member();  객체 생성한 이름 member임!! -->

<c:set target="${member}" property="name" value="SOLENE" />
<!-- 영역에 저장된 member  -->
<!-- target이용해서 값설정  -->

<c:set var="pref" value="<%= pref %>" />
<!--  영역에 저장하는 이름 var = "pref"  -->
<!-- 영역 기본값은 page -->

<c:set var="favoriateColor" value="#{pref.color}" />
									<!-- el #붙일 수도 있음 -->
									<!-- #은 기다렸다 처리하기 때문에 $쓰면 오류남!! -->
									<!-- hashMap에 값이 들어가면동작할거고 아니면 동작안할거임 -->

회원 이름: ${member.name},
좋아하는 색: ${favoriateColor}

<br />
<c:set target="${pref}" property="color" value="red" />
				<!-- HashMap -->
				<!-- key : color  value = red-->

설정 이후 좋아하는 색: ${favoriateColor}

</body>
</html>