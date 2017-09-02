// http://hsp1116.tistory.com/9 �޷�
//http://cbcvic.egloos.com/v/544495 �޷�2

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

	//������ ��������� ��! �⺻ ����~!
	
	// URI properties�� �ִ� Ű ���� value�� �������� �۾�.
public void init(ServletConfig config) throws ServletException{
	// ServletConfig: web.xml�� ���ǵǾ�����.
	
	String props = config.getInitParameter("configFile2");
	//	System.out.println(props);
	//	��°�: /WEB-INF/commandHandlerURI.properties
	Properties pr = new Properties();
	FileInputStream f = null;
	
	try {
		String configFilePath = config.getServletContext().getRealPath(props);
		// ServletContext �������̽��� getRealPath() �޼��带 �̿��ؼ�
		// web.xml�� init-param�� ������ ������ properties ������ ��ġ�� ���� ��θ� ��´�.
		
		f = new FileInputStream(configFilePath);
		pr.load(f);
		//inputStream���� ���� �����θ� load�ؼ� properties�� �д´�  
	}catch (IOException e) {
		throw new ServletException(e);
	}finally {
		if(f!= null) try {f.close(); } catch(IOException ex) {}
	}
	
	Iterator keyIter = pr.keySet().iterator();
	//	Iterator�� ��ü�� �ϳ��ϳ� �д� ����� �Ѵ�.
	//	properties�� �� Ű������ �о����
	//  /MVC/list.do
	//  /MVC/writeForm.do
	
	while(keyIter.hasNext()) {
		String command = (String)keyIter.next();
		//	System.out.println(command);
		//	Ű�� command(������ Ű��, �������� property�ƴ� value)
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
	
// GET������� ������ requestPro�� ó���ϰڴ�.
public void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
	requestPro(request, response);
}

// POST������� ������ requestPro�� ó���ϰڴ�.
protected void doPost (
		HttpServletRequest request, HttpServletResponse response) 
throws ServletException, IOException {
	requestPro(request, response);
}


//�ÿ����� ��û�� �м��ؼ� �ش� �۾��� ó��
private void requestPro(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
	String view = null;
	CommandAction com = null;
	
	try {
		String command = request.getRequestURI();
		
		//	request.getRequestURI()
		//	��û : http://localhost:8080/logon2/list.do
		//	���ϰ� : /logon2/list.do
	
		if (command.indexOf(request.getContextPath()) == 0) {
			
			//	request.getContextPath()
			//	��û : http://localhost:8080/logon2/list.do
			//	���ϰ� : /logon2
			// �տ����� ��ġ�ϸ�  
			command = command.substring(request.getContextPath().length());
		}
		com = (CommandAction)commandMap.get(command);
		
		//	commandAcion > �������̽� > �������̽��� �����ϴ°�? > ���׼�!
		//	Ű�� ������!
		//	���� /logon2/list.do��� > value �� action.listAction
		
		if(com == null) {
			com = new NullAction();
			
		}
		view = com.requestPro(request, response);
		// return "/logon2/inputForm.jsp"; �̷����� ������ ���ƿ�! 
		
	}catch (Throwable e) {
		throw new ServletException(e);			
		}
	RequestDispatcher dispatcher = request.getRequestDispatcher(view);
	// JSP�� Forward ������ �ϴ� �޼��� request.getRequestDispatcher();
	dispatcher.forward(request, response);
	}
	
}