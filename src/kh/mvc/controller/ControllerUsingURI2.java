// http://hsp1116.tistory.com/9 메롱
//http://cbcvic.egloos.com/v/544495 메롱2

package kh.mvc.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.action.CommandAction;
import kh.action.NullAction;

public class ControllerUsingURI2 extends HttpServlet {
private Map commandMap = new HashMap();

	//서버를 실행시켰을 때! 기본 셋팅~!
	
	// URI properties에 있는 키 값과 value를 가져오는 작업.
public void init(ServletConfig config) throws ServletException{
	// ServletConfig: web.xml에 정의되어있음.
	
	String props = config.getInitParameter("configFile2");
	//	System.out.println(props);
	//	출력값: /WEB-INF/commandHandlerURI.properties
	Properties pr = new Properties();
	FileInputStream f = null;
	
	try {
		String configFilePath = config.getServletContext().getRealPath(props);
		// ServletContext 인터페이스의 getRealPath() 메서드를 이용해서
		// web.xml의 init-param의 값으로 지정된 properties 파일이 위치한 절대 경로를 얻는다.
		
		f = new FileInputStream(configFilePath);
		pr.load(f);
		//inputStream으로 읽은 절대경로를 load해서 properties를 읽는다  
	}catch (IOException e) {
		throw new ServletException(e);
	}finally {
		if(f!= null) try {f.close(); } catch(IOException ex) {}
	}
	
	Iterator keyIter = pr.keySet().iterator();
	//	Iterator는 객체를 하나하나 읽는 기능을 한다.
	//	properties의 이 키값들을 읽어들임
	//  /MVC/list.do
	//  /MVC/writeForm.do
	
	while(keyIter.hasNext()) {
		String command = (String)keyIter.next();
		//	System.out.println(command);
		//	키값 command(왼쪽이 키값, 오른쪽이 property아님 value)
		//	/logon2/loginPro.do
		//	/logon2/deleteForm.do
		//	/logon2/zipcheck.do
		String className = pr.getProperty(command);
		// action.ListAction
		try {
			Class commandClass = Class.forName(className);
			//Class.forName: return the Class 
			Object commandInstance = commandClass.newInstance();
			commandMap.put(command, commandInstance);
		}catch (ClassNotFoundException e) {
			throw new ServletException(e);
		}catch (InstantiationException e) {
			throw new ServletException(e);
		}catch(IllegalAccessException e) {
			throw new ServletException(e);
		}
	}
}
	
// GET방식으로 들어오면 requestPro로 처리하겠다.
public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
	requestPro(request, response);
}

// POST방식으로 들어오면 requestPro로 처리하겠다.
protected void doPost (
		HttpServletRequest request, HttpServletResponse response) 
throws ServletException, IOException {
	requestPro(request, response);
}


//시용자의 요청을 분석해서 해당 작업을 처리
private void requestPro(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
	String view = null;
	CommandAction com = null;
	
	try {
		String command = request.getRequestURI();
		
		//	request.getRequestURI()
		//	요청 : http://localhost:8080/logon2/list.do
		//	리턴값 : /logon2/list.do
	
		if (command.indexOf(request.getContextPath()) == 0) {
			
			//	request.getContextPath()
			//	요청 : http://localhost:8080/logon2/list.do
			//	리턴값 : /logon2
			// 앞에꺼랑 일치하면  
			command = command.substring(request.getContextPath().length());
		}
		com = (CommandAction)commandMap.get(command);
		
		//	commandAcion > 인터페이스 > 인터페이스를 구현하는건? > 모든액션!
		//	키를 가져옴!
		//	만약 /logon2/list.do라면 > value 값 action.listAction
		
		if(com == null) {
			com = new NullAction();
			
		}
		view = com.requestPro(request, response);
		// return "/logon2/inputForm.jsp"; 이런값을 가지고 돌아옴! 
		
	}catch (Throwable e) {
		throw new ServletException(e);			
		}
	RequestDispatcher dispatcher = request.getRequestDispatcher(view);
	// JSP의 Forward 역할을 하는 메서드 request.getRequestDispatcher();
	dispatcher.forward(request, response);
	}
	
}