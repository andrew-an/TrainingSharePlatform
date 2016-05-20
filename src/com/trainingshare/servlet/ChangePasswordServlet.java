package com.trainingshare.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainingshare.db.DBConnect;

/**
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordServlet() {
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
		DBConnect dbc = new DBConnect();
		String username = (String)request.getParameter("username");
		String password_old = (String)request.getParameter("password_old");
		System.out.println(username);
		System.out.println(password_old);
		PrintWriter out = response.getWriter();
		if(null!=username && !username.equals("") && null!=password_old && !password_old.equals(""))
		{
			if(dbc.checkUser(username, password_old) != null)
			{
				out.print("success");
			}
			else
			{
				out.print("failed");
			}
			out.flush();
			out.close();
		}
		else
		{
			username = (String)request.getAttribute("username");
			String password_new = (String)request.getAttribute("password_new");
			if(dbc.UpdatePassword(username, password_new) == true)
			{
				request.setAttribute("return", "success");
			}
			else
			{
				request.setAttribute("return", "failed");
			}
			request.getRequestDispatcher("ChangePassword.jsp").forward(request,response);
		}
	}

}
