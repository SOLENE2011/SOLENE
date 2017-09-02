package kh.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NullAction implements CommandAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
	throws Throwable {
		return "/view/nullCommand.jsp";
	}

}
