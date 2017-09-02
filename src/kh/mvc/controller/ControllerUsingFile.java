package kh.mvc.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.net.URL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mvc.command.CommandHandler;
import kh.mvc.command.NullHandler;

public class ControllerUsingFile extends HttpServlet {

	
	// <command, handlerInstance>�� ���� ���� ����
	private Map commandHandlerMap = new java.util.HashMap();

	public void init(ServletConfig config) throws ServletException {
		String configFile = config.getInitParameter("configFile");
		Properties prop = new Properties();
		FileInputStream fis = null;
		try {
			String configFilePath = config.getServletContext().getRealPath(configFile);
			fis = new FileInputStream(configFilePath);
			prop.load(fis);

		} catch (IOException e) {
			throw new ServletException(e);
		} finally {
			if (fis != null)
				try {
					fis.close();
				} catch (IOException ex) {

				}
		}

		Iterator ketIter = prop.keySet().iterator();
		while (ketIter.hasNext()) {
					
			String command = (String) ketIter.next();
			String handlerClassName = prop.getProperty(command);
			try {
				Class handlerClass = Class.forName(handlerClassName);
				Object handlerInstance = handlerClass.newInstance();
				commandHandlerMap.put(command, handlerInstance);
			} catch (ClassNotFoundException e) {
				throw new ServletException(e);
			} catch (InstantiationException e) {
				throw new ServletException(e);
			} catch (IllegalAccessException e) {
				throw new ServletException(e);
			}

		}

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse reponse)
			throws ServletException, IOException {
		process(request, reponse);
	}

	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("cmd");

		CommandHandler handler = (CommandHandler) commandHandlerMap.get(command);
		//interface�� Ŭ���� ����
		//map�� ���ǰɸ鼭 ������ �ϴ� �۾��� ���� �ʱ� ����
		//�ֻ����� �������̽��� �θ�� ��ü ����
		
		if (handler == null) {
			handler = new NullHandler();
		}
		String viewPage = null;
		try {
			viewPage = handler.process(request, response);
			//�޼ҵ�� ������ �׷��� ���� ó������ �ʾƵ� ��!
		} catch (Throwable e) {
			throw new ServletException(e);
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);

	}

}
