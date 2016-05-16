package com.trainingshare.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainingshare.db.DBConnect;

/**
 * Servlet implementation class MainClServlet
 */
@WebServlet("/MainClServlet")
public class MainClServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainClServlet() {
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
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8"); 
		
		String title = request.getParameter("title");
		//title = new String(title.getBytes("iso-8859-1"),"utf-8");
		DBConnect dbc = new DBConnect();
		//根据点击的标题，取得该活动的Id
		int id = dbc.GetMembersIdByTitle(title);
		//System.out.println(id);
		if(id != 0)
		{
			ArrayList<ArrayList<String>> activityContentList = new ArrayList<ArrayList<String>>();
			//根据活动Id，获得参加该活动的所有人员Id
			ArrayList<String> al = dbc.GetAllMembers(id);
			//System.out.println(al);
			Iterator<String> it = al.iterator();
			while(it.hasNext())
			{
				int memberId = Integer.parseInt((String)it.next());
				//System.out.println(id+","+memberId);
				ArrayList<String> al_activity = dbc.GetActivityContentByMemberId(id,memberId);
				activityContentList.add(al_activity);
			}
			request.setAttribute("activityContentList",activityContentList);
			request.getRequestDispatcher("ActivityContent.jsp").forward(request,response);
			
		}
		else
		{
			request.getRequestDispatcher("Main.jsp").forward(request,response);
		}
	}

}
