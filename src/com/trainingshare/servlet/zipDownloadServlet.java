package com.trainingshare.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trainingshare.db.DBConnect;

/**
 * Servlet implementation class zipDownloadServlet
 */
@WebServlet("/zipDownloadServlet")
public class zipDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public zipDownloadServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		String activityId = request.getParameter("activityId");
		System.out.println(activityId);
		response.setContentType("APPLICATION/OCTET-STREAM");  
		response.setHeader("Content-Disposition","attachment; filename="+this.getZipFilename());  
		//System.out.println("in BatchDownload................");
		ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());
		DBConnect dbc = new DBConnect();
		ArrayList<String> al = dbc.GetAllTitleById(Integer.parseInt(activityId));
		if(al.size()>0)
		{
			int fileNums = 0;
			for(int i=0; i<al.size(); i++)
			{
				File file = new File(al.get(i));
				if(file.exists())
					fileNums++;
			}
			File[] files = new File[fileNums];
			for(int i=0; i<fileNums; i++)
			{
				files[i] = new File(al.get(i));
			}
			zipFile(files, "", zos);     
			zos.flush();
			zos.close();
		}
	}
	private void zipFile(File[] subs, String baseName, ZipOutputStream zos) throws IOException 
	{       
		for (int i=0;i<subs.length;i++) 
	    {  
			File f=subs[i];  
			zos.putNextEntry(new ZipEntry(baseName + f.getName()));     
			FileInputStream fis = new FileInputStream(f);     
			byte[] buffer = new byte[1024];     
			int r = 0;     
			while ((r = fis.read(buffer)) != -1) 
			{     
				zos.write(buffer, 0, r);
			}     
			fis.close();   
	    }  
	 }  
	 private String getZipFilename()
	 {  
		Date date=new Date();  
		String s=date.getTime()+".zip";  
		return s;  
	 } 
}
