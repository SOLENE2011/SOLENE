package kh.action;

import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.logon.LogonDBBean;
import kh.logon.ZipcodeBean;

public class ZipcheckAction implements CommandAction {

	public String requestPro(HttpServletRequest request, HttpServletResponse response) 
			throws Throwable {
		
		request.setCharacterEncoding("euc-kr");

		String check = request.getParameter("check");
		String area3 = request.getParameter("area3");
		LogonDBBean dbPro = LogonDBBean.getInstance();
		Vector<ZipcodeBean> zipcodeList = dbPro.zipcodeRead(area3);
		System.out.println(zipcodeList.size());
		request.setAttribute("check", check);
		request.setAttribute("area3", area3);
		request.setAttribute("zipcodeList", zipcodeList);
		return "/logon2/zipcheck.jsp";
	}

}
