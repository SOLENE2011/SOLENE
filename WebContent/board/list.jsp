<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="kh.board.BoardDBBean" %>
<%@ page import="kh.board.BoardDataBean" %>
<%@ page import="kh.board.CommentDBBean" %> 
<%@ page import="kh.board.CommentDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>글목록</title>
<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>

<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");
	
	int searchn = 0;
	
	if(pageNum == null)
	{
		pageNum = "1";
	}
	//pagenum이 parameter값으로 넘어오지 않았다면, 맨 첫번째 페이지로.
	
	
	if(search == null)
	{
		search = "";
	}
	else
	{
		searchn = Integer.parseInt(request.getParameter("searchn"));
	}
	

	
	int currentPage = Integer.parseInt(pageNum);
	//System.out.println(currentPage);
	int startRow = (currentPage * 10) -9;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();
	
	if(search.equals("") || search == null)
		count = dbPro.getArticleCount();
	else
		count = dbPro.getArticleCount(searchn,search); 
	
	CommentDBBean cdb=CommentDBBean.getInstance();
	
	if(count > 0)
	{
		if(search.equals("") || search == null)
			articleList = dbPro.getArticles(startRow, endRow);
		else
			articleList = dbPro.getArticles(startRow, endRow, searchn, search);
	}
	
	number = count-(currentPage - 1) * pageSize;
			// 11 -(2-1) *3 = 8
%>

<div id="wrap">
<div id="header"><h1>글목록(전체글:<span class="count"><%= count %></span>)</h1></div>
	
<div id="content">

<%if(count==0){ %>

	<p class="noData">작성된 글이 없습니다.</p>	
<%}
else
{%>

<table class="listForm">
			<colgroup>
				<col width="10%" />
				<col width="*" />
				<col width="15%" />
				<col width="20%" />
				<col width="9%" />
				<col width="15%" />
			</colgroup>

			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>IP</th>	
			</tr>

<%

	for(int i = 0; i < articleList.size() ; i++)
	{
		BoardDataBean article = (BoardDataBean) articleList.get(i);
		int com_count=cdb.getCommentCount(article.getNum());
%>


<tr class="listCon">
				<td><%= number-- %></td>
				<td class="subject">
<%		
		int wid = 0;
		if(article.getRe_level() >0)
		{
			//답변글이라면.
			 wid = 5 * (article.getRe_level());
%>
					
<%
		}
		else
		{}
			//답변글 아니면 정상적으로 표시하고
%>

<% if(com_count > 0){ %>
		<a href="content.jsp?num=<%= article.getNum() %>&pageNum=<%= currentPage %>">
		<%= article.getSubject() %></a>&nbsp;
		<span class="cmtCount">[<%=com_count %>]</span>
					
<%}else{%>
			<a href="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
			<%=article.getSubject() %></a>		
<%} %>					

<%if(article.getReadcount() >= 20){ %>
	<span class="icoHot">HIT</span>
	
	<% } else {} %>
					
	</td>
	
		<td><a href="mailto:<%= article.getEmail() %>"><%= article.getWriter() %></a></td>
				<td><%= sdf.format(article.getReg_date())%></td>
				<td><%= article.getReadcount() %></td>
				<td><%= article.getIp() %></td>
			</tr>
<%
	}
%>
</table>
<%} %>

<div class="paging">

<%
	if(count > 0)
	{
		// 전체 페이지 수를 연산
		int pageCount = count / pageSize + (count % pageSize == 0? 0 : 1);
		
		int startPage = (int)(currentPage/5)*5+1;
		int pageBlock = 5;
		int endPage = startPage + pageBlock-1;
		
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 5)
		{
			//이전 페이지
			if(search.equals("") || search == null)
			{
%>
				<a href="list.jsp?pageNum=<%=startPage - 5 %>">[이전]</a>
<%
			}
			else
			{
%>
				<a href="list.jsp?pageNum=<%=startPage - 5 %>&search=<%=search %>&searchn=<%=searchn %>">[이전]</a>
<%
			}
		}
%>
<ol>
<%			
	
		for(int i = startPage; i<=endPage; i++)
		{
			//해당페이지로 이동
			if(search.equals("") || search == null)
			{
%>
				<li><a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a></li>
<%
			}
			else
			{
%>
				<li><a href="list.jsp?pageNum=<%=i %>&search=<%=search %>&searchn=<%=searchn %>">[<%=i %>]</a></li>
<%
			}
		}
%>		
		</ol>
	<%	
		if(endPage < pageCount)
		{
			//다음페이지
			if(search.equals("") || search == null)
			{
%>
				<a href="list.jsp?pageNum=<%=startPage + 5 %>">[다음]</a>
<%
			}
			else
			{
%>
				<a href="list.jsp?pageNum=<%=startPage + 5 %>&search=<%=search %>&searchn=<%=searchn %>">[다음]</a>
<%
			}
%>
<%	
		}
	}

%>
</div>
</div>
<form>

		<div class="searchWarp">
			<select name="searchn">
				<option value="0">작성자</option>
				<option value="1">제목</option>
				<option value="2">내용</option>
			</select>
			<input type="text" name="search" />
			<input type="submit" value="검색" class="btn" />
		</div>
	</form>
	<div id="footer">
		<input type="button" value="글쓰기" onclick="javascript:window.location='writeForm.jsp'" />
	</div>
</div>
</body>
</html>



<%
	if(session.getAttribute("memId")!=null){
	%>
<%= session.getAttribute("memId") %>님
<input type=button value="로그아웃" onclick="document.location.href='/SOLENE/july31/logout.jsp'">
<% } %>

<%
	if(session.getAttribute("memId") != null){
%>
			<a href="writeForm.jsp">글쓰기</a>
			<% } else { %>
		<a href="/SOLENE/july31/loginForm.jsp">로그인</a>
		<% } %>
		</td>
