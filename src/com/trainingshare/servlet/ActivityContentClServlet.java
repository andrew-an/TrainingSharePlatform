package com.trainingshare.servlet;

import java.io.*;
import java.net.URLDecoder;

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
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		
		String membersId = request.getParameter("membersId");
		String memberName = request.getParameter("loginUser");
		String activityContentBefore = request.getParameter("activityContentBefore");
		String activityContent = request.getParameter("activityContent");
		
		if(null!=membersId && null!= memberName && null != activityContentBefore && null != activityContent)
		{
			DBConnect dbc = new DBConnect();
			Boolean ret=false;
			ret = dbc.UpdateActivityContent(membersId,memberName,activityContentBefore, activityContent);	
			if(ret == true)
			{
			    response.getWriter().print(activityContent);
			}
			else
			{
				response.getWriter().print(activityContentBefore);
			}
		}
		
		String fileName = (String)request.getParameter("fileName");
		if(null!=membersId && null!= memberName && null != fileName && null != activityContent)
		{
			BufferedInputStream fileIn = new BufferedInputStream(request.getInputStream()); 
			fileName = URLDecoder.decode(fileName,"utf-8"); 
			activityContent = URLDecoder.decode(activityContent,"utf-8"); 
			byte[] buf = new byte[1024];
			//接收文件上传并保存到 d:\
			File file = new File("d:/TrainingShare/" + fileName); 
			BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file));
			int fileReadAllLength = 0;//保存总共传输的字节数，判断文件是否全部传输完成
			while (true) 
			{ 
				// 读取数据
				int bytesIn = fileIn.read(buf, 0, 1024); 
				if (bytesIn == -1) 
				{ 
					break; 
				} 
				else 
				{ 
					fileOut.write(buf, 0, bytesIn); 
					fileReadAllLength += bytesIn;
				} 
			}
			fileOut.flush(); 
			fileOut.close();
			if(fileReadAllLength == file.length())
			{
				DBConnect dbc = new DBConnect();
				if(dbc.UpdateUploadFilePath(membersId,memberName, fileName.trim(), activityContent.trim()) == true)
					response.getWriter().write("上传成功!");
				else
					response.getWriter().write("数据更新失败!");
			}
			else
				response.getWriter().write("上传失败!");
		}
		return;
	}

}
