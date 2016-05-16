package com.trainingshare.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainingshare.db.DBConnect;
import com.trainingshare.model.ActivityBean;

/**
 * Servlet implementation class NewActivityCl
 */
@WebServlet("/NewActivityCl")
public class NewActivityCl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewActivityCl() {
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
		String activityTitle = request.getParameter("activitytitle");
		String activityContent = request.getParameter("activitycontent");
		String activityLocation = request.getParameter("location");
		String activityStartTime = request.getParameter("starttime");
		String activityEndTime = request.getParameter("endtime");
		
		if(!activityTitle.equals(null)&&!activityTitle.equals("")
		    &&!activityContent.equals(null)&&!activityContent.equals("")
			&&!activityStartTime.equals(null)&&!activityStartTime.equals("")
			&&!activityEndTime.equals(null)&&!activityEndTime.equals(""))
		{
			DBConnect dbc = new DBConnect();
			ActivityBean ab = new ActivityBean();
			ab.setTitle(activityTitle);
			ab.setDetails(activityContent);
			ab.setMemberId(1);
			response.getWriter().println("½×¶Î1");
			ab.setMeetingRomId(dbc.QueryMeetingRomId(activityLocation));
			ab.setStartTime(activityStartTime);
			ab.setEndTime(activityEndTime);
			ab.setRemak("");
			response.getWriter().println(ab);
			if(dbc.AddNewAcivity(ab).equals("³É¹¦"))
			{
				response.sendRedirect("Main.jsp");
			}
		}
	}

}
