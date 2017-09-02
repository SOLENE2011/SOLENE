package kh.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.logon.LogonDBBean;
import kh.logon.LogonDataBean;

public class LogonModifyFormAction implements CommandAction {
	
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
	throws Throwable {
		
		String id = request.getParameter("id");
		
		LogonDBBean dbPro = LogonDBBean.getInstance();
		LogonDataBean member = dbPro.getMember(id);
		
		request.setAttribute("member", member);
		
		return "/logon2/modifyForm.jsp";
	}

}
