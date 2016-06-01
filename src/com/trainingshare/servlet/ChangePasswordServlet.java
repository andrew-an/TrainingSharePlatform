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
		String username = (String)request.getParameter("uname");
		String password_old = (String)request.getParameter("pwd_old");
		
		try{
			if(null!=username && !username.equals("") && null!=password_old && !password_old.equals(""))
			{
				//判断用户更改密码时输入的原密码是否正确
				if(dbc.checkUser(username, password_old) != null)
				{
					response.getWriter().write("success");
				}
				else
				{
					response.getWriter().write("failed");
				}
			}
			else
			{
				String password_new = (String)request.getParameter("pwd_new");
				if(dbc.UpdatePassword(username, password_new) == true)
				{
					response.getWriter().write("success");
				}
				else
				{
					response.getWriter().write("failed");
				}
			}
			return;
		}
		catch(Exception ex)
		{
			System.out.println("ChangePasswordServlet");
			ex.printStackTrace();
		}
	}

}
