package com.trainingshare.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
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
			//System.out.println("密码为："+pwd);
			DBConnect dbc = new DBConnect();
			UserInfoBean user = dbc.checkUser(name, pwd);
			//用户名密码验证成功
			if(user != null)
			{
				
				//session.setAttribute("workNumber", user.getWorkNumber());
				String checkbox = request.getParameter("checkbox_keeppwd");
				if(null != checkbox && checkbox.equals("on"))
				{
					//如果选中自动登录，则添加cookie
					Cookie ckUserName = new Cookie("username",name);
					Cookie ckPasswrod = new Cookie("password",pwd);
					response.addCookie(ckUserName); 
					response.addCookie(ckPasswrod);
				}
				else
				{
					//如果自动登录未选中，则删除cookie
					Cookie[] cookies = request.getCookies();
					for(Cookie ck:cookies)
					{
						if(ck.getName().equals("username") || ck.getName().equals("password"))
						{
							ck.setMaxAge(0);
							response.addCookie(ck);
						}
					}
				}
				
				request.setAttribute("userName", name);
				request.setAttribute("administratorFlag", user.getAdministratorFlag());
				request.setAttribute("activityTitle", dbc.GetActivityTitle());
				//设置自动登录保留时间
				request.setAttribute("autologin", true);
				session.setMaxInactiveInterval(7*24*3600);
				
				getServletContext().getRequestDispatcher("/Main.jsp").forward(request, response);
			}
			else
			{
				request.setAttribute("errorinfo", "login_faild");
				getServletContext().getRequestDispatcher("/Login.jsp").forward(request, response);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
}
