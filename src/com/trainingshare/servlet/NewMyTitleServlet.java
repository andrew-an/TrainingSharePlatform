package com.trainingshare.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainingshare.db.DBConnect;
import com.trainingshare.model.ActivityContentBean;

/**
 * Servlet implementation class NewMyTitleServlet
 */
@WebServlet("/NewMyTitleServlet")
public class NewMyTitleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewMyTitleServlet() {
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
		DBConnect dbc = new DBConnect();
		String username = (String)request.getSession().getAttribute("username");
		String title = request.getParameter("mytitle");
		String titleoriginal = request.getParameter("titleoriginal");//修改前的标题名称，根据此字段判断是插入操作还是更新操作
		String time = request.getParameter("time");
		String location = request.getParameter("roomnumber");
		if(null!=title && !title.equals("") && null!=titleoriginal
		   && null != time && !time.equals("")
		   && null != location && !location.equals(""))
		{
			int membersId = Integer.parseInt(request.getParameter("membersId"));
			ActivityContentBean acb = new ActivityContentBean();
			acb.setMembersId(membersId);
			acb.setMemberId(dbc.GetMemberIdByName(new String[]{username}).get(0));
			acb.setTitle(title);
			acb.setMeetingRoomId(dbc.GetMeetingRoomIdByName(location));
			acb.setStartTime(time.replace("/", "-"));
			acb.setFilePath("");
			acb.setUploadFlag("0");
			acb.setRemark("");
			//如果原标题为空，则说明此时正在新建标题业务，应该执行插入操作
			if(titleoriginal.equals(""))
			{
				if(dbc.AddNewAcivityContent(acb) == true)
				{
					//request.setAttribute("membersId", Integer.toString(membersId));
					//request.setAttribute("activityContentList", dbc.GetActivityContentByMembersId(membersId));
					//request.getRequestDispatcher("ActivityContent.jsp").forward(request,response);
					response.getWriter().write("save_success");
				}
				else
				{
					response.getWriter().write("save_failed");
				}
			}
			else//否则执行更新操作
			{
				if(dbc.UpdateActivityContentByTitle(titleoriginal, acb))
				{
					response.getWriter().write("edit_success");
				}
				else
				{
					response.getWriter().write("edit_failed");
				}
			}
		}
		else
		{
			response.getWriter().write("failed");
		}
	}

}
