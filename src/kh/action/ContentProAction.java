package kh.action;

import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.board.BoardDBBean;
import kh.board.BoardDataBean;
import kh.board.CommentDBBean;
import kh.board.CommentDataBean;

public class ContentProAction implements CommandAction {
	
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws Throwable {
		
		request.setCharacterEncoding("euc-kr");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String content_num = request.getParameter("content_num");
		String p_num = request.getParameter("p_num");
		
		BoardDBBean dbPro = BoardDBBean.getInstance();
		BoardDataBean article = dbPro.getArticle(num);
		CommentDBBean cdb = CommentDBBean.getInstance();
		
		
		return "/MVC/content.jsp?num="+content_num+"&pageNum="+p_num;
	}

}
