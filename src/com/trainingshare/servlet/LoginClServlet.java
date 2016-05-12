package com.trainingshare.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.trainingshare.db.*;
import com.trainingshare.model.*;
/**
 * Servlet implementation class LoginClServlet
 */
@WebServlet("/LoginClServlet")
public class LoginClServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginClServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			HttpSession session = request.getSession();
			String name = request.getParameter("username");
			String pwd = request.getParameter("password");
			UserInfoBean user = new DBConnect().checkUser(name, pwd);
			if(user != null)
			{
				session.setAttribute("workNumber", user.getWorkNumber());
				session.setAttribute("userName", name);
				response.sendRedirect("Main.jsp");
			}
			else
			{
				response.sendRedirect("Login.jsp");
			}			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}

}
