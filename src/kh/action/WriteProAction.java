package kh.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.board.BoardDBBean;
import kh.board.BoardDataBean;

public class WriteProAction implements CommandAction {
	
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
	throws Throwable {
		
		request.setCharacterEncoding("euc-kr");
		
		BoardDataBean article = new BoardDataBean();
		article.setNum(Integer.parseInt(request.getParameter("num")));
		article.setWriter(request.getParameter("writer"));
		article.setEmail(request.getParameter("email"));
		article.setSubject(request.getParameter("subject"));
		article.setPasswd(request.getParameter("passwd"));
		article.setReg_date(new Timestamp(System.currentTimeMillis()));
		article.setRef(Integer.parseInt(request.getParameter("ref")));
		article.setRe_step(Integer.parseInt(request.getParameter("re_step")));
		article.setRe_level(Integer.parseInt(request.getParameter("re_level")));
		article.setContent(request.getParameter("content"));
		article.setIp(request.getRemoteAddr());
		
		BoardDBBean dbPro = BoardDBBean.getInstance();
		dbPro.insertArticle(article);
		
		return "/MVC/writePro.jsp";
	}

	
	
}
