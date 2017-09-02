<%@page import="article.ArticleListModel"%>
<%@page import="article.ListArticleService"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<!-- list에 필요한 기능 -->
<!-- 보여지는건 list_view에 있음 -->

<%
String pageNumberString = request.getParameter("p");

/* 검색기능 */
String search = request.getParameter("search");
/* 검색어 search */
int searchn = 0;
if(search == null) {
	search = ""	;
	/* 리스트에서 검색을 하지 않을때는 그냥 빈 값으로 둠!  */
}else{
	searchn = Integer.parseInt(request.getParameter("searchn"));
	/* 리스트에서 검색을 할때는 searchn을 parameter로 받아옴 */
	/* list_view에서 */
	/* 
	<select name="searchn">
	<option value="0">작성자</option>
	<option value="1">제목</option>
	<option value="2">내용</option>
	</select> */
}


int pageNumber = 1;
if(pageNumberString != null && pageNumberString.length() > 0) {
	pageNumber = Integer.parseInt(pageNumberString);
}



ListArticleService listService = ListArticleService.getInstance();
ArticleListModel articleListModel = null;

	if(search!= null){
		articleListModel = listService.getArticleList(pageNumber,searchn,search);
		/* 만약 검색어 기능을 사용한다면 조건에 맞는 리스트를 불러오고*/
	} else {
		articleListModel = listService.getArticleList(pageNumber);
		/* 리스트를 사용하지 않을거면 총 게시글의 리스트를 불러온다. */
	}

request.setAttribute("listModel", articleListModel);

if(articleListModel.getTotalPageCount() > 0) {
	//페이지 이동 링크의 페이지 시작 번호와 끝 번호를 계산해서 구한다.
	int beginPageNumber = (articleListModel.getRequestPage()-1) / 10*10+1;
	int endPageNumber = beginPageNumber + 9;
	if(endPageNumber > articleListModel.getTotalPageCount()){
		endPageNumber = articleListModel.getTotalPageCount();
	}
	//페이지 시작 번호와 끝 번호를 request 객체에 속성으로 저장한다.
	request.setAttribute("beginPage", beginPageNumber);
	request.setAttribute("endPage", endPageNumber);
}
%>

<jsp:forward page = "./list_view.jsp" />
