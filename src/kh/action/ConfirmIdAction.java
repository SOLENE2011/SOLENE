package kh.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.logon.LogonDBBean;

public class ConfirmIdAction implements CommandAction {
	
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
	throws Throwable {
		
		request.setCharacterEncoding("euc-kr");
		
		String id = request.getParameter("id");
		
		LogonDBBean dbPro = LogonDBBean.getInstance();
		int check = dbPro.confirmId(id);
		
		request.setAttribute("id", id);
		request.setAttribute("check", new Integer(check));
		
		return "/logon2/confirmId.jsp";
		
	}

}
