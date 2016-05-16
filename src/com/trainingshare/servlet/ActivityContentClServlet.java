package com.trainingshare.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import com.trainingshare.db.DBConnect;

/**
 * Servlet implementation class ActivityContentClServlet
 */
@WebServlet("/ActivityContentClServlet")
public class ActivityContentClServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ActivityContentClServlet() {
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
		String activityContentBefore = request.getParameter("activityContentBefore");
		String activityContent = request.getParameter("activityContent");
		//activityContent = new String(activityContent.getBytes("iso-8859-1"),"utf-8");
		//System.out.println(activityContentBefore+","+activityContent);
		DBConnect dbc = new DBConnect();
		Boolean ret=false;
		ret = dbc.UpdateActivityContent(activityContentBefore, activityContent);	
		if(ret == true)
		{
			//activityContent = new String(activityContent.getBytes("iso-8859-1"),"utf-8");
			//System.out.println(activityContent);
		    response.getWriter().print(activityContent);
		}
		else
		{
			//activityContentBefore = new String(activityContentBefore.getBytes("iso-8859-1"),"utf-8");
			//System.out.println(activityContentBefore);
			response.getWriter().print(activityContentBefore);
		}
		return;
	}

}
