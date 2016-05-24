package com.trainingshare.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trainingshare.db.DBConnect;
import com.trainingshare.model.ActivityBean;
import com.trainingshare.model.ActivityContentBean;

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
		
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8"); 
		
		String activityTitle = request.getParameter("activitytitle");
		String activityDetails = request.getParameter("activitydetails");
		String activityStartTime = request.getParameter("starttime");
		String activityEndTime = request.getParameter("endtime");
		String[] memberName = request.getParameterValues("item");
		
		if(null!=activityTitle && !activityTitle.equals("")
			&& null != activityDetails && !activityDetails.equals("")
			&& null != activityStartTime && !activityStartTime.equals("")
			&& null != activityEndTime && !activityEndTime.equals("")
			&& null != memberName && memberName.length>0)
		{
			//�ڳ�Ա�������һ���¼�¼�����õ��ü�¼��Id��
			int membersId = AddNewMembersTable(memberName);
			if(membersId>0)
			{
				DBConnect dbc = new DBConnect();
				ActivityBean ab = new ActivityBean();
				ab.setTitle(activityTitle);
				ab.setDetails(activityDetails);
				ab.setMembersId(membersId);
				ab.setStartTime(activityStartTime);
				ab.setEndTime(activityEndTime);
				ab.setRemak("");
				//�ڻ���ݱ������һ���¼�¼�����õ��ü�¼��Id��
				int activityId = dbc.AddNewAcivity(ab);
				if(0 != activityId)
				{
					ArrayList<String> alMembersList = dbc.GetAllMembersById(membersId);
					if(null != alMembersList && alMembersList.size()>0)
					{
						/*int i=0;
						for(; i<alMembersList.size(); i++)
						{
							ActivityContentBean acb = new ActivityContentBean();
							acb.setMembersId(membersId);
							acb.setMemberId(Integer.parseInt(alMembersList.get(i)));
							acb.setTitle(new String("˫���༭�ҵı���".getBytes("utf-8"),"ISO-8859-1"));
							acb.setFilePath("");
							acb.setUploadFlag("0");
							acb.setRemark("");
							//�ڻ������������г����вμӸû�ĳ�Ա��Ĭ����Ϣ
							if(dbc.AddNewAcivityContent(acb) == true)
								continue;
							else
								break;//�˴�Ӧ�÷��ش洢���ݿ�ʧ�ܵ���ʾ��Ϣ
						}
						if(i == alMembersList.size())
						{
							//��ȡ���л����б�
							request.setAttribute("activityTitleList", dbc.GetActivityTitle());
							//System.out.println(dbc.GetActivityTitle().size());
							//response.sendRedirect("Main.jsp");
							request.getRequestDispatcher("Main.jsp").forward(request,response);
						}
						else
							response.sendRedirect("NewActivity.jsp");*/
						request.setAttribute("activityTitleList", dbc.GetActivityTitle());
						request.getRequestDispatcher("Main.jsp").forward(request,response);
					}
					else
						response.sendRedirect("NewActivity.jsp");
				}
				else
					response.sendRedirect("NewActivity.jsp");
			}
			else
				response.sendRedirect("NewActivity.jsp");
		}
		else
			response.sendRedirect("NewActivity.jsp");
		
	}
	
	//��members��������¼�¼(�ôλ��Id�ţ��Ͳμӻ����ԱId�б�),��������ӵļ�¼��Id��
	public int AddNewMembersTable(String[] memberName)
	{
		int ret=0;
		if(memberName.length>0)
		{
			DBConnect dbc = new DBConnect();
			ArrayList<Integer> alUserIdList = dbc.GetMemberIdByName(memberName);
			if(alUserIdList.size()>0)
			{
				//��ȡ�μӸôλ����ԱId�б�
				String membersList = "";
				for(int i=0; i<alUserIdList.size(); i++)
					membersList += Integer.toString(alUserIdList.get(i)) +",";
				if(membersList.endsWith(","))
					membersList.substring(0, membersList.length()-1);
				//��members���в���һ���¼�¼�����õ��¼�¼��Idֵ
				int membersId = dbc.UpdateMembersTable(membersList);
				if(0 != membersId)
					ret = membersId;
			}
		}
		return ret;
	}
}
