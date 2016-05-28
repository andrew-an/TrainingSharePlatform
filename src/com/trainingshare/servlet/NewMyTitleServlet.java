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
		String removeFlag = (String)request.getParameter("removeflag");
		int membersId = Integer.parseInt(request.getParameter("membersId"));
		String username = (String)request.getSession().getAttribute("username");
		String title = request.getParameter("mytitle");
		String titleoriginal = request.getParameter("titleoriginal");//�޸�ǰ�ı������ƣ����ݴ��ֶ��ж��ǲ���������Ǹ��²���
		String time = request.getParameter("time");
		String location = request.getParameter("roomnumber");
		
		//���ɾ����־��Ϊ�գ���ִ��ɾ���������
		if(null!=removeFlag && removeFlag.equals("true"))
		{
			if(new DBConnect().DeleteMemberPerson(membersId, title))
				response.getWriter().write("remove_success");
			else
				response.getWriter().write("remove_failed");
		}
		else//����ִ���½�����²���
		{
			ActivityContentBean acb = new ActivityContentBean();
			acb.setMembersId(membersId);
			acb.setMemberId(dbc.GetMemberIdByName(new String[]{username}).get(0));
			acb.setTitle(title);
			acb.setMeetingRoomId(dbc.GetMeetingRoomIdByName(location));
			acb.setStartTime(time.replace("/", "-"));
			acb.setFilePath("");
			acb.setUploadFlag("0");
			acb.setRemark("");
			//���ԭ����Ϊ�գ���˵����ʱ�����½�����ҵ��Ӧ��ִ�в������
			if(titleoriginal.equals(""))
			{
				//�жϸñ����Ƿ��Ѵ���
				if(!dbc.CheckActivityContentExistorNot(membersId,title))
				{
					if(dbc.AddNewAcivityContent(acb) == true)
					{
						response.getWriter().write("save_success");
					}
					else
					{
						response.getWriter().write("save_failed");
					}
				}
				else
				{
					response.getWriter().write("title exist");
				}
			}
			else//����ִ�и��²���
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
	}
}
