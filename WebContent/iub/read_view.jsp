<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@page import="kh.board.CommentDataBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kh.board.CommentDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "madvirus.gallery.Theme" %>
<%@ page import = "madvirus.gallery.ThemeManager" %>
<%@ page import = "madvirus.gallery.ThemeManagerException" %>
<%
	String themeId = request.getParameter("id");
	/* 파라미터 넘어오는지 확인 System.out.println(themeId); */
	ThemeManager manager = ThemeManager.getInstance();
	Theme theme = manager.select(Integer.parseInt(themeId));
	
	int pageSize = 10;
	String cPageNum = request.getParameter("cPageNum");
	if(cPageNum == null) {
		cPageNum = "1";
	}
	int cCurrentPage = Integer.parseInt(cPageNum);
	int startRow = (cCurrentPage * 10) -9;
	int endRow = cCurrentPage * pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	CommentDBBean cdb = CommentDBBean.getInstance();
	ArrayList comments = cdb.getComments(theme.getId(), startRow, endRow);
	int count = cdb.getCommentCount(theme.getId());
	
%>

<script>
function writeSave() {
	if(document.comment.commentt.value=="") {
		alert("작성자를 입력하십시요.");
		document.comment.commentt.focus();
		return false;
	}
}
function gonyImgWin(img){
	var imgTmp = new Image();
	imgTmp.src = img;
	
	var imgWin = window.open("","gImgWin","width="+imgTmp.width+",height="+imgTmp.height+",status=no,toolbar=no,scrollbars=no,resizable=no");
	imgWin.document.write("<html><title>미리보기</title>"
			+"<body topmargin=0 leftmargin=0 marginheight=0 marginwidth=0>"
			+"<a href='javascript:self.close()'><img src='"+img+"' width=+imgTmp.width+" height="+imgTmp.height+" border=0></a>"
			+"</body></html>");
}
</script>

<c:set var="theme" value="<%= theme %>"/>
<c:if test="${empty theme}">
존재하지 않는 테마 이미지 입니다.
</c:if>

<c:if test="${!empty theme}">
<table width="100%" border="1" cellpadding="1" cellspacing="0">
	
	<tr>
		<td>제목</td>
		<td>${theme.title}</td>
	</tr>
	
	<tr>
		<td>작성자</td>
		<td>${theme.name}
		<c:if test="${empty theme.email}">
		<a href="mailto:${theme.email}">[이메일]</a>
		</c:if>
		</td>
	</tr>
	<c:if test="${!empty theme.image}">
	<tr>
		<td colspan="2" align="center">
		<img id="imglink" src="/SOLENE/imageboard/image/${theme.image}" width="150" border="0" onClick="javascript:gonyImgWin('/SOLENE/image/${theme.image}')">
		</td>
	</tr>
	</c:if>
	
	<tr>
		<td>내용</td>
		<td><pre>${theme.content}</pre></td>
	</tr>
	
	<tr>
		<td colspan="2">
		<a href="javascript:goReply()">[답변]</a>
		<a href="javascript:goModify()">[수정]</a>
		<a href="javascript:goDelete()">[삭제]</a>
		<a href="javascript:goList()">[목록]</a>
		</td>
		
	</tr>
	</table>
	</c:if>
	
	<script language="JavaScript">
	function goReply(){
		document.move.action="writeForm.jsp?";
		document.move.submit();
	}
	
	function goModify(){
		document.move.action = "updateForm.jsp";
		document.move.submit();
	}
	
	function goDelete(){
		document.move.action = "deleteForm.jsp";
		document.move.submit();
	}
	
	function goList(){
		document.move.action = "list.jsp";
		document.move.submit();
	}
	
	function viewLarge(imgUrl) {
		
	}
	</script>
	
	<form name="move" method="post">
		<input type="hidden" name="id" value="${theme.id}">
		<input type="hidden"  name="parentId" value="${theme.id}">
		<input type="hidden" name="groupId" value="${theme.groupId}">
		
		<input type="hidden" name="page" value="${param.page}">
		<c:forEach var="searchCond" items="${paramValues.search_cond}">
			<c:if test="${searchCont == 'title'}">
		<input type="hidden" name="search_cond" value="title">
		</c:if>
		<c:if test="${searchCond == 'name'}">
		<input type="hidden" name="search_cond" value="name">
		</c:if>
	</c:forEach>
	
	<c:if test="${!empty param.search_key}">
	<input type="hidden" name="search_key" value="${param.search_key}">
	</c:if>
</form>

<form method="post" action="contentPro.jsp" name="comment" onsubmit="return writeSave()">
<table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr align="center">
		<td>코멘트 작성</td>
		<td colspan="2">
			<textarea name = commentt rows="6" cols="40"></textarea>
			<input type="hidden" name="content_num" value="<%= theme.getId() %>">
			<input type="hidden" name="page" value="<%= page %>">
			<input type="hidden" name="comment_num" value= "<%= count+1 %>">
			</td>
			
			<td align="center">
			작성자<br>
			<input type="text" name="commenter" size="10"><br>
			비밀번호<br>
			<input type="password" name="passwd" size="10"><p>
			<input type="submit" value="코멘트달기">
			</td>
		</tr>
		</form>
<%if(count>0){ %>
<p>		
<table width="500" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>코멘트 수 : <%= comments.size() %>
	</tr>
	
		<%
		for(int i=0; i<comments.size();i++){
			CommentDataBean dbc = (CommentDataBean)comments.get(i);
		%>
		
		<tr>
			<td align="left" size="250">
			&nbsp;<b><%= dbc.getCommenter() %>&nbsp;님</b> (<%=sdf.format(dbc.getReg_date()) %>)
			</td>
			<td align="right" size="250"> 접속IP:<%= dbc.getIp() %>
			&nbsp;
			<a href="delCommentForm.jsp?ctn=<%=dbc.getContent_num() %>&cmn=<%=dbc.getComment_num() %>&p_num=<%=page %>&id=<%=themeId %>" >[삭제]</a>&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2"><%= dbc.getCommentt() %></td>
			<%
		}
			%>
			</tr>
<%
}
%>
</table>















