<%@page import="article.ArticleListModel"%>
<%@page import="article.ListArticleService"%>
<%@ page contentType="text/html; charset=euc-kr" %>

<!-- list�� �ʿ��� ��� -->
<!-- �������°� list_view�� ���� -->

<%
String pageNumberString = request.getParameter("p");

/* �˻���� */
String search = request.getParameter("search");
/* �˻��� search */
int searchn = 0;
if(search == null) {
	search = ""	;
	/* ����Ʈ���� �˻��� ���� �������� �׳� �� ������ ��!  */
}else{
	searchn = Integer.parseInt(request.getParameter("searchn"));
	/* ����Ʈ���� �˻��� �Ҷ��� searchn�� parameter�� �޾ƿ� */
	/* list_view���� */
	/* 
	<select name="searchn">
	<option value="0">�ۼ���</option>
	<option value="1">����</option>
	<option value="2">����</option>
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
		/* ���� �˻��� ����� ����Ѵٸ� ���ǿ� �´� ����Ʈ�� �ҷ�����*/
	} else {
		articleListModel = listService.getArticleList(pageNumber);
		/* ����Ʈ�� ������� �����Ÿ� �� �Խñ��� ����Ʈ�� �ҷ��´�. */
	}

request.setAttribute("listModel", articleListModel);

if(articleListModel.getTotalPageCount() > 0) {
	//������ �̵� ��ũ�� ������ ���� ��ȣ�� �� ��ȣ�� ����ؼ� ���Ѵ�.
	int beginPageNumber = (articleListModel.getRequestPage()-1) / 10*10+1;
	int endPageNumber = beginPageNumber + 9;
	if(endPageNumber > articleListModel.getTotalPageCount()){
		endPageNumber = articleListModel.getTotalPageCount();
	}
	//������ ���� ��ȣ�� �� ��ȣ�� request ��ü�� �Ӽ����� �����Ѵ�.
	request.setAttribute("beginPage", beginPageNumber);
	request.setAttribute("endPage", endPageNumber);
}
%>

<jsp:forward page = "./list_view.jsp" />
