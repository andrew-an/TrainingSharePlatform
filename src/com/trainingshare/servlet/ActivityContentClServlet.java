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
		response.setCharacterEncoding("UTF-8");
		
		String activityContentBefore = request.getParameter("activityContentBefore");
		String activityContent = request.getParameter("activityContent");
		
		if(null != activityContentBefore && null != activityContent)
		{
			DBConnect dbc = new DBConnect();
			Boolean ret=false;
			ret = dbc.UpdateActivityContent(activityContentBefore, activityContent);	
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
		if(null != fileName)
		{
			BufferedInputStream fileIn = new BufferedInputStream(request.getInputStream()); 
			//String fn = (String)request.getParameter("fileName"); 
			String fn = URLDecoder.decode((String)request.getParameter("fileName"),"utf-8");
			//System.out.println(fn);  
			byte[] buf = new byte[1024];
			//接收文件上传并保存到 d:\
			File file = new File("d:/" + fn); 
			BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file));
			int fileReadAllLength = 0;//保存总共传输的字节数，判断文件是否全部传输完成
			while (true) 
			{ 
				// 读取数据
				int bytesIn = fileIn.read(buf, 0, 1024); 
				//System.out.println(bytesIn); 
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
			//System.out.print(file.getAbsolutePath()); 
			//System.out.print(file.length()+" ");
			//System.out.print(fileReadAllLength);
			if(fileReadAllLength == file.length())
				response.getWriter().write("上传成功！");
			else
				response.getWriter().write("上传失败！");
		}
		return;
	}

}
