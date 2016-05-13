package com.trainingshare.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.trainingshare.model.ActivityBean;
import com.trainingshare.model.UserInfoBean;

public class DBConnect {
    Connection ct = null;
    PreparedStatement psmt = null;
    public DBConnect()
    {
    	try{
    		Class.forName("com.mysql.jdbc.Driver");
    		String url = "jdbc:mysql://127.0.0.1:3306/trainShare";
    		ct = DriverManager.getConnection(url,"root","123456");
    	}
    	catch(Exception ex)
    	{
    		ex.printStackTrace();
    	}
    }
    
    //检查用户合法性
    public UserInfoBean checkUser(String username, String password)
    {
    	try{
    		psmt = ct.prepareStatement("select * from userinfo where UserName=?");
    		psmt.setString(1, username);
    		ResultSet rs = psmt.executeQuery();
    		if(rs.next())
    		{
    			String pwd = (String)rs.getString("Password");
    			if(pwd.equals(password))
    			{
    				UserInfoBean user = new UserInfoBean();
    				user.setId(Integer.parseInt(rs.getString(1)));
    				user.setWorkNumber(rs.getString(2));
    				user.setUserName(rs.getString(3));
    				user.setRealName(rs.getString(4));
    				user.setPassword(rs.getString(5));
    				user.setSex(rs.getString(6));
    				user.setEmail(rs.getString(7));
    				user.setRemark(rs.getString(8));
    				return user;
    			}
    		}
    	}
    	catch(Exception ex){
    		ex.printStackTrace();
    	}
		return null;
    }
    
    //返回活动列表
    public ArrayList GetActivityTitle()
    {
    	ArrayList al = new ArrayList();
    	try{
    		psmt = ct.prepareStatement("select Title, CompleteFlag from activity order by id desc");
    		//psmt.setString(1, username);
    		ResultSet rs = psmt.executeQuery();
    		while(rs.next())
    		{
				String title = rs.getString(1)+","+rs.getString(2);
				al.add(title);
    		}
    	}
    	catch(Exception ex){
    		ex.printStackTrace();
    	}
		return al;
    }
    
    //添加一个新活动信息
    public String AddNewAcivity(ActivityBean ab)
    {
        //psmt = ct.prepareStatement("insert activity values("+ab.getId()+ab.getTitle()+ab.getDetails()+ab.);
    	
    	//id;
        //private String title;
    	//private String details;
        //private int memberId;
        //private int meetingRomId;
        //private String startTime;
        //private String endTime;
        //private String remak;
        //private String recordTime;
    	return null;
    }
}
